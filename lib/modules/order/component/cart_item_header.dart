import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class CartPageHeader extends StatelessWidget {
  const CartPageHeader({
    Key? key,
    required this.length,
  }) : super(key: key);
  final int length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          const Icon(Icons.shopping_cart_rounded, color: redColor),
          const SizedBox(width: 10),
          Text(
            "$length Items in your cart",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
