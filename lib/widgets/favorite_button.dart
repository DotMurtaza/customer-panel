import 'package:flutter/material.dart';

import '../utils/constants.dart'; 

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({Key? key, required this.productId}) : super(key: key);
  final int productId;
  final double height = 28;
  final bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: height,
        width: height,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: FittedBox(
            child: Icon(Icons.favorite, color: isFav ? favColor : borderColor)),
      ),
    );
  }
}
