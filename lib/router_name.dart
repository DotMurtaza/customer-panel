import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/modules/order/home_screen.dart';
import 'package:foodbari_deliver_app/modules/order_history/order_history_screen.dart';
import 'modules/animated_splash_screen/animated_splash_screen.dart';
import 'modules/authentication/authentication_screen.dart';
import 'modules/authentication/forgot_screen.dart';
import 'modules/authentication/setpassword_screen.dart';
import 'modules/authentication/verification_code_screen.dart';
import 'modules/main_page/main_page.dart';
import 'modules/message/chat_list_screen.dart';
import 'modules/message/message_screen.dart';
import 'modules/notification/notigication_screen.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'modules/order/model/product_model.dart';
import 'modules/order/order_details_page.dart';
import 'modules/order/order_tracking_screen.dart';
import 'modules/profile/profile_edit_screen.dart';
import 'modules/setting/about_us_screen.dart';
import 'modules/setting/contact_us_screen.dart';
import 'modules/setting/faq_screen.dart';
import 'modules/setting/privacy_policy_screen.dart';
import 'modules/setting/terms_condition_screen.dart';

class RouteNames {
  static const String onboardingScreen = '/onboardingScreen';
  static const String animatedSplashScreen = '/animatedSplashScreen';
  static const String mainPage = '/';
  static const String homeScreen = '/homeScreen';
  static const String signInScreen = '/signInScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String messageScreen = '/messageScreen';
  static const String chatListScreen = '/chatListScreen';
  static const String singleCategoryProductScreen =
      '/singleCategoryProductScreen';
  static const String orderScreen = '/orderScreen';
  static const String orderDetailsPage = '/orderDetailsPage';
  static const String orderTrackingScreen = '/orderTrackingScreen';
  static const String termsConditionScreen = '/termsConditionScreen';
  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String faqScreen = '/faqScreen';
  static const String aboutUsScreen = '/aboutUsScreen';
  static const String contactUsScreen = '/contactUsScreen';
  static const String profileEditScreen = '/profileEditScreen';
  static const String forgotScreen = '/forgotScreen';
  static const String verificationCodeScreen = '/verificationCodeScreen';
  static const String setpasswordScreen = '/setpasswordScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case RouteNames.mainPage:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case RouteNames.animatedSplashScreen:
        return MaterialPageRoute(builder: (_) => const AnimatedSplashScreen());
      case RouteNames.signInScreen:
        return MaterialPageRoute(builder: (_) => const AuthenticationScreen());
      case RouteNames.forgotScreen:
        return MaterialPageRoute(builder: (_) => const ForgotScreen());
      case RouteNames.verificationCodeScreen:
        return MaterialPageRoute(
            builder: (_) => const VerificationCodeScreen());
      case RouteNames.setpasswordScreen:
        return MaterialPageRoute(builder: (_) => const SetpasswordScreen());

      case RouteNames.notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case RouteNames.messageScreen:
        return MaterialPageRoute(builder: (_) => const MessageScreen());
      case RouteNames.chatListScreen:
        return MaterialPageRoute(builder: (_) => const ChatListScreen());
      case RouteNames.orderScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteNames.orderDetailsPage:
        final productList = settings.arguments as List<ProductModel>;
        return MaterialPageRoute(builder: (_) => OrderHistoryScreen());
      case RouteNames.orderTrackingScreen:
        return MaterialPageRoute(builder: (_) => const OrderTrackingScreen());

      case RouteNames.termsConditionScreen:
        return MaterialPageRoute(builder: (_) => const TermsConditionScreen());
      case RouteNames.privacyPolicyScreen:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
      case RouteNames.faqScreen:
        return MaterialPageRoute(builder: (_) => const FaqScreen());
      case RouteNames.aboutUsScreen:
        return MaterialPageRoute(builder: (_) => const AboutUsScreen());
      case RouteNames.contactUsScreen:
        return MaterialPageRoute(builder: (_) => const ContactUsScreen());
      case RouteNames.profileEditScreen:
        return MaterialPageRoute(builder: (_) => const ProfileEditScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
