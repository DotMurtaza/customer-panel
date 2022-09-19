import 'package:flutter/material.dart';
import '../model/product_order_model.dart';
import 'empty_order_component.dart';
import 'single_order_details_component.dart';

class OrderedListComponent extends StatelessWidget {
  const OrderedListComponent({Key? key, required this.orderedList})
      : super(key: key);

  final List<OrderedProductModel> orderedList;

  @override
  Widget build(BuildContext context) {
    if (orderedList.isEmpty) {
      return const SliverToBoxAdapter(child: EmptyOrderComponent());
    }
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) =>
              SingleOrderComponent(orderItem: orderedList[index]),
          childCount: orderedList.length,
        ),
      ),
    );
  }
}
