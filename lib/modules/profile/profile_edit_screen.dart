import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../utils/constants.dart';
import '../../widgets/app_bar_leading.dart';
import 'component/profile_edit_app_bar.dart';
import 'component/profile_edit_form.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final double appBarHeight = 230;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: appBarHeight,
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: redColor),
            title: const Text(
              'Profile Edit',
              style: TextStyle(color: Colors.white),
            ),
            titleSpacing: 0,
            leading: const AppbarLeading(),
            flexibleSpace: ProfileEditAppBar(height: appBarHeight),
          ),
          SliverToBoxAdapter(child: ProfielEditForm()),
        ],
      ),
    );
  }
}
