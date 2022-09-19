import 'package:cloud_firestore/cloud_firestore.dart';

class MyProductModel {
  String? productId;
  String? productName;
  String? productImage;
  double? productPrice;
  bool? isPurchase;
  String? status;
  String? riderId;
  MyProductModel(
      {this.isPurchase,
      this.productId,
      this.productImage,
      this.productName,
      this.productPrice,
      this.status,
      this.riderId});
  MyProductModel.fromSnapshot(DocumentSnapshot data) {
    isPurchase = data['is_purchase'];
    productPrice = data['product_price'] ?? '';
    productId = data['product_id'] ?? '';
    productImage = data['product_image'] ?? '';
    productName = data['product_name'] ?? '';
    status = data['status'] ?? "";
    riderId = data['rider_id'] ?? "";
  }
}
