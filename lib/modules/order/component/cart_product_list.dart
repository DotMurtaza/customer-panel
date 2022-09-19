import 'package:flutter/material.dart';
import '../model/product_model.dart';
import 'add_to_cart_component.dart';

class CartProductList extends StatelessWidget {
  const CartProductList({
    Key? key,
    required this.populerProductList,
  }) : super(key: key);
  final List<ProductModel> populerProductList;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return AddToCartComponent(product: populerProductList[index]);
        },
        childCount: populerProductList.length,
        addAutomaticKeepAlives: true,
      ),
    );
  }
}
