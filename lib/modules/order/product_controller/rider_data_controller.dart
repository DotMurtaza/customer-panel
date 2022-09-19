import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodbari_deliver_app/modules/order/model/place_oder_model.dart';
import 'package:foodbari_deliver_app/modules/order/model/rider_data_model.dart';
import 'package:get/get.dart';

class RiderDataController extends GetxController {
  final auth = FirebaseAuth.instance;
  final firstore = FirebaseFirestore.instance;
  Rxn<List<RiderDataModel>> riderList = Rxn<List<RiderDataModel>>();
  List<RiderDataModel>? get rider => riderList.value;
  Rxn<List<PlaceOrderModel>> placeOrderList = Rxn<List<PlaceOrderModel>>();
  List<PlaceOrderModel>? get placeOrder => placeOrderList.value;

  @override
  void onInit() {
    super.onInit();
    riderList.bindStream(riderDataStream());
  }

  void getPlaceOrderDetail(id) {
    placeOrderList.bindStream(placeOrderStream(id));
    print("list is:${placeOrderList}");
  }

//======================= Getting rider Details and distance =====================
  Stream<List<RiderDataModel>> riderDataStream() {
    return firstore
        .collection("Customer")
        .doc(auth.currentUser!.uid)
        .collection("accepted_order")
        .snapshots()
        .map((QuerySnapshot query) {
      List<RiderDataModel> retVal = [];

      query.docs.forEach((element) {
        retVal.add(RiderDataModel.fromSnapshot(element));
      });

      print('rider data lenght is ${retVal.length}');
      return retVal;
    });
  }

  //======================= Getting placed order detail =====================
  Stream<List<PlaceOrderModel>> placeOrderStream(String id) {
    return firstore
        .collection("Customer")
        .doc(auth.currentUser!.uid)
        .collection("accepted_order")
        .doc(id)
        .collection("accepted_order_products")
        .snapshots()
        .map((QuerySnapshot query) {
      List<PlaceOrderModel> retVal = [];

      // ignore: avoid_function_literals_in_foreach_calls
      query.docs.forEach((element) {
        retVal.add(PlaceOrderModel.fromSnapshot(element));
      });

      print('Differentiate ${retVal.length}');
      return retVal;
    });
  }
}
