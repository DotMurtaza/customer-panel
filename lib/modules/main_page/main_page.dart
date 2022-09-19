import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/Controllers/request_controller.dart';
import 'package:foodbari_deliver_app/modules/authentication/controller/customer_controller.dart';
import 'package:foodbari_deliver_app/modules/order/home_screen.dart';
import 'package:foodbari_deliver_app/modules/order/order_details_page.dart';
import 'package:get/get.dart';

import '../message/chat_list_screen.dart';
import '../order_history/order_history_screen.dart';
import '../profile/profile_screen.dart';
import 'component/bottom_navigation_bar.dart';
import 'main_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _homeController = MainController();

  late List<Widget> pageList;
  var customerController = Get.put(CustomerController());

  @override
  void initState() {
    super.initState();
    customerController.getProfileData();
    customerController.getCurrentLocation().then((value) async {
      await customerController.updateLocation();
    });
    Get.put(CustomerController()).getProfileData();

    pageList = [
      const HomeScreen(),
      // const ChatListScreen(),
      OrderDetailsPage(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // key: _homeController.scaffoldKey,
      // drawer: const DrawerWidget(),
      body: StreamBuilder<int>(
        initialData: 0,
        stream: _homeController.naveListener.stream,
        builder: (context, AsyncSnapshot<int> snapshot) {
          int index = snapshot.data ?? 0;
          return pageList[index];
        },
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
