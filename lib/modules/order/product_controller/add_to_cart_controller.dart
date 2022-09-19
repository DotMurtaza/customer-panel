import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodbari_deliver_app/modules/authentication/controller/customer_controller.dart';
import 'package:foodbari_deliver_app/modules/authentication/models/customer_model.dart';
import 'package:foodbari_deliver_app/modules/order/model/my_product_model.dart';
import 'package:foodbari_deliver_app/modules/order/order_tracking_screen.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController {
  final auth = FirebaseAuth.instance;
  final firstore = FirebaseFirestore.instance;
  Rxn<List<MyProductModel>> productList = Rxn<List<MyProductModel>>();
  List<MyProductModel>? get product => productList.value;
  Rxn<List<MyProductModel>> overAllCartList = Rxn<List<MyProductModel>>();
  List<MyProductModel>? get getProverAllCartListoduct => productList.value;

  @override
  void onInit() {
    productList.bindStream(myCartStream());
    overAllCartList.bindStream(overAllCartStream());
    super.onInit();
  }

  Stream<List<MyProductModel>> myCartStream() {
    print("enter in all product stream funtion");
    print('id is:${auth.currentUser!.uid}');
    return firstore
        .collection('Customer')
        .doc(auth.currentUser!.uid)
        .collection("add_to_cart")
        .snapshots()
        .map((QuerySnapshot query) {
      List<MyProductModel> retVal = [];
      // print("query is:${query.docs.first.data()}");

      query.docs.forEach((element) {
        retVal.add(MyProductModel.fromSnapshot(element));
      });

      print('cart lenght is ${retVal.length}');
      return retVal;
    });
  }

  //send request to all riders
  Future<void> sendRequestToAllRiders(CustomerModel customerModel) async {
    // print("list is : ${productList.value!.length}");
    await firstore.collection("orders").add({
      'address': customerModel.address,
      'name': customerModel.name,
      'email': customerModel.email,
      'phone': customerModel.phone,
      'location': customerModel.location,
      'profileImage': customerModel.profileImage,
      'delivery_boy_id': '',
      'status': 'Pending',
      'time': Timestamp.now(),
      'customer_Id': Get.put(CustomerController()).user!.uid,
    }).then((value) async {
      for (int i = 0; i < productList.value!.length; i++) {
        print('i is $i');
        await firstore
            .collection("orders")
            .doc(value.id)
            .collection("products_order")
            .doc(productList.value![i].productId)
            .set({
          'is_purchase': productList.value![i].isPurchase,
          'product_price': productList.value![i].productPrice,
          'product_id': productList.value![i].productId,
          'product_image': productList.value![i].productImage,
          'product_name': productList.value![i].productName,
          'status': "Pending",
          'rider_id': '',
        }).then((value) {
          firstore
              .collection("products")
              .doc(productList.value![i].productId)
              .update({"status": "Pending"});
        });
      }
      await removeToCart();
    });
  }

  Future<void> removeToCart() async {
    for (int i = 0; i < overAllCartList.value!.length; i++) {
      firstore
          .collection("Customer")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("add_to_cart")
          .doc(productList.value![i].productId)
          .delete();
    }
  }

  Stream<List<MyProductModel>> overAllCartStream() {
    print("enter in all product stream funtion");
    print('id is:${auth.currentUser!.uid}');
    return firstore
        .collection('Customer')
        .doc(auth.currentUser!.uid)
        .collection("add_to_cart")
        // .where("status", isEqualTo: "InStock")
        .snapshots()
        .map((QuerySnapshot query) {
      List<MyProductModel> retVal = [];
      // print("query is:${query.docs.first.data()}");

      query.docs.forEach((element) {
        retVal.add(MyProductModel.fromSnapshot(element));
      });

      print('cart lenght is ${retVal.length}');
      return retVal;
    });
  }
}
