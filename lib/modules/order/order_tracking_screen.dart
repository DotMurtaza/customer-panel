import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/modules/authentication/controller/customer_controller.dart';
import 'package:foodbari_deliver_app/modules/order/model/rider_data_model.dart';
import 'package:foodbari_deliver_app/modules/order/place_order_screen.dart';
import 'package:foodbari_deliver_app/modules/order/product_controller/add_to_cart_controller.dart';
import 'package:foodbari_deliver_app/modules/order/product_controller/rider_data_controller.dart';
import 'package:foodbari_deliver_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/rounded_app_bar.dart';
import 'dart:math' show cos, sqrt, asin;

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({Key? key}) : super(key: key);

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  RiderDataController riderDataController = Get.put(RiderDataController());
  CustomerController customerController = Get.put(CustomerController());
  AddToCartController addToCartController = Get.put(AddToCartController());
  final _initPos = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  late Marker marker;

  @override
  void initState() {
    Get.put(RiderDataController());
    marker = Marker(
      onDrag: (latLng) {
        addMarker(latLng);
      },
      markerId: const MarkerId('init-id'),
      draggable: true,
      position: const LatLng(37.42796133580664, -122.085749655962),
    );

    super.initState();
  }

  final panelController = PanelController();

  Future<void> addMarker(LatLng latLng) async {
    marker = Marker(
      onDrag: (latLng) {
        addMarker(latLng);
      },
      markerId: const MarkerId('init-id'),
      draggable: true,
      position: latLng,
    );
    final _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: latLng,
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    setState(() {});
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  Widget build(BuildContext context) {
    const double height = 90;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: RoundedAppBar(titleText: 'Oder Tracking', isLeading: true),
      body: SlidingUpPanel(
        controller: panelController,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        // panel: const PanelComponent(),
        panelBuilder: (sc) => _BottomSheetWidget(scrollController: sc),
        minHeight: height,
        maxHeight: 300,
        backdropEnabled: true,
        backdropTapClosesPanel: true,
        parallaxEnabled: true,
        backdropOpacity: .0,

        collapsed: const OrderCollapsComponent(height: height),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: GetX(
              init: Get.put<RiderDataController>(RiderDataController()),
              builder: (RiderDataController controller) {
                if (controller != null && controller.rider != null) {
                  return ListView.builder(
                      itemCount: controller.rider!.length,
                      itemBuilder: (context, index) {
                        RiderDataModel riderData = controller.rider![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.all(12),
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: borderColor),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //_buildProductHeader(),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     // Column(
                                //     //   crossAxisAlignment:
                                //     //       CrossAxisAlignment.start,
                                //     //   children: const [
                                //     //     Text(
                                //     //       'Order Date',
                                //     //       style: TextStyle(
                                //     //           height: 1, color: redColor),
                                //     //     ),

                                //     //     SizedBox(height: 8),
                                //     //     // InVoiceWidget(text: orderStatus.invoice),
                                //     //   ],
                                //     // ),
                                //     // Column(
                                //     //   crossAxisAlignment:
                                //     //       CrossAxisAlignment.end,
                                //     //   children: [
                                //     //     Text(
                                //     //       Utils.formatDate(
                                //     //           orderStatus.time!.toDate()),
                                //     //       style: const TextStyle(
                                //     //           height: 1, color: paragraphColor),
                                //     //     ),
                                //     //     const SizedBox(height: 1),
                                //     //   ],
                                //     // )
                                //   ],
                                // ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          riderData.rider_name!.toUpperCase(),
                                          style: const TextStyle(
                                              height: 1, color: paragraphColor),
                                        ),
                                        Text(
                                          riderData.rider_phone.toString(),
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              height: 1,
                                              color: redColor),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: const [
                                        CircleAvatar(
                                            radius: 25,
                                            backgroundImage: AssetImage(
                                                "assets/images/profile.jpg")),

                                        SizedBox(height: 1),
                                        // Text(
                                        //   orderStatus.time.toString(),
                                        //   style:
                                        //   GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
                                        // )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Customer Address',
                                      style:
                                          TextStyle(height: 1, color: redColor),
                                    ),
                                    Text(
                                      riderData.rider_address!,
                                      style: const TextStyle(
                                          height: 1,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Rider Current Distance',
                                      style:
                                          TextStyle(height: 1, color: redColor),
                                    ),
                                    // Text(customerController.riderLocationCity),
                                    Text(
                                      "${double.parse(
                                        calculateDistance(
                                          riderData.rider_location!.latitude,
                                          riderData.rider_location!.longitude,
                                          customerController.customerLat.value,
                                          customerController.customerLong.value,
                                        ).toString(),
                                      ).toStringAsFixed(2)} KM",
                                      style: const TextStyle(
                                          height: 1,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 14),
                                PrimaryButton(
                                  minimumSize: const Size(double.infinity, 40),
                                  fontSize: 16,
                                  grediantColor: const [blackColor, blackColor],
                                  text: 'View Details',
                                  onPressed: () async {
                                    riderDataController
                                        .getPlaceOrderDetail(riderData.id);
                                    Get.to(() => PlaceOrderScreen());
                                    // orderController
                                    //     .getCustomerProduct(orderStatus.id!);
                                    //Get.log("lenght is here  : ${orderController.customerProducts!.length}");
                                    // Navigator.pushNamed(context, RouteNames.orderDetailsPage,
                                    //     arguments: );
                                    // Get.to(() => OrderDetailsPage(
                                    //       customerModel: orderStatus,
                                    //     ));
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: Text("No order to show yet"),
                  );
                }
              }),
          // child: GoogleMap(
          //   mapType: MapType.hybrid,
          //   onLongPress: addMarker,
          //   // myLocationButtonEnabled: true,
          //   compassEnabled: true,
          //   zoomControlsEnabled: false,

          //   myLocationEnabled: true,
          //   initialCameraPosition: _initPos,
          //   markers: {marker},
          //   onMapCreated: (GoogleMapController controller) {
          //     _controller.complete(controller);
          //   },
          // ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}

class OrderCollapsComponent extends StatelessWidget {
  const OrderCollapsComponent({
    Key? key,
    required this.height,
  }) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 14),
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
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tracking Order",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Invoice : GR-44234",
                    style: TextStyle(color: redColor),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Arrived in",
                    style: TextStyle(color: paragraphColor),
                  ),
                  Text(
                    "14 : 32",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomSheetWidget extends StatelessWidget {
  const _BottomSheetWidget({
    Key? key,
    required this.scrollController,
  }) : super(key: key);
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      controller: scrollController,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tracking Order",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Invoice : GR-44234",
                  style: TextStyle(color: redColor, fontSize: 18),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Arrived in",
                  style: TextStyle(fontSize: 18, color: paragraphColor),
                ),
                Text(
                  "14 : 32",
                  style: GoogleFonts.poppins(
                      fontSize: 30, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(height: 1, color: borderColor),
        const SizedBox(height: 16),
        Row(
          children: [
            const CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(Kimages.kNetworkImage),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Rayaha Jakes Omar",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "3.9",
                        style: TextStyle(color: inputColor, fontSize: 18),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.blue,
              ),
              child: const Icon(
                Icons.wechat_rounded,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.green,
              ),
              child: const Icon(
                Icons.call,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
              minimumSize: const Size(200, 52),
              text: 'Got my Order',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        )
      ],
    );
  }
}
