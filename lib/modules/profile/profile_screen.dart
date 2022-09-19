import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodbari_deliver_app/modules/authentication/authentication_screen.dart';
import 'package:foodbari_deliver_app/modules/authentication/controller/customer_controller.dart';
import 'package:foodbari_deliver_app/modules/authentication/widgets/sign_in_form.dart';
import 'package:get/get.dart';
import '../../router_name.dart';
import '../../utils/k_images.dart';
import '../../widgets/custom_image.dart';
import 'component/profile_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  CustomerController controller = Get.put(CustomerController());
  @override
  Widget build(BuildContext context) {
    double appBarHeight = 174;
    final statusbar = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: appBarHeight,
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: Color(0x00000000)),
            flexibleSpace: ProfileAppBar(height: appBarHeight + statusbar),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  ListTile(
                    minLeadingWidth: 0,
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.notificationScreen);
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: const CustomImage(
                        path: Kimages.profileNotificationIcon),
                    title: const Text('Notification',
                        style: TextStyle(fontSize: 16)),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.chatListScreen);
                    },
                    minLeadingWidth: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: const CustomImage(path: Kimages.profileChatIcon),
                    title: const Text('Chats', style: TextStyle(fontSize: 16)),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.termsConditionScreen);
                    },
                    minLeadingWidth: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: const CustomImage(
                        path: Kimages.profileTermsConditionIcon),
                    title: const Text('Teams & Condition',
                        style: TextStyle(fontSize: 16)),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RouteNames.privacyPolicyScreen);
                    },
                    minLeadingWidth: 0,
                    contentPadding: EdgeInsets.zero,
                    leading:
                        const CustomImage(path: Kimages.profilePrivacyIcon),
                    title: const Text('Privacy Policy',
                        style: TextStyle(fontSize: 16)),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.faqScreen);
                    },
                    minLeadingWidth: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: const CustomImage(path: Kimages.profileFaqIcon),
                    title: const Text('FAQ', style: TextStyle(fontSize: 16)),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.aboutUsScreen);
                    },
                    minLeadingWidth: 0,
                    contentPadding: EdgeInsets.zero,
                    leading:
                        const CustomImage(path: Kimages.profileAboutUsIcon),
                    title:
                        const Text('About Us', style: TextStyle(fontSize: 16)),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.contactUsScreen);
                    },
                    minLeadingWidth: 0,
                    contentPadding: EdgeInsets.zero,
                    leading:
                        const CustomImage(path: Kimages.profileContactIcon),
                    title: const Text('Contact Us',
                        style: TextStyle(fontSize: 16)),
                  ),
                  const ListTile(
                    minLeadingWidth: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: CustomImage(path: Kimages.profileAppInfoIcon),
                    title: Text('App Info', style: TextStyle(fontSize: 16)),
                  ),
                  ListTile(
                    onTap: () {
                      // Navigator.of(context)
                      //     .pushReplacementNamed(RouteNames.signInScreen);
                      controller.signOut();
                      // Get.offAll(() => const AuthenticationScreen());
                    },
                    minLeadingWidth: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: const CustomImage(path: Kimages.profileLogOutIcon),
                    title:
                        const Text('Sign Out', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 65)),
        ],
      ),
    );
  }
}
