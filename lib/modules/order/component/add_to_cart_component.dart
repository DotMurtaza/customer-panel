import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../model/product_model.dart';

class AddToCartComponent extends StatefulWidget {
  const AddToCartComponent({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  State<AddToCartComponent> createState() => _AddToCartComponentState();
}

class _AddToCartComponentState extends State<AddToCartComponent> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;
    const double height = 100;
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: borderColor)),
            ),
            height: height - 2,
            width: width / 2.7,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(4)),
              child: CustomImage(
                path: widget.product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  Utils.formatPrice(widget.product.price),
                  style: const TextStyle(
                      color: redColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                // const IncreaseDecreaseCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
