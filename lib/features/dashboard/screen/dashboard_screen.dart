// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:mim_whatsup/utils/assets.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/app_bar.dart';
import 'package:mim_whatsup/widgets/dashboard_box_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarWithBackButton(
          title: '',
          onLeadingPressed: () {},
          onSuffixPressed: () {},
          isleadingIcon: true,
          leadingIcon: Icons.menu_sharp,
          isSuffixIcon: true,
          suffixIcon: Icons.circle_outlined,
        ),
      ),
      backgroundColor: cFFFFFF,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              _getConversationWidgets(),
              SizedBox(height: 10),
              _getChartWidget(),
              SizedBox(height: 10),
              _getMsgSntWidgets()
            ],
          ),
        ),
      ),
    );
  }

  _getChartWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.msgCntHome,
          style: TextStyles.s22_w700_c000000,
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: Center(child: Text('Bar chart space')),
        ),
      ]
    );
  }

  _getMsgSntWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.msgSntHome,
          style: TextStyles.s22_w700_c000000,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DashboardBoxWidget(
              boxHeight: MediaQuery.of(context).size.height * .105,
              boxWidth: MediaQuery.of(context).size.width * .4,
              boxColor: cEEFFF2,
              boxTitle: Strings.sentTtl,
              boxSubtitle: '100',
              hasIcon: true,
              iconPath: ImageAssets.exportIcnPng,
            ), 
            DashboardBoxWidget(
              boxHeight: MediaQuery.of(context).size.height * .105,
              boxWidth: MediaQuery.of(context).size.width * .45,
              boxColor: cFFF7EF,
              boxTitle: Strings.delvrdTtl,
              boxSubtitle: '15 Min',
              hasIcon: true,
              iconPath: ImageAssets.deliveredIcnPng,
            ), 
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DashboardBoxWidget(
              boxHeight: MediaQuery.of(context).size.height * .105,
              boxWidth: MediaQuery.of(context).size.width * .4,
              boxColor: cFFF1F1,
              boxTitle: Strings.failedTtl,
              boxSubtitle: '100',
              hasIcon: true,
              iconPath: ImageAssets.failedIcnPng,
            ), 
            DashboardBoxWidget(
              boxHeight: MediaQuery.of(context).size.height * .105,
              boxWidth: MediaQuery.of(context).size.width * .45,
              boxColor: cECF7FF,
              boxTitle: Strings.seenTtl,
              boxSubtitle: '15 Min',
              hasIcon: true,
              iconPath: ImageAssets.seenIcnPng,
            ), 
          ],
        ),
      ],
    );
  }

  _getConversationWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.cnvrstnChtHome,
          style: TextStyles.s22_w700_c000000,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardBoxWidget(
              boxHeight: MediaQuery.of(context).size.height * .2,
              boxWidth: MediaQuery.of(context).size.width * .4,
              boxColor: cF1F5F8,
              boxTitle: Strings.totalcnvrstnTtl,
              boxSubtitle: '11000',
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardBoxWidget(
                  boxHeight: MediaQuery.of(context).size.height * .09,
                  boxWidth: MediaQuery.of(context).size.width * .45,
                  boxColor: cEEFFF2,
                  boxTitle: Strings.openTtl,
                  boxSubtitle: '1000',
                  hasIcon: true,
                  iconPath: ImageAssets.openIcnPng,
                ), 
                SizedBox(height: 15),
                DashboardBoxWidget(
                  boxHeight: MediaQuery.of(context).size.height * .09,
                  boxWidth: MediaQuery.of(context).size.width * .45,
                  boxColor: cFFF1F1,
                  boxTitle: Strings.closedTtl,
                  boxSubtitle: '800',
                  hasIcon: true,
                  iconPath: ImageAssets.closedIcnPng,
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DashboardBoxWidget(
              boxHeight: MediaQuery.of(context).size.height * .105,
              boxWidth: MediaQuery.of(context).size.width * .4,
              boxColor: cFFF7EF,
              boxTitle: Strings.pendingTtl,
              boxSubtitle: '100',
              hasIcon: true,
              iconPath: ImageAssets.pendingIcnPng,
            ), 
            DashboardBoxWidget(
              boxHeight: MediaQuery.of(context).size.height * .105,
              boxWidth: MediaQuery.of(context).size.width * .45,
              boxColor: cECF7FF,
              boxTitle: Strings.avgRespTtl,
              boxSubtitle: '15 Min',
              hasIcon: true,
              iconPath: ImageAssets.avgRespIcnPng,
            ), 
          ],
        ),
      ]
    );
  }
}