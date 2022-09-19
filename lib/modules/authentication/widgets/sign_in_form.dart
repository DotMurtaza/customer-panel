import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/modules/authentication/controller/customer_controller.dart';
import 'package:foodbari_deliver_app/modules/main_page/main_page.dart';
import 'package:get/get.dart';
import '../../../../router_name.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/primary_button.dart';
import 'guest_button.dart';
import 'social_buttons.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({Key? key}) : super(key: key);

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  bool _checkBoxSelect = false;
  bool _passwordVisible = false;
  CustomerController authController = Get.put(CustomerController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 12),
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
          const SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
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
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
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
          const SizedBox(height: 8),
          _buildRememberMe(),
          const SizedBox(height: 25),
          PrimaryButton(
            text: 'Sign In',
            onPressed: () {
              authController.login(
                  emailController.text, passwordController.text, context);
              // Navigator.popUntil(context, (route) => route.isFirst);
              // Get.offAll(() => MainPage());
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Sign In With Social',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          const SocialButtons(),
          const SizedBox(height: 25),
          const GuestButton(),
        ],
      ),
    );
  }

  Widget _buildRememberMe() {
    return Row(
      children: [
        Flexible(
          child: CheckboxListTile(
            value: _checkBoxSelect,
            dense: true,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            contentPadding: EdgeInsets.zero,
            checkColor: Colors.white,
            activeColor: redColor,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              'Remember me',
              style: TextStyle(color: blackColor.withOpacity(.5)),
            ),
            onChanged: (bool? v) {
              if (v == null) return;
              setState(() {
                _checkBoxSelect = v;
              });
            },
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteNames.forgotScreen);
          },
          child: const Text(
            'Forgot password?',
            style: TextStyle(color: redColor),
          ),
        ),
      ],
    );
  }
}
