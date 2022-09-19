import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/modules/authentication/controller/customer_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/primary_button.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  TextEditingController emailController = TextEditingController();
  CustomerController controller = Get.put(CustomerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomRight,
              stops: [.5, 1],
              colors: [
                Colors.white,
                Color(0xffFFEFE7),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CircleAvatar(
                radius: 96,
                child: const CustomImage(
                  path: Kimages.forgotIcon,
                  color: redColor,
                ),
                backgroundColor: redColor.withOpacity(0.1),
              ),
              const SizedBox(height: 55),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Forget Password',
                  style: GoogleFonts.poppins(
                      height: 1, fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 22),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter username or email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Username or email',
                ),
              ),
              const SizedBox(height: 28),
              PrimaryButton(
                text: 'Send Code',
                onPressed: () {
                  controller.forgotPassword(emailController.text, context);
                  // Navigator.pushReplacementNamed(
                  //     context, RouteNames.verificationCodeScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
