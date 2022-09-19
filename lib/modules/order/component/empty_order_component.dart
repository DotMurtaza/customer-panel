import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/primary_button.dart';

class EmptyOrderComponent extends StatelessWidget {
  const EmptyOrderComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Column(
        children: [
          const CustomImage(path: Kimages.emptyOrder),
          const SizedBox(height: 34),
          Text(
            'No Order Yet !',
            style: GoogleFonts.poppins(
                fontSize: 22, fontWeight: FontWeight.bold, height: 2),
          ),
          const SizedBox(height: 9),
          const Text(
            'You dont have a any order,\nPlease order Now',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: iconGreyColor, height: 1.5),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 200,
            child: PrimaryButton(text: 'Order Now', onPressed: () {}),
          )
        ],
      ),
    );
  }
}
