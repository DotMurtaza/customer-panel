import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodbari_deliver_app/Controllers/request_controller.dart';
import 'package:foodbari_deliver_app/utils/constants.dart';
import 'package:foodbari_deliver_app/widgets/primary_button.dart';
import 'package:foodbari_deliver_app/widgets/rounded_app_bar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewRequestScreen extends StatefulWidget {
  const NewRequestScreen({Key? key}) : super(key: key);

  @override
  State<NewRequestScreen> createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  RequestController requestController = Get.put(RequestController());
  Future<Image> convertFileToImage(File picture) async {
    List<int> imageBase64 = picture.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    var image = Image.memory(uint8list);
    setState(() {
      requestController.requestImage = image as File;
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
        requestController.requestImage = imageTemporary;
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'New Request', isLeading: true),
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
            child: Form(
                key: key,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        GestureDetector(
                          onTap: () {
                            showOptionDialog(context);
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(15),
                            color: redColor,
                            strokeWidth: 2,
                            child: SizedBox(
                              height: size.height * 0.17,
                              width: size.width - 30,
                              child: requestController.requestImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.file(
                                        requestController.requestImage!,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    )
                                  : Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            CupertinoIcons.add_circled_solid,
                                            color: redColor,
                                          ),
                                          SizedBox(
                                            width: size.width * 0.02,
                                          ),
                                          const Text("Select Image")
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextFormField(
                          controller: requestController.titleController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Title';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Please Enter Title',
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextFormField(
                            maxLines: 5,
                            controller: requestController.descriptionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Discription';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Enter Discription...')),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: requestController.priceController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Price';
                            } else if (!GetUtils.isNum(value)) {
                              return "Invalid Price";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter Price (i.e 200.50)',
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        PrimaryButton(
                            text: "Submit Request",
                            onPressed: () {
                              if (requestController.requestImage != null) {
                                if (key.currentState!.validate()) {
                                  requestController.submitRequest(context);
                                }
                              } else {
                                Get.snackbar("Alert",
                                    "Please Select image of your product");
                              }
                            })
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }
}
