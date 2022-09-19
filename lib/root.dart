import 'package:flutter/cupertino.dart';
import 'package:foodbari_deliver_app/modules/authentication/controller/customer_controller.dart';
import 'package:foodbari_deliver_app/modules/main_page/main_page.dart';
import 'package:get/get.dart';

import 'modules/authentication/authentication_screen.dart';

class RootCustomer extends StatelessWidget {
  RootCustomer({Key? key}) : super(key: key);
  final userController = Get.put<CustomerController>(CustomerController());

  @override
  Widget build(BuildContext context) {
    return GetX<CustomerController>(
      initState: (_) {
        Get.put<CustomerController>(CustomerController());
      },
      builder: (_) {
        if (Get.find<CustomerController>().user != null) {
          return const MainPage();
        } else {
          return const AuthenticationScreen();
        }
      },
    );
  }
}
