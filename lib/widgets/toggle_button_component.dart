import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ToggleButtonComponent extends StatefulWidget {
  const ToggleButtonComponent({
    Key? key,
    required this.onChange,
    required this.textList,
    this.initialLabelIndex = 0,
  }) : super(key: key);

  final void Function(int index) onChange;
  final int initialLabelIndex;
  final List<String> textList;

  @override
  State<ToggleButtonComponent> createState() => _ToggleButtonComponentState();
}

class _ToggleButtonComponentState extends State<ToggleButtonComponent> {
  late int initialLabelIndex;
  late List<String> textList;

  @override
  void initState() {
    super.initState();
    initialLabelIndex = widget.initialLabelIndex;
    textList = widget.textList;
  }

  List<Widget> getBtns() {
    final childList = <Widget>[];

    textList.asMap().forEach(
      (key, value) {
        childList.add(_buildSingleBtn(key, value));
      },
    );
    return childList;
  }

  Widget _buildSingleBtn(int key, String value) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: InkWell(
        onTap: () => setState(() {
          initialLabelIndex = key;
          widget.onChange(initialLabelIndex);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(2),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: getBtns(),
        ),
      ),
    );
  }
}
