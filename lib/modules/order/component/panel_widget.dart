import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/modules/authentication/controller/customer_controller.dart';
import 'package:foodbari_deliver_app/modules/order/model/my_product_model.dart';
import 'package:foodbari_deliver_app/modules/order/order_tracking_screen.dart';
import 'package:foodbari_deliver_app/modules/order/product_controller/add_to_cart_controller.dart';
import 'package:foodbari_deliver_app/modules/order/product_controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slidable_button/slidable_button.dart';
import '../../../utils/constants.dart';

class PannelCollapsComponent extends StatefulWidget {
  const PannelCollapsComponent({
    Key? key,
    required this.height,
  }) : super(key: key);
  final double height;

  @override
  State<PannelCollapsComponent> createState() => _PannelCollapsComponentState();
}

class _PannelCollapsComponentState extends State<PannelCollapsComponent> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 14),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
            height: 4,
            width: 60,
          ),
          const SizedBox(height: 12),
          // _BottomWidget(
          //   price1: '0.0',
          //   productModeldata: ,
          // ),
        ],
      ),
    );
  }
}

class _BottomWidget extends StatelessWidget {
  _BottomWidget({
    Key? key,
    required this.price1,
  }) : super(key: key);
  final String price1;
  AddToCartController addToCartController = Get.put(AddToCartController());
  @override
  Widget build(BuildContext context) {
    double getTotal() =>
        addToCartController.productList.value!.fold(0, (total, item) {
          double price = item.productPrice!;
          // ignore: unnecessary_null_comparison
          if (price != null) {
            return total + price;
          } else {
            return total;
          }
        });

    return Obx(() => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price:',
                  style: TextStyle(
                      fontSize: 18, height: 1.16, fontWeight: FontWeight.w600),
                ),
                addToCartController.productList.value!.isEmpty
                    ?
                    //   Icon(CupertinoIcons.down_arrow),
                    Text(
                        '0.0',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    : Text(
                        '${getTotal() + 50}',
                        style: const TextStyle(
                            fontSize: 18,
                            height: 1.16,
                            fontWeight: FontWeight.w600),
                      )
              ],
            ),
            const SizedBox(height: 16),
            IgnorePointer(
              ignoring: false,
              child: SlidableButton(
                height: 52,
                width: MediaQuery.of(context).size.width,
                buttonWidth: 50.0,
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                buttonColor: redColor,
                dismissible: false,
                border: Border.all(color: borderColor),
                label: const Center(
                    child: Icon(Icons.double_arrow_sharp, color: Colors.white)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Swipe to Confirm Delivery',
                        style: GoogleFonts.roboto(
                            color: redColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                disabledColor: Colors.grey,
                initialPosition: SlidableButtonPosition.left,
                onChanged: (position) {
                  // print(position);
                  // setState(() {
                  if (position == SlidableButtonPosition.right) {
                    addToCartController
                        .sendRequestToAllRiders(
                      Get.put(CustomerController()).customerModel.value!,
                    )
                        .then((value) {
                      Get.to(() => OrderTrackingScreen());
                    });
                    // Get.to(() => const OrderTrackingScreen());
                    // result = 'Button is on the right';
                  } else {
                    // result = 'Button is on the left';
                  }
                  // });
                },
              ),
            ),
          ],
        ));
  }
}

class PanelComponent extends StatefulWidget {
  PanelComponent({
    Key? key,
    this.controller,
  }) : super(key: key);

  final ScrollController? controller;
  @override
  State<PanelComponent> createState() => _PanelComponentState();
}

class _PanelComponentState extends State<PanelComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.controller,
      padding: const EdgeInsets.only(top: 16, bottom: 14, left: 20, right: 20),
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
            height: 4,
            width: 60,
          ),
        ),
        const SizedBox(height: 25),
        Text(
          'Bill Details',
          style: GoogleFonts.roboto(
              fontSize: 20, height: 1.15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        SizedBox(
          child: GetX<AddToCartController>(
              init: Get.put<AddToCartController>(AddToCartController()),
              builder: (AddToCartController controller) {
                double getTotal() =>
                    controller.productList.value!.fold(0, (total, item) {
                      double price = item.productPrice!;
                      // ignore: unnecessary_null_comparison
                      if (price != null) {
                        return total + price;
                      } else {
                        return total;
                      }
                    });
                if (controller.productList.value == null) {
                  return Text('No item found please add to cart first',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Colors.black));
                } else {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Subtotal',
                            style: TextStyle(fontSize: 16, height: 1.62),
                          ),
                          Text(
                            "\$ " + getTotal().toString(),
                            style: const TextStyle(fontSize: 16, height: 1.62),
                          ),
                        ],
                      ),
                      const SizedBox(height: 9),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Delivery Fee',
                            style: TextStyle(fontSize: 16, color: greenColor),
                          ),
                          Text(
                            '\$50.00',
                            style: TextStyle(fontSize: 16, color: greenColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(height: 1, color: borderColor),
                      const SizedBox(height: 16),
                      _BottomWidget(
                        price1: controller.productList.value == null
                            ? "0.0"
                            : "${getTotal() + 50}",
                      ),
                    ],
                  );
                }
              }),
        )
      ],
    );
  }
}
