import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/Models/all_request_model.dart';
import 'package:foodbari_deliver_app/modules/authentication/controller/customer_controller.dart';
import 'package:foodbari_deliver_app/modules/authentication/models/customer_model.dart';
import 'package:foodbari_deliver_app/modules/order/model/get_offer_model.dart';
import 'package:foodbari_deliver_app/modules/order/model/rider_data_model.dart';
import 'package:foodbari_deliver_app/utils/utils.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  File? requestImage;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CustomerController customerController = Get.put(CustomerController());

  Rxn<List<GetRequestModel>> getRequestModel = Rxn<List<GetRequestModel>>();
  List<GetRequestModel>? get getRequest => getRequestModel.value;
  final firstore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  Future<void> submitRequest(context) async {
    Utils.showLoadingDialog(context, text: "Sending Request...");
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('customer-request-images')
          .child(customerController.auth.currentUser!.uid);
      await ref.putFile(requestImage!);
      final url = await ref.getDownloadURL();
      Map<String, dynamic> requestData = {
        'request_image': url,
        'title': titleController.text,
        'description': descriptionController.text,
        'price': double.parse(priceController.text),
        'status': "",
        "isComplete": false,
        "time": Timestamp.now(),
        "customer_id": customerController.auth.currentUser!.uid,
        "customer_name": customerController.customerModel.value!.name,
        "customer_address": customerController.customerModel.value!.address,
        "customer_location": customerController.customerModel.value!.location,
        "no_of_request": 0,
        "customer_image": customerController
                    .customerModel.value!.profileImage ==
                ""
            ? "https://cdn.techjuice.pk/wp-content/uploads/2015/02/wallpaper-for-facebook-profile-photo-1024x645.jpg"
            : customerController.customerModel.value!.profileImage,
        "delivery_boy_id": ""
      };
      await _firestore.collection('all_requests').add(requestData);
      Get.back();
      Utils.showCustomDialog(context,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 100,
              child: Column(
                children: [
                  const Icon(
                    CupertinoIcons.checkmark_circle_fill,
                    color: Colors.green,
                  ),
                  const Text("Request Send"),
                  TextButton(
                      onPressed: () {
                        requestImage = null;
                        titleController.clear();
                        descriptionController.clear();
                        priceController.clear();
                        Get.back();
                      },
                      child: const Text("Ok"))
                ],
              ),
            ),
          ));
    } catch (e) {
      Get.back();
      Get.snackbar("Error", e.toString().split("] ").last);
    }
  }

  Rxn<List<AllRequestModel>> offerList = Rxn<List<AllRequestModel>>();
  List<AllRequestModel>? get offers => offerList.value;
  @override
  void onInit() {
    offerList.bindStream(receiveOfferStream());

    super.onInit();
  }

  Stream<List<AllRequestModel>> receiveOfferStream() {
    print("receive offer stream funtion ${customerController.user!.uid}");
    return _firestore
        .collection('all_requests')
        .where("customer_id", isEqualTo: customerController.user!.uid)
        .where("status", isEqualTo: "Pending")
        .snapshots()
        .map((QuerySnapshot query) {
      List<AllRequestModel> retVal = [];

      for (var element in query.docs) {
        retVal.add(AllRequestModel.fromSnapshot(element));
      }

      debugPrint('offer   lenght is ${retVal.length}');
      return retVal;
    });
  }

// <================== Request that we get from rider after sent request ===========================>
  Future<void> getDetailRider(String id) async {
    getRequestModel.bindStream(receiveOfferDetailStream(id));
  }

  Stream<List<GetRequestModel>> receiveOfferDetailStream(String id) {
    print("receive offer stream funtion ${customerController.user!.uid}");
    return _firestore
        .collection('all_requests')
        .doc(id)
        .collection('received_offer')
        .snapshots()
        .map((QuerySnapshot query) {
      List<GetRequestModel> retVal = [];

      for (var element in query.docs) {
        retVal.add(GetRequestModel.fromSnapshot(element));
      }

      debugPrint('offer   lenght is ${retVal.length}');
      return retVal;
    });
  }

  Rxn<List<AllRequestModel>> orderStatusList = Rxn<List<AllRequestModel>>();
  List<AllRequestModel>? get orderStatus => orderStatusList.value;
  void getOrderStatus(String status) {
    orderStatusList.bindStream(orderStatusScreen(status));
    super.onInit();
  }

  Stream<List<AllRequestModel>> orderStatusScreen(String status) {
    return FirebaseFirestore.instance
        .collection('all_requests')
        .where("customer_id",
            isEqualTo: Get.find<CustomerController>().user!.uid)
        .where("status", isEqualTo: status)
        .snapshots()
        .map((QuerySnapshot query) {
      List<AllRequestModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(AllRequestModel.fromSnapshot(element));
      }
      print('status lenght is ${retVal.length}');
      return retVal;
    });
  }

  Future<void> cancelRequest(String id, String deliveryBoyId) async {
    await firstore.collection("all_requests").doc(id).update({
      "status": "Cancelled",
      "delivery_boy_id": deliveryBoyId,
    });
  }

  Future<void> onTheWayRequest(String id, String deliveryBoyId) async {
    await firstore.collection("all_requests").doc(id).update({
      "status": "On the way",
      "delivery_boy_id": deliveryBoyId,
    });
  }

  Rxn<RiderDataModel> customerModel = Rxn<RiderDataModel>();

  Future<void> getRiderDetails(String id) async {
    var doc = await firstore.collection("delivery_boy").doc(id).get();
    customerModel.value = RiderDataModel.fromSnapshot(doc);
  }

  Future<void> completeDelivery(String id) async {
    await firstore
        .collection("all_requests")
        .doc(id)
        .update({"isComplete": false, "status": "Completed"});
  }
}
