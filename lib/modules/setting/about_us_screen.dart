import 'package:flutter/material.dart';

import '../../widgets/rounded_app_bar.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'About Us'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Text(
            'TOPCOMMERCE, as the best e-commerce mobile app development company, builds mighty on-demand e-commerce applications to mobilize your business. Our e-commerce application development services are highly reliable and of world-class quality. With a team of experts, we craft the best ever mobile applications to support your online business. E-commerce mobile apps have become an important medium for sales.',
            textAlign: TextAlign.justify,
            style: TextStyle(height: 1.71),
          ),
        ],
      ),
    );
  }
}
