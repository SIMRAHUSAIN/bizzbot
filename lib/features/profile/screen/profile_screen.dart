// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_img/flutter_img.dart';
import 'package:mim_whatsup/features/login/model/login_model.dart';
import 'package:mim_whatsup/features/login/screen/login_screen.dart';
import 'package:mim_whatsup/utils/assets.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/app_bar.dart';

class ProfileScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  
  const ProfileScreen({Key? key, required this.loginSuccessModel}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarWithBackButton(
          title: Strings.profileAppBar,
          onLeadingPressed: () {},
          onSuffixPressed: () {},
        ),
      ),
      backgroundColor: cFFFFFF,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _getProfileImage(),
              // const SizedBox(height: 50),
              _getUserData(),
              _getDashlineSeparator(),
              _getLogOutBtn(),
            ],
          ),
        ),
      ),
    );
  }

  _getDashlineSeparator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: const Divider(
        color: c000000,
        height: 0.5, 
        thickness: 0.5,
        indent: 0, 
        endIndent: 0,
      ),
    );
  }

  _getProfileImage() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.32,
      height: MediaQuery.of(context).size.height * 0.32,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey
      ),
      child: widget.loginSuccessModel.profileImagePath != null 
      ? Image.network(
        widget.loginSuccessModel.profileImagePath!,
      ): const SizedBox.shrink(),
    );
  }

  _getUserData() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              Strings.userIdTtl,
              style: TextStyles.s16_w500_c374A5E
            ),
            Text(
              widget.loginSuccessModel == null 
              ? ''
              : widget.loginSuccessModel.wabaId!,
              style: TextStyles.s16_w700_c374A5E
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              Strings.wabaMobNo,
              style: TextStyles.s16_w500_c374A5E
            ),
            Text(widget.loginSuccessModel == null 
              ? ''
              : widget.loginSuccessModel.wabaMobileNumber!,
              style: TextStyles.s16_w700_c374A5E
            ),
          ],
        ),
      ],
    );
  }

  _getLogOutBtn() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => const LoginScreen()
        ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: Image.asset(
              ImageAssets.logOutIcon,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            Strings.logOutBtn,
            style: TextStyles.s14_w500_c374A5E
          ),
        ],
      ),
    );
  }
}