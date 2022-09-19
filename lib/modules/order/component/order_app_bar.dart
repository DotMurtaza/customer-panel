import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/modules/authentication/controller/customer_controller.dart';
import 'package:foodbari_deliver_app/modules/order/product_controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../../router_name.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/k_images.dart';
import '../../../../widgets/custom_image.dart';

class OrderAppBar extends StatefulWidget {
  final double height;

  OrderAppBar({Key? key, this.height = 140}) : super(key: key);

  @override
  State<OrderAppBar> createState() => _OrderAppBarState();
}

class _OrderAppBarState extends State<OrderAppBar> {
  var authController = Get.put(CustomerController());
  TextEditingController searchController = TextEditingController();
  ProductController controller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            SizedBox(height: widget.height, width: media.size.width),
            const Positioned(
              left: -21,
              top: -74,
              child: CircleAvatar(
                radius: 105,
                backgroundColor: redColor,
              ),
            ),
            Positioned(
              left: -31,
              top: -113,
              child: CircleAvatar(
                radius: 105,
                backgroundColor: Colors.white.withOpacity(0.06),
              ),
            ),
            Positioned(
              left: -33,
              top: -156,
              child: CircleAvatar(
                radius: 105,
                backgroundColor: Colors.white.withOpacity(0.06),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // SizedBox(height: 60 - statusbarPadding),
                    _buildappBarButton(context),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xff333333)
                                        .withOpacity(.18),
                                    blurRadius: 70),
                              ],
                            ),
                            child: TextFormField(
                              controller: controller.seaechController,
                              onChanged: (val) {
                                controller.searchProduct.value = val;
                                setState(() {});
                                //return null;
                              },
                              decoration: inputDecorationTheme.copyWith(
                                prefixIcon: const Icon(Icons.search_rounded,
                                    color: grayColor, size: 26),
                                hintText: 'Search your products',
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                              color: redColor,
                              borderRadius: BorderRadius.circular(4)),
                          margin: const EdgeInsets.only(right: 8),
                          height: 52,
                          width: 44,
                          child: const Center(
                            child: CustomImage(
                              path: Kimages.menuIcon,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildappBarButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLocation(),
                const Spacer(),
                FlutterSwitch(
                  width: 100.0,
                  height: 37.0,
                  valueFontSize: 18.0,
                  toggleSize: 27.0,
                  value: false,
                  borderRadius: 30.0,
                  padding: 4.0,
                  activeColor: redColor,
                  inactiveColor: redColor,
                  activeTextColor: Colors.white,
                  inactiveTextColor: Colors.white,
                  activeText: 'Online',
                  inactiveText: 'Offline',
                  showOnOff: true,
                  onToggle: (val) {},
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.notificationScreen);
                  },
                  child: Badge(
                    position: const BadgePosition(top: -5, end: -3),
                    badgeContent: const Text(
                      '3',
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                    child: const Icon(Icons.notifications,
                        size: 28, color: paragraphColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return GestureDetector(
      onTap: () async {
        await authController.getCurrentLocation().then((value) async {
          await authController.updateLocation();
        });
      },
      child: Row(
        children: [
          const Icon(
            Icons.my_location_outlined,
            color: Colors.white,
          ),
          const SizedBox(width: 5),
          authController.customerModel.value == null
              ? Obx(
                  () => authController.customerAddress == null
                      ? Text(
                          'Get Location',
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        )
                      : Container(
                          width: 150,
                          child: Text(
                            authController.customerModel.value!.address!,
                            style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                )
              : SizedBox(),
          // const Icon(
          //   Icons.keyboard_arrow_down_outlined,
          //   color: Colors.white,
          // )
        ],
      ),
    );
  }
}
