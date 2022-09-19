import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/constants.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/rounded_app_bar.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Add New Address'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'New Address',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, height: 1.5),
            ),
            const SizedBox(height: 9),
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Rayahan Quaikw',
                fillColor: borderColor.withOpacity(.10),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                fillColor: borderColor.withOpacity(.10),
                hintText: 'Street Address',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                hintText: 'Hosue Number',
                fillColor: borderColor.withOpacity(.10),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Flexible(child: playListField()),
                const SizedBox(width: 20),
                Flexible(
                  child: TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      hintText: 'Zip Code',
                      fillColor: borderColor.withOpacity(.10),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Phone',
                fillColor: borderColor.withOpacity(.10),
              ),
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              value: true,
              activeColor: redColor,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                'Please check again and confim your address',
                style: TextStyle(
                    fontSize: 14,
                    color: blackColor.withOpacity(0.5),
                    fontWeight: FontWeight.w400),
              ),
              onChanged: (v) {},
            ),
            const SizedBox(height: 30),
            PrimaryButton(text: 'Add Address', onPressed: () {})
          ],
        ),
      ),
    );
  }

  Widget playListField() {
    return DropdownButtonFormField<String>(
      value: 'Ok',
      hint: const Text('Playlist'),
      decoration: InputDecoration(
        isDense: true,
        fillColor: borderColor.withOpacity(.10),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      onChanged: (value) {},
      validator: (value) => value == null ? 'field required' : null,
      isDense: true,
      isExpanded: true,
      items: ['Ok', "Hello"].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
