import 'package:flutter/material.dart';
import 'package:mim_whatsup/features/login/screen/login_screen.dart';
import 'package:mim_whatsup/utils/assets.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/solid_button.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({Key? key}) : super(key: key);

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.2, 0.9],
            colors: [
              c577D91,
              cFFFFFF,
            ]
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: _getBodyContent(),
      ),
    );
  }

  _getBodyContent() {
    return Column(
      children: [
        _getAppIcon(),
        _getBodyTxt(),
        _getStartedBtn(),
      ],
    );
  }

  _getAppIcon() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 120, bottom: 20),
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Image.asset(
          ImageAssets.splashScreenPng,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  _getBodyTxt() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Strings.splshscrnTxt1,
          style: TextStyles.s22_w700_c000000,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 25),
        Text(
          Strings.splshscrnTxt2,
          style: TextStyles.s20_w400_cA8A3A3,
        ),
      ],
    );
  }

  _getStartedBtn() {
    return Container(
      margin: const EdgeInsets.only(top: 45),
      child: SoliButton(
        text: Strings.getStartedBtn,
        backgroundColor: cAAD4E7,
        textColor: c000000,
        textStyle: TextStyles.s16_w800,
        verticalSpacing: 15,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
      ),
    );
  }
}