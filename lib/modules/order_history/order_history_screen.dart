import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../dummy_data/all_dymmy_data.dart';
import '../../utils/constants.dart';
import '../order/component/order_app_bar.dart';
import 'components/ordered_history_list_component.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double appBarHeight = 174;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: appBarHeight,
            expandedHeight: appBarHeight,
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: redColor),
            flexibleSpace: OrderAppBar(height: appBarHeight),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          OrderedHistoryListComponent(orderedList: orderProductList),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
