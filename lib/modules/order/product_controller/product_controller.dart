import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/modules/order/model/my_product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final auth = FirebaseAuth.instance;
  final firstore = FirebaseFirestore.instance;
  Rxn<List<MyProductModel>> productList = Rxn<List<MyProductModel>>();
  List<MyProductModel>? get product => productList.value;
  TextEditingController seaechController = TextEditingController();
  RxString searchProduct = "".obs;
  @override
  void onInit() {
    productList.bindStream(allProductStream());
    super.onInit();
  }

// <<<<<<<<===============getting all product stream from firebase function =================>>>>>>>>
  Stream<List<MyProductModel>> allProductStream() {
    print("enter in all product stream funtion");
    return firstore
        .collection('products')
        .snapshots()
        .map((QuerySnapshot query) {
      List<MyProductModel> retVal = [];

      query.docs.forEach((element) {
        retVal.add(MyProductModel.fromSnapshot(element));
      });

      print('products lenght is ${retVal.length}');
      return retVal;
    });
  }
// <<<<<<<<===============creating subcollection for pass to add to cart screen =================>>>>>>>>

  Future<void> addToCart(String productId, MyProductModel product) async {
    print('Add Id is:${product.productId}');
    print('Product is:$productId');
    await firstore
        .collection("Customer")
        .doc(auth.currentUser!.uid)
        .collection("add_to_cart")
        .doc(productId)
        .set({
      'is_purchase': product.isPurchase,
      'product_id': product.productId,
      'product_image': product.productImage,
      'product_name': product.productName,
      'product_price': product.productPrice,
      'status': product.status,
      'rider_id': product.riderId,
    }).then((value) {
      firstore.collection("products").doc(productId).update({
        "is_purchase": true,
      });
    });
  }
// <<<<<<<<=============== Removing item from cart =================>>>>>>>>

  Future<void> removeFromCart(String productId, MyProductModel product) async {
    print("product id is: ${product.productId}");
    await firstore
        .collection("Customer")
        .doc(auth.currentUser!.uid)
        .collection("add_to_cart")
        .doc(productId)
        .delete()
        .then((value) {
      firstore.collection("products").doc(productId).update({
        "is_purchase": false,
      });
      Get.snackbar("Deleted", "Your item is successfully removed");
    });
  }
}
