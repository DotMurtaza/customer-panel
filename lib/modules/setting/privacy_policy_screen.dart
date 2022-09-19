import 'package:flutter/material.dart';

import '../../widgets/rounded_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Privacy Policy'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildTerms(),
          _buildTerms(),
          _buildTerms(),
          _buildTerms(),
        ],
      ),
    );
  }

  Widget _buildTerms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 10),
        Text(
          'Introduction:',
          style:
              TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        Text(
          'the event the User commits an Authorization Breach, the User shall be liable to pay the liquidated damages of an amount equivalent to the Order Value. The User must undertake to authorize FDP to deduct or collect the amount payable as liquidating damages through such means as Food Delivery Platform may determine in its discretion, including without limitation, by deducting such amount from the payment made towards User’s next order.',
          style: TextStyle(color: Color(0xff85959E), height: 1.71),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
