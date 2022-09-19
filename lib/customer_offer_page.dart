import 'package:flutter/material.dart';
import 'package:foodbari_deliver_app/widgets/primary_button.dart';

class CustomerOfferPage extends StatelessWidget {
  const CustomerOfferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
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
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(''),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Customer Name',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                            Text('8:30 AM',
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
                    Text('Customer Offer Title',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    Text(
                        'Customer Offer Description This text is dummy text for only testing because gm have keera so thats why i made this screen MOTHERFUCKER!!!!!',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.normal)),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.currency_exchange,
                          size: 18,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        Text('\$1500',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PrimaryButton(text: 'Send Offer', onPressed: () {}),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
