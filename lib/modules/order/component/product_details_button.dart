import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class ProductDetailsButton extends StatelessWidget {
  const ProductDetailsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: redColor),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text(
            'Details',
            style: TextStyle(fontSize: 14, height: 1, color: redColor),
          ),
        ),
      ),
    );
  }
}
