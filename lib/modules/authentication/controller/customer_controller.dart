import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodbari_deliver_app/modules/authentication/authentication_screen.dart';
import 'package:foodbari_deliver_app/modules/authentication/models/customer_model.dart';
import 'package:foodbari_deliver_app/modules/main_page/main_page.dart';
import 'package:foodbari_deliver_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart';

class CustomerController extends GetxController {
  final auth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  Rxn<CustomerModel> customerModel = Rxn<CustomerModel>();
  File? customerImage;

  RxDouble customerLat = 0.0.obs;
  RxDouble customerLong = 0.0.obs;
  RxString customerAddress = "".obs;
  RxString customerPlaceName = "".obs;
  var riderLocationCity;

// <<<<<<<<===============For Auto signin  =================>>>>>>>>
  final Rxn<User> _firebaseUser = Rxn<User>();
  User? get user => _firebaseUser.value;
  final firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    _firebaseUser.bindStream(firebaseAuth.authStateChanges());
    super.onInit();
  }

  // <<<<<<<<===============create account function =================>>>>>>>>
  void signUpCustomer(
      {required String name,
      required String email,
      required String password,
      context}) async {
    Utils.showLoadingDialog(context, text: "Registration...");
    Map<String, dynamic> userInfo = {
      'name': name,
      'email': email,
      'location': const GeoPoint(0.0, 0.0),
      'profileImage': "",
      "address": "",
      "phone": ""
    };
    await auth
        .createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .then((value) {
      firebaseFirestore
          .collection('Customer')
          .doc(value.user!.uid)
          .set(userInfo)
          .then((value) {
        Get.back();
        Get.offAll(() => const MainPage());
      });
    }).catchError((e) {
      Get.back();
      Get.snackbar('Error', e.toString());
    });
  }

  // <<<<<<<<===============login account function =================>>>>>>>>

  void login(String email, String password, context) async {
    Utils.showLoadingDialog(context, text: "Login...");
    try {
      await auth
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) {
        Get.back();
        Get.offAll(() => const MainPage());
      });
    } catch (e) {
      Get.back();
      Get.snackbar("Alert", e.toString().split("] ").last);
    }
  }

  // <<<<<<<<===============forgot account function =================>>>>>>>>
  void forgotPassword(String email, context) async {
    Utils.showLoadingDialog(context, text: "Sending verification link...");
    try {
      await auth.sendPasswordResetEmail(email: email.trim()).then((value) {
        Get.snackbar('Link sent succcessfully',
            'Please check your email to reset password');
        Get.to(() => const AuthenticationScreen());
      });
    } catch (e) {
      Get.back();
      Get.snackbar('Error', e.toString().split("] ").last);
    }
  }
  // <<<<<<<<===============Get profile data function =================>>>>>>>>

  Future<void> getProfileData() async {
    // ignore: unused_local_variable
    var userData = firebaseFirestore
        .collection('Customer')
        .doc(auth.currentUser!.uid)
        .get()
        .then((doc) {
      if (doc.data() == null) {
        return null;
      } else {
        customerModel.value = CustomerModel.fromSnapshot(doc);
        return CustomerModel.fromSnapshot(doc);
      }
    });
  }

  // <<<<<<<<===============update Profile data function =================>>>>>>>>
  void updateProfile(
      {required String name, required String phone, context}) async {
    Utils.showLoadingDialog(context, text: "Updating...");
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('customer-profile-image')
          .child(auth.currentUser!.uid);
      await ref.putFile(customerImage!);
      final url = await ref.getDownloadURL();
      Map<String, dynamic> userInfo = {
        'phone': phone,
        'name': name,
        'profileImage': url,
      };
      await firebaseFirestore
          .collection('Customer')
          .doc(auth.currentUser!.uid)
          .update(userInfo);
      await getProfileData();
    } catch (e) {
      Get.back();
      Get.snackbar('Error', e.toString().split("] ").last);
    }
  }
  // <<<<<<<<===============get user location data function =================>>>>>>>>

  Future getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    customerLat.value = _locationData.latitude!;
    customerLong.value = _locationData.longitude!;
    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        _locationData.latitude!, _locationData.longitude!);
    var shopAddress = placemarks.first;

    // customerAddress.value = shopAddress.subLocality!;
    customerAddress.value = "${shopAddress.subLocality}"
        " ${shopAddress.street}"
        ", ${shopAddress.locality}"
        ", ${shopAddress.subLocality}"
        ", ${shopAddress.subAdministrativeArea}"
        ", ${shopAddress.administrativeArea}"
        ", ${shopAddress.thoroughfare}"
        ", ${shopAddress.country}";
    customerPlaceName.value = shopAddress.locality!;
    return shopAddress;
  }

// <<<<<<<<===============For location update data function =================>>>>>>>>
  Future<void> updateLocation() async {
    try {
      await firebaseFirestore
          .collection("Customer")
          .doc(auth.currentUser!.uid)
          .update({
        'address': customerAddress.value,
        "location": GeoPoint(customerLat.value, customerLong.value)
      });
      await getProfileData();
    } catch (e) {
      print(e);
      // Get.snackbar("Error", e.toString());
    }
  }

// <<<<<<<<===============Signout app function =================>>>>>>>>
  Future<void> signOut() async {
    await auth
        .signOut()
        .then((value) => {Get.offAll(() => const AuthenticationScreen())});
  }
}
