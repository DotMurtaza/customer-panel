import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/rounded_app_bar.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Contact Us'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Send Us A Message',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, height: 1.5),
            ),
            const SizedBox(height: 9),
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Rayahan Quaikw',
                fillColor: borderColor.withOpacity(.10),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                fillColor: borderColor.withOpacity(.10),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Phone',
                fillColor: borderColor.withOpacity(.10),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Subject',
                fillColor: borderColor.withOpacity(.10),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Messsage',
                fillColor: borderColor.withOpacity(.10),
              ),
              minLines: 5,
              maxLines: null,
            ),
            const SizedBox(height: 20),
            PrimaryButton(text: 'Sand Now', onPressed: () {})
          ],
        ),
      ),
    );
  }
}
