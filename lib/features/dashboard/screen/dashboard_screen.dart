// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/dashboard/bloc/bloc.dart';
import 'package:mim_whatsup/features/dashboard/bloc/event.dart';
import 'package:mim_whatsup/features/dashboard/bloc/state.dart';
import 'package:mim_whatsup/features/dashboard/model/dashboard_model.dart';
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
  void initState() {
    super.initState();
    BlocProvider.of<DashboardBloc>(context).add(
      GetDashboardEvent()
    );
  }

  DashboardModel? dashboardModal;

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: BlocListener<DashboardBloc, DashboardState>(
            listener: ((context, state) {
              if(state is DashboardSuccessState) {
                dashboardModal = state.dashboardModel;
              }
            }),
            child: BlocBuilder<DashboardBloc, DashboardState>(
              builder: ((context, state) {
                return Column(
                  children: [
                    _getConversationWidgets(),
                    SizedBox(height: 10),
                    _getChartWidget(),
                    SizedBox(height: 10),
                    _getMsgSntWidgets()
                  ],
                );
              }),
            ),
          )
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
          style: TextStyles.s18_w500_c000000_lato,
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
          style: TextStyles.s18_w500_c000000_lato,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DashboardBoxWidget(
              boxHeight: 60,
              boxWidth: MediaQuery.of(context).size.width * .42,
              boxColor: cEEFFF2,
              boxTitle: Strings.sentTtl,
              boxSubtitle: '100',
              hasIcon: true,
              iconPath: ImageAssets.exportIcnPng,
            ), 
            DashboardBoxWidget(
              boxHeight: 60,
              boxWidth: MediaQuery.of(context).size.width * .42,
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
              boxHeight: 60,
              boxWidth: MediaQuery.of(context).size.width * .42,
              boxColor: cFFF1F1,
              boxTitle: Strings.failedTtl,
              boxSubtitle: '100',
              hasIcon: true,
              iconPath: ImageAssets.failedIcnPng,
            ), 
            DashboardBoxWidget(
              boxHeight: 60,
              boxWidth: MediaQuery.of(context).size.width * .42,
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
          style: TextStyles.s18_w500_c000000_lato,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardBoxWidget(
              boxHeight: 136,
              boxWidth: 120,
              boxColor: cF1F5F8,
              boxTitle: Strings.totalcnvrstnTtl,
              boxSubtitle: '11000',
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardBoxWidget(
                  boxHeight: 60,
                  boxWidth: 220,
                  boxColor: cEEFFF2,
                  boxTitle: Strings.openTtl,
                  boxSubtitle: '1000',
                  hasIcon: true,
                  iconPath: ImageAssets.openIcnPng,
                ), 
                SizedBox(height: 15),
                DashboardBoxWidget(
                  boxHeight: 60,
                  boxWidth: 220,
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
              boxHeight: 60,
              boxWidth: 120,
              boxColor: cFFF7EF,
              boxTitle: Strings.pendingTtl,
              boxSubtitle: '100',
              hasIcon: true,
              iconPath: ImageAssets.pendingIcnPng,
            ), 
            DashboardBoxWidget(
              boxHeight: 60,
              boxWidth: 220,
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