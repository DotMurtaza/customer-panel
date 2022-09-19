import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/Controllers/request_controller.dart';
import 'package:foodbari_deliver_app/modules/authentication/controller/customer_controller.dart';
import 'package:foodbari_deliver_app/modules/order/model/get_offer_model.dart';
import 'package:foodbari_deliver_app/widgets/rounded_app_bar.dart';
import 'package:get/get.dart';

class ShowDeliveryBoyDetail extends StatelessWidget {
  ShowDeliveryBoyDetail({
    Key? key,
    // required this.getDetailRequestModel,
  }) : super(key: key);
  // final GetRequestModel getDetailRequestModel;
  RequestController requestController = Get.put(RequestController());
  CustomerController customerController = Get.put(CustomerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RoundedAppBar(
          isLeading: true,
          titleText: 'Delivery Boy Detail',
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Obx(
            () => requestController.getRequest == null
                ?const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: requestController.getRequest!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 12),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      requestController
                                          .getRequest![index].image!),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        requestController
                                            .getRequest![index].name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500)),
                                    Text(
                                        requestController
                                            .getRequest![index].email!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500)),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(requestController.getRequest![index].phone!,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                            Text(requestController.getRequest![index].address!,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal)),
                            Text(
                                'Far Away:${double.parse(
                                  calculateDistance(
                                          requestController.getRequest![index]
                                              .location!.latitude,
                                          requestController.getRequest![index]
                                              .location!.longitude,
                                          customerController.customerLat.value,
                                          customerController.customerLong.value)
                                      .toString(),
                                ).toStringAsFixed(2)} Km ',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 5,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ));
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
