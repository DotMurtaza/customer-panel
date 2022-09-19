import 'package:cloud_firestore/cloud_firestore.dart';

class RiderDataModel {
  String? id;
  String? rider_address;
  String? rider_email;
  GeoPoint? rider_location;
  String? rider_name;
  String? rider_phone;
  String? profileImage;
  RiderDataModel({
    this.id,
    this.rider_address,
    this.rider_email,
    this.rider_location,
    this.rider_name,
    this.profileImage,
    this.rider_phone,
  });
  RiderDataModel.fromSnapshot(DocumentSnapshot data) {
    id = data.id;
    profileImage = data["profileImage"] ?? "";
    rider_address = data['delivery_boy_address'] ?? '';
    rider_email = data['email'] ?? '';
    rider_location = data['location'] ?? '';
    rider_name = data['name'] ?? '';
    rider_phone = data['phoneNo'] ?? '';
  }
}
