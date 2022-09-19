import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../dummy_data/all_dymmy_data.dart';
import '../../utils/constants.dart';
import '../../widgets/app_bar_leading.dart';
import 'component/faq_app_bar.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    const double appBarHeight = 120;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: appBarHeight,
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: redColor),
            title: Text(
              'FAQ',
              style: TextStyle(color: Colors.white),
            ),
            titleSpacing: 0,
            leading: AppbarLeading(),
            flexibleSpace: FaqAppBar(height: appBarHeight),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),

          SliverToBoxAdapter(
            child: ExpansionPanelList(
              expansionCallback: ((panelIndex, isExpanded) {
                faqList.asMap().forEach((key, value) {
                  faqList[key].isExpanded = false;
                });
                faqList[panelIndex].isExpanded = !isExpanded;
                setState(() {});
              }),
              expandedHeaderPadding: EdgeInsets.zero,
              dividerColor: borderColor.withOpacity(.4),
              elevation: 0,
              children: faqList
                  .map(
                    (e) => ExpansionPanel(
                      isExpanded: e.isExpanded,
                      backgroundColor:
                          e.isExpanded ? redColor.withOpacity(.1) : null,
                      canTapOnHeader: true,
                      headerBuilder: (_, bool isExpended) => ListTile(
                        title: Text(e.title, maxLines: 1),
                        // contentPadding: EdgeInsets.zero,
                      ),
                      body: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(e.question),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (context, index) {
          //       return Column(
          //         children: [
          //           Theme(
          //             data: ThemeData()
          //                 .copyWith(dividerColor: Colors.transparent),
          //             child: ExpansionTile(
          //               backgroundColor: redColor.withOpacity(.1),
          //               title: const Text(
          //                 'vehicles[i].title',
          //                 style: TextStyle(
          //                     fontSize: 20.0,
          //                     fontWeight: FontWeight.bold,
          //                     fontStyle: FontStyle.italic),
          //               ),
          //               // childrenPadding: EdgeInsets.zero,
          //               // tilePadding: EdgeInsets.zero,
          //               iconColor: blackColor,
          //               textColor: blackColor,
          //               collapsedTextColor: blackColor,
          //               expandedAlignment: Alignment.topLeft,
          //               expandedCrossAxisAlignment: CrossAxisAlignment.start,
          //               children: const <Widget>[
          //                 Text('Hekfjjfgfdjg'),
          //               ],
          //             ),
          //           ),
          //           Container(height: 1, color: borderColor.withOpacity(.4)),
          //         ],
          //       );
          //     },
          //     childCount: 15,
          //   ),
          // ),
        ],
      ),
    );
  }
}
