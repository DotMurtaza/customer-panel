import 'package:cloud_firestore/cloud_firestore.dart';

class AllRequestModel {
  String? id;
  String? customer_address;
  String? customer_id;
  String? customer_image;
  GeoPoint? customer_location;
  String? customer_name;
  String? delivery_boy_id;
  String? description;
  double? price;
  String? request_image;
  String? status;
  Timestamp? time;
  bool? isCompleted;
  String? title;
  int? noOfRequest;
  AllRequestModel({
    this.isCompleted,
    this.noOfRequest,
    this.id,
    this.customer_address,
    this.customer_id,
    this.customer_image,
    this.customer_location,
    this.customer_name,
    this.delivery_boy_id,
    this.description,
    this.price,
    this.request_image,
    this.status,
    this.time,
    this.title,
  });
  AllRequestModel.fromSnapshot(DocumentSnapshot data) {
    id = data.id;
    isCompleted = data['isComplete'] ?? false;
    noOfRequest = data['no_of_request'] ?? 0;
    customer_address = data['customer_address'] ?? '';
    customer_id = data['customer_id'] ?? '';
    customer_image = data['customer_image'] ?? '';
    customer_location = data['customer_location'] ?? const GeoPoint(0.0, 0.0);
    customer_name = data['customer_name'] ?? '';
    delivery_boy_id = data['delivery_boy_id'] ?? '';
    description = data['description'] ?? '';
    price = data['price'] ?? 0.0;
    request_image = data['request_image'] ?? '';
    status = data['status'] ?? false;
    time = data['time'] ?? Timestamp.now();
    title = data['title'] ?? '';
  }
}
