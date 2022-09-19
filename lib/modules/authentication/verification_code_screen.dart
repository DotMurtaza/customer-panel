import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../../../router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/primary_button.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
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
                  path: Kimages.verificationCodeIcon,
                  color: redColor,
                ),
                backgroundColor: redColor.withOpacity(0.1),
              ),
              const SizedBox(height: 55),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Verification Code',
                  style: GoogleFonts.poppins(
                      height: 1, fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 22),
              Pinput(
                defaultPinTheme: PinTheme(
                  height: 52,
                  width: 52,
                  textStyle:
                      GoogleFonts.poppins(fontSize: 26, color: blackColor),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsRetrieverApi,
              ),
              const SizedBox(height: 28),
              PrimaryButton(
                text: 'Continue',
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, RouteNames.setpasswordScreen);
                },
              ),
              const SizedBox(height: 15),
              const Text.rich(
                TextSpan(
                  text: 'I dont’t recived a code ? ',
                  style: TextStyle(color: Color(0xff878D97)),
                  children: [
                    TextSpan(
                      text: 'Please resend',
                      style: TextStyle(color: Color(0xff000000)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
