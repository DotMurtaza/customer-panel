import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:foodbari_deliver_app/Controllers/request_controller.dart';
import 'package:foodbari_deliver_app/modules/authentication/controller/customer_controller.dart';
import 'package:foodbari_deliver_app/modules/order/model/my_product_model.dart';
import 'package:foodbari_deliver_app/modules/order/product_controller/product_controller.dart';
import 'package:foodbari_deliver_app/router_name.dart';
import 'package:foodbari_deliver_app/utils/k_images.dart';
import 'package:foodbari_deliver_app/utils/utils.dart';
import 'package:foodbari_deliver_app/widgets/custom_image.dart';
import 'package:foodbari_deliver_app/widgets/primary_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../dummy_data/all_dymmy_data.dart';
import '../../utils/constants.dart';
import '../../widgets/toggle_button_component.dart';
import 'component/order_app_bar.dart';
import 'component/ordered_list_component.dart';
import 'model/product_order_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var authController = Get.put(CustomerController());
  ProductController productController = Get.put(ProductController());
  RequestController orderController = Get.put(RequestController());
  @override
  void initState() {
    Get.put(ProductController());
    Get.put(RequestController());
    orderController.getOrderStatus("Completed");
    super.initState();
  }

  var initialLabelIndex = 0;
  final list = [
    'Completed',
    'Pending',
    'On the way',
    'Cancelled',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const double appBarHeight = 174;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("My Delivery Request"),
      // ),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: appBarHeight,
            expandedHeight: appBarHeight,
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: redColor),
            flexibleSpace: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  // SizedBox(height: widget.height, width: media.size.width),
                  const Positioned(
                    left: -21,
                    top: -74,
                    child: CircleAvatar(
                      radius: 120,
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
                    top: 50,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // SizedBox(height: 60 - statusbarPadding),
                          _buildappBarButton(context),
                          // Row(
                          //   children: [
                          //     Flexible(
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //           color: Colors.transparent,
                          //           boxShadow: [
                          //             BoxShadow(
                          //                 color: const Color(0xff333333)
                          //                     .withOpacity(.18),
                          //                 blurRadius: 70),
                          //           ],
                          //         ),
                          //         child: TextFormField(
                          //           //  controller:authController. ,
                          //           onChanged: (val) {
                          //             productController.searchProduct.value =
                          //                 val;
                          //             setState(() {});
                          //             //return null;
                          //           },
                          //           decoration: inputDecorationTheme.copyWith(
                          //             prefixIcon: const Icon(
                          //                 Icons.search_rounded,
                          //                 color: grayColor,
                          //                 size: 26),
                          //             hintText: 'Search your products',
                          //             contentPadding:
                          //                 const EdgeInsets.symmetric(
                          //               vertical: 12,
                          //               horizontal: 16,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     const SizedBox(width: 8),
                          //     Container(
                          //       decoration: BoxDecoration(
                          //           color: redColor,
                          //           borderRadius: BorderRadius.circular(4)),
                          //       margin: const EdgeInsets.only(right: 8),
                          //       height: 52,
                          //       width: 44,
                          //       child: const Center(
                          //         child: CustomImage(
                          //           path: Kimages.menuIcon,
                          //           color: Colors.white,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  height: 36,
                  //s  width: 120,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSingleBtn(0, list[0]),
                      _buildSingleBtn(1, list[1]), //nope
                      _buildSingleBtn(2, list[2]),
                      _buildSingleBtn(3, list[3])
                    ],
                  ),
                ),
                SizedBox(
                    height: size.height / 1.5,
                    child: GetX<RequestController>(
                        builder: (RequestController orderController) {
                      if (orderController.orderStatus == null ||
                          orderController.orderStatus!.isEmpty) {
                        return const Center(
                          child: Text("No order found"),
                        );
                      } else {
                        return ListView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 55),
                            shrinkWrap: true,
                            itemCount: orderController.orderStatus!.length,
                            itemBuilder: (context, index) {
                              var orderStatus =
                                  orderController.orderStatus![index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.all(12),
                                  // height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: borderColor),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //_buildProductHeader(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'Order Date',
                                                style: TextStyle(
                                                    height: 1, color: redColor),
                                              ),

                                              SizedBox(height: 8),
                                              // InVoiceWidget(text: orderStatus.invoice),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                Utils.formatDate(
                                                    orderStatus.time!.toDate()),
                                                style: const TextStyle(
                                                    height: 1,
                                                    color: paragraphColor),
                                              ),
                                              const SizedBox(height: 1),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Row(
                                              //   children: [
                                              //     Text(
                                              //       "Customer Name: "
                                              //           .toUpperCase(),
                                              //       style: const TextStyle(
                                              //           height: 1,
                                              //           color: paragraphColor),
                                              //     ),
                                              //     Text(
                                              //       orderStatus.customer_name!
                                              //           .toUpperCase(),
                                              //       style: const TextStyle(
                                              //           height: 1,
                                              //           color: paragraphColor),
                                              //     ),
                                              //   ],
                                              // ),
                                              const SizedBox(height: 10),
                                              SizedBox(
                                                width: Get.width * 0.6,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Title: ",
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          height: 1,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      orderStatus.title
                                                          .toString(),
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          height: 1,
                                                          color: redColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              SizedBox(
                                                width: Get.width * 0.6,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Description: ",
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          height: 1,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      orderStatus.description
                                                          .toString(),
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          height: 1,
                                                          color: redColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              SizedBox(
                                                width: Get.width * 0.8,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Price: ",
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          height: 1,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      "\$ ${orderStatus.price.toString()}",
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                          height: 1,
                                                          color: redColor),
                                                    ),
                                                    // const Spacer(),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          orderStatus.request_image != ""
                                              ? CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: NetworkImage(
                                                      orderStatus
                                                          .customer_image!),
                                                )
                                              : const CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: AssetImage(
                                                      "assets/images/profile.jpg")),
                                          const SizedBox(height: 1),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(children: [
                                        orderStatus.isCompleted == true
                                            ? const Icon(
                                                Icons.timelapse_rounded,
                                                color: Colors.yellow,
                                              )
                                            : const SizedBox(),
                                        orderStatus.isCompleted == true
                                            ? const Text("Request for Complete")
                                            : const SizedBox()
                                      ]),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     const Text(
                                      //       'Customer Address',
                                      //       style: TextStyle(
                                      //           height: 1, color: redColor),
                                      //     ),
                                      //     Text(
                                      //       orderStatus.customer_address!,
                                      //       style: const TextStyle(
                                      //           height: 1,
                                      //           color: Colors.black,
                                      //           fontWeight: FontWeight.bold),
                                      //     ),
                                      //   ],
                                      // ),
                                      const SizedBox(height: 14),
                                      // PrimaryButton(
                                      //   minimumSize:
                                      //       const Size(double.infinity, 40),
                                      //   fontSize: 16,
                                      //   grediantColor: const [
                                      //     blackColor,
                                      //     blackColor
                                      //   ],
                                      //   text: 'View Details',
                                      //   onPressed: () async {
                                      //     // orderController
                                      //     //     .getre(orderStatus.id!);
                                      //     // //Get.log("lenght is here  : ${orderController.customerProducts!.length}");
                                      //     // // Navigator.pushNamed(context, RouteNames.orderDetailsPage,
                                      //     // //     arguments: );
                                      //     // Get.to(() => OrderDetailsPage(
                                      //     //       customerModel: orderStatus,
                                      //     //     ));
                                      //   },
                                      // ),
                                      initialLabelIndex == 1
                                          ? const SizedBox()
                                          : PrimaryButton(
                                              text: "View Detail",
                                              onPressed: () async {
                                                await orderController
                                                    .getRiderDetails(orderStatus
                                                        .delivery_boy_id!);

                                                print(
                                                    "now get id${(orderStatus.delivery_boy_id!)}");
                                                Get.bottomSheet(
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.0,
                                                            vertical:
                                                                Get.height *
                                                                    0.05),
                                                    child: Container(
                                                      // padding:
                                                      //     EdgeInsets.all(16),
                                                      height: Get.height * 0.37,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  radius: 25,
                                                                  backgroundImage: orderController
                                                                              .customerModel
                                                                              .value
                                                                              ?.profileImage !=
                                                                          ""
                                                                      ? NetworkImage(orderController
                                                                          .customerModel
                                                                          .value!
                                                                          .profileImage!)
                                                                      : const NetworkImage(
                                                                          "https://cdn.techjuice.pk/wp-content/uploads/2015/02/wallpaper-for-facebook-profile-photo-1024x645.jpg"),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      orderController
                                                                          .customerModel
                                                                          .value!
                                                                          .rider_name!,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .subtitle1!
                                                                          .copyWith(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w600),
                                                                    ),
                                                                    Text(
                                                                      orderController
                                                                          .customerModel
                                                                          .value!
                                                                          .rider_phone!,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .caption!
                                                                          .copyWith(
                                                                              color: Colors.grey,
                                                                              fontWeight: FontWeight.normal),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              orderController
                                                                  .customerModel
                                                                  .value!
                                                                  .rider_email!,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                orderController
                                                                    .customerModel
                                                                    .value!
                                                                    .rider_address!,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption!
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Full Address State to State',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .caption!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                            ),
                                                            const SizedBox(
                                                                height: 20),
                                                            const Spacer(),
                                                            orderStatus.isCompleted ==
                                                                    true
                                                                ? SizedBox(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        const Text(
                                                                            "Rider has complete the delivery can you confirm that?"),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            TextButton(
                                                                                onPressed: () {
                                                                                  Get.back();
                                                                                },
                                                                                child: const Text("Cancel")),
                                                                            TextButton(
                                                                                onPressed: () {
                                                                                  orderController.completeDelivery(orderStatus.id!);
                                                                                  Get.back();
                                                                                  Utils().showRatingAppDialog(context);
                                                                                },
                                                                                child: const Text("Verify")),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                : PrimaryButton(
                                                                    text:
                                                                        "See More",
                                                                    onPressed:
                                                                        () {}),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    })),
              ],
            ),

            //     GetX(
            //   init: Get.put<ProductController>(ProductController()),
            //   builder: ((ProductController controller) {
            //     if (controller != null && controller.product != null) {
            //       return ListView.builder(
            //           physics: const NeverScrollableScrollPhysics(),
            //           shrinkWrap: true,
            //           itemCount: controller.product!.length,
            //           itemBuilder: ((context, index) {
            //             MyProductModel products = controller.product![index];
            //             return controller.product![index].productName!
            //                     .toUpperCase()
            //                     .contains(controller.searchProduct.toUpperCase())
            //                 ? Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Container(
            //                       width: size.width * 0.95,
            //                       decoration: BoxDecoration(
            //                         color: Colors.white,
            //                         borderRadius: BorderRadius.circular(12),
            //                         border: Border.all(color: Colors.grey),
            //                       ),
            //                       child: Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           ClipRRect(
            //                             borderRadius: const BorderRadius.only(
            //                                 topLeft: Radius.circular(12),
            //                                 topRight: Radius.circular(12)),
            //                             child: SizedBox(
            //                               height: size.height * 0.2,
            //                               width: size.width,
            //                               child: Image.network(
            //                                 products.productImage!,
            //                                 fit: BoxFit.cover,
            //                                 height: size.height * 0.2,
            //                               ),
            //                             ),
            //                           ),
            //                           const SizedBox(
            //                             height: 8,
            //                           ),
            //                           Padding(
            //                             padding: const EdgeInsets.all(8.0),
            //                             child: Column(
            //                               crossAxisAlignment:
            //                                   CrossAxisAlignment.start,
            //                               children: [
            //                                 SizedBox(
            //                                   width: size.width,
            //                                   child: Text(
            //                                     products.productName!,
            //                                     maxLines: 2,
            //                                     style: Theme.of(context)
            //                                         .textTheme
            //                                         .subtitle1!
            //                                         .copyWith(
            //                                           color: Colors.black,
            //                                           fontWeight: FontWeight.w600,
            //                                         ),
            //                                   ),
            //                                 ),
            //                                 const SizedBox(
            //                                   height: 4,
            //                                 ),
            //                                 Text(
            //                                   products.productPrice.toString(),
            //                                   style: Theme.of(context)
            //                                       .textTheme
            //                                       .subtitle1!
            //                                       .copyWith(
            //                                         color: Colors.red,
            //                                         fontWeight: FontWeight.bold,
            //                                       ),
            //                                 ),
            //                                 const SizedBox(
            //                                   height: 12,
            //                                 ),
            //                                 Row(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment.spaceBetween,
            //                                   children: [
            //                                     Flexible(
            //                                       child: PrimaryButton(
            //                                         minimumSize: const Size(
            //                                             double.infinity, 40),
            //                                         fontSize: 16,
            //                                         grediantColor: const [
            //                                           blackColor,
            //                                           blackColor
            //                                         ],
            //                                         text: 'Details',
            //                                         onPressed: () {},
            //                                       ),
            //                                     ),
            //                                     const SizedBox(width: 16),
            //                                     // products.isPurchase == false
            //                                     //     ?
            //                                     Flexible(
            //                                       child: PrimaryButton(
            //                                         minimumSize: const Size(
            //                                             double.infinity, 40),
            //                                         fontSize: 16,
            //                                         grediantColor: const [
            //                                           redColor,
            //                                           redColor
            //                                         ],
            //                                         text: 'Buy',
            //                                         onPressed: () {
            //                                           productController.addToCart(
            //                                             products.productId!,
            //                                             products,
            //                                           );
            //                                           Get.snackbar('Success',
            //                                               'Your item ${products.productName} is successfully added');
            //                                           print(
            //                                               "Id is here  : ${products.productId}");
            //                                         },
            //                                       ),
            //                                     )
            //                                     // : GestureDetector(
            //                                     //     onTap: () {
            //                                     // productController
            //                                     //     .removeFromCart(
            //                                     //   products.productId!,
            //                                     //   products,
            //                                     // );
            //                                     //     },
            //                                     //     child: Container(
            //                                     //       padding:
            //                                     //           const EdgeInsets
            //                                     //               .all(8),
            //                                     //       decoration: BoxDecoration(
            //                                     //           color: Colors.red,
            //                                     //           borderRadius:
            //                                     //               BorderRadius
            //                                     //                   .circular(
            //                                     //                       12)),
            //                                     //       child: Column(
            //                                     //         children: const [
            //                                     //           Text(
            //                                     //             'Remove Item',
            //                                     //             style: TextStyle(
            //                                     //                 color: Colors
            //                                     //                     .white),
            //                                     //           ),
            //                                     //           Icon(
            //                                     //             Icons.delete,
            //                                     //             color:
            //                                     //                 Colors.white,
            //                                     //             size: 17,
            //                                     //           ),
            //                                     //         ],
            //                                     //       ),
            //                                     //     ),
            //                                     //   ),
            //                                   ],
            //                                 )
            //                               ],
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   )
            //                 : const SizedBox();
            //           }));
            //     } else {
            //       return const Padding(
            //         padding: EdgeInsets.all(8.0),
            //         child: Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       );
            //     }
            //   }),
            // )
          ),
        ],
      ),
    );
  }

  Widget _buildSingleBtn(int key, String value) {
    return Flexible(
      // flex: 1,
      fit: FlexFit.tight,
      child: InkWell(
        onTap: () => setState(() {
          initialLabelIndex = key;
          orderController.getOrderStatus(value);
          print("index is here : $initialLabelIndex");
          // widget.onChange(initialLabelIndex);
        }),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: initialLabelIndex == key ? redColor : Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
          child: FittedBox(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: initialLabelIndex != key ? blackColor : Colors.white,
              ),
            ),
          ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLocation(),
                // const Spacer(),

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
        print('object');
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
          authController.customerModel.value!.address != null
              ? Obx(
                  () => authController.customerModel.value!.address == null &&
                          authController.customerModel.value!.address == ""
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
              : Text(
                  'Get Location',
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
          // const Icon(
          //   Icons.keyboard_arrow_down_outlined,
          //   color: Colors.white,
          // )
        ],
      ),
    );
  }
}
