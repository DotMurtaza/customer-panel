import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/primary_button.dart';

class SetpasswordScreen extends StatefulWidget {
  const SetpasswordScreen({Key? key}) : super(key: key);

  @override
  State<SetpasswordScreen> createState() => _SetpasswordScreenState();
}

class _SetpasswordScreenState extends State<SetpasswordScreen> {
  bool _passwordVisible = false;
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
                  'Set Password',
                  style: GoogleFonts.poppins(
                      height: 1, fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 22),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Password';
                  }
                  return null;
                },
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: grayColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Password';
                  }
                  return null;
                },
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: grayColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 28),
              PrimaryButton(
                text: 'Set Password',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteNames.mainPage, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
