import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/k_images.dart';
import 'custom_image.dart';
import 'primary_button.dart';

class DummyDialogs extends StatefulWidget {
  const DummyDialogs({Key? key}) : super(key: key);

  @override
  State<DummyDialogs> createState() => _DummyDialogsState();
}

class _DummyDialogsState extends State<DummyDialogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F5F7),
      appBar: AppBar(
        title: const Text('dialog'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          OrderSuccess(
            btnText: 'Order Status',
            image: Kimages.orderSuccess,
            title: 'Thanks for your valuble\nFeedback !',
            text: 'Thank you for your help and quick delivery which enable',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({
    Key? key,
    required this.image,
    required this.title,
    required this.text,
    required this.btnText,
    this.onTap,
    this.totalHeight = 550,
  }) : super(key: key);
  final String image;
  final String title;
  final String btnText;
  final String text;
  final VoidCallback? onTap;
  final double totalHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: totalHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImage(path: image),
          const SizedBox(height: 70),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 22, height: 1.5, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(fontSize: 16, color: inputColor),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: PrimaryButton(
              text: btnText,
              onPressed: () {
                if (onTap != null) onTap!.call();
              },
            ),
          )
        ],
      ),
    );
  }
}
