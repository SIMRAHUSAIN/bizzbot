import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mim_whatsup/features/login/screen/login_screen.dart';
import 'package:mim_whatsup/home_screen.dart';
import 'package:mim_whatsup/utils/assets.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/global_variables.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/solid_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({Key? key}) : super(key: key);

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {

  @override
  void initState() {
    super.initState();
    navigateTo(context);
  }

  void navigateTo(context) async {
    var prefs = await SharedPreferences.getInstance();
    
    var isLoggedIn = prefs.getBool("LoggedIn");
    final tokenData = prefs.getString("Token");
    final userId = prefs.getString("Id");
    final userPassword = prefs.getString("Password");
    if(tokenData != null){
      GlobalVar.globalToken = tokenData;
    }
    if(userId != null){
      GlobalVar.userId = userId;
    }
    if(userPassword != null){
      GlobalVar.userPassword = userPassword;
    }
    debugPrint('SIM bool $isLoggedIn');
     Timer(const Duration(seconds: 3), () {
      if(isLoggedIn != null) {
        if(isLoggedIn) {
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => const LoginScreen())
          );
        } else {
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => const LoginScreen())
          );
        }
      }
      else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen())
          );
        }
   });
  }

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
            stops: [0.1, 0.5],
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _getAppIcon(),
        _getBodyTxt(),
        _getStartedBtn(),
        _designedBy()
      ],
    );
  }

  _getAppIcon() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80, bottom: 10),
            height: MediaQuery.of(context).size.height * 0.25,
            child: Image.asset(
              ImageAssets.splashScreenPng,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            Strings.appLbl,
            style: TextStyles.s35_w900_c2488B4_inter,
          ),
        ],
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
        borderRadius: 12,
        textStyle: TextStyles.s16_w800,
        verticalSpacing: 15,
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
      ),
    );
  }

  _designedBy() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
            child: Image.asset(
              ImageAssets.mimLogo,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            Strings.poweredByMim,
            style: TextStyles.s10_w900_c2488B4_inter,
          ),
      ],
    );
  }
}