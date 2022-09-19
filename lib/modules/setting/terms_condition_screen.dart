import 'package:flutter/material.dart';

import '../../widgets/rounded_app_bar.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Teams & Condition'),
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
          '1. Eligibility:',
          style:
              TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        Text(
          'The User must undertake to adhere to the eligibility to enter into a contract in view of section 11 of The Indian Contract Act, 1872. The User shall agree to represent and warrant that the User is at the age of 18',
          style: TextStyle(color: Color(0xff85959E), height: 1.71),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
