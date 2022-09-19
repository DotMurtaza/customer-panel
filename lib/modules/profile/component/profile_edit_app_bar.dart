import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodbari_deliver_app/modules/authentication/controller/customer_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/custom_image.dart';

class ProfileEditAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;

  const ProfileEditAppBar({
    Key? key,
    this.onTap,
    this.height = 82,
  }) : super(key: key);
  final VoidCallback? onTap;

  @override
  State<ProfileEditAppBar> createState() => _ProfileEditAppBarState();

  @override
  Size get preferredSize => throw UnimplementedError();
}

class _ProfileEditAppBarState extends State<ProfileEditAppBar> {
  // Image? myImage;
  CustomerController controller = Get.put(CustomerController());

  Future<Image> convertFileToImage(File picture) async {
    List<int> imageBase64 = picture.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    var image = Image.memory(uint8list);
    setState(() {
      controller.customerImage = image as File;
    });
    // print('MY image is $myImage');
    return image;
  }

  Future pickImage(ImageSource sr) async {
    try {
      final image = await ImagePicker().pickImage(source: sr);
      if (image == null) {}
      final imageTemporary = File(image!.path);
      setState(() {
        controller.customerImage = imageTemporary;
        (File(image.path));
        print('The image is${(File(image.path))}');
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('failed to pick image: $e');
    }
  }

  showOptionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          //for picking video functionality
          SimpleDialogOption(
            onPressed: () {
              pickImage(ImageSource.gallery);
              Get.back();
            },
            child: Row(
              children: [
                const Icon(Icons.image, color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text('Gallery',
                      style: Theme.of(context).textTheme.subtitle1!),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              pickImage(ImageSource.camera);
              Get.back();
            },
            child: Row(
              children: [
                const Icon(Icons.camera_alt, color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text('Camera',
                      style: Theme.of(context).textTheme.subtitle1!),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Get.back(),
            child: Row(
              children: [
                const Icon(Icons.cancel, color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text('Cancel',
                      style: Theme.of(context).textTheme.subtitle1!),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: SizedBox(
          height: widget.height,
          child: Stack(
            children: [
              Container(
                height: widget.height - 80,
                decoration: const BoxDecoration(
                  color: redColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xff333333).withOpacity(.18),
                          blurRadius: 70),
                    ],
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        controller.customerImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  controller.customerImage!,
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: 150,
                                ),
                              )
                            : controller.customerModel.value!.profileImage != ""
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      controller
                                          .customerModel.value!.profileImage!,
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const CircleAvatar(
                                    radius: 70,
                                    backgroundImage: NetworkImage(
                                        "https://cdn.techjuice.pk/wp-content/uploads/2015/02/wallpaper-for-facebook-profile-photo-1024x645.jpg"),
                                  ),

                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(100),
                        //   child: controller.customerImage != null
                        //       ? Container(
                        //           height: 170,
                        //           width: 170,
                        //           decoration: const BoxDecoration(
                        //             shape: BoxShape.circle,
                        //           ),
                        //           child: Image.file(controller.customerImage!),
                        //         )
                        //       : const CustomImage(
                        //           path: Kimages.kNetworkImage,
                        //           height: 170,
                        //           width: 170,
                        //         ),
                        // ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: GestureDetector(
                            onTap: () {
                              showOptionDialog(context);
                            },
                            child: const CircleAvatar(
                              backgroundColor: Color(0xff18587A),
                              child: Icon(Icons.edit, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(widget.height);
}
