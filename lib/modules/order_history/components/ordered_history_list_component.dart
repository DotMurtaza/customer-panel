import 'package:flutter/material.dart';
import '../../order/component/empty_order_component.dart';
import '../../order/model/product_order_model.dart';
import 'single_order_history_component.dart';

class OrderedHistoryListComponent extends StatelessWidget {
  const OrderedHistoryListComponent({Key? key, required this.orderedList})
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
              SingleOrderHistoryComponent(orderItem: orderedList[index]),
          childCount: orderedList.length,
        ),
      ),
    );
  }
}
