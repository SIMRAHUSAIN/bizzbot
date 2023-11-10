// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, unnecessary_null_comparison

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
import 'package:mim_whatsup/widgets/dashboard_box_widget.dart';
import 'package:fl_chart/fl_chart.dart';

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

  Count? dashboardCountData;
  List<Chart>? dashboardChartData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          backgroundColor: cFFFFFF,
          elevation: 1,
          actions: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.circle_outlined, 
                  color: c000000,
                  size: 30,
                ),
              ),
            )
          ],
          leadingWidth: MediaQuery.of(context).size.width * 0.4,
          leading: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(left: 10, bottom: 3, top: 3),
              child: Image.asset(ImageAssets.appBarLogo, fit: BoxFit.cover),
            ),
          ),
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
              debugPrint('Dash list states => $state');
              if(state is DashboardSuccessState) {
                dashboardCountData = state.dashboardModel.data!.count;
                dashboardChartData = state.dashboardModel.data!.chart;
              } else if(state is DashboardFailedState) {
                // 
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
          child: SizedBox(
            child: BarChart(
              BarChartData(
                barTouchData: barTouchData,
                titlesData: titlesData,
                borderData: borderData,
                barGroups: barGroups,
                gridData: FlGridData(show: false),
                alignment: BarChartAlignment.spaceAround,
                maxY: 20,
                // backgroundColor: cECF7FF
              )
            ),
          ),
        ),
      ]
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
            ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyles.s12_w700_c000000_lato,
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mon';
        break;
      case 1:
        text = 'Tue';
        break;
      case 2:
        text = 'Wed';
        break;
      case 3:
        text = 'Thu';
        break;
      case 4:
        text = 'Fri';
        break;
      case 5:
        text = 'Sat';
        break;
      case 6:
        text = 'Sun';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: TextStyles.s14_w400_c374A5E),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 8,
              color: cDEE2E6,
              width: 20,
              borderRadius: BorderRadius.circular(3)
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 10,
              color: cDEE2E6,
              width: 20,
              borderRadius: BorderRadius.circular(3)
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 14,
              color: cDEE2E6,
              width: 20,
              borderRadius: BorderRadius.circular(3)
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 15,
              color: c0D8578,
              width: 20,
              borderRadius: BorderRadius.circular(3)
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 13,
              color: cDEE2E6,
              width: 20,
              borderRadius: BorderRadius.circular(3)
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 10,
              color: cDEE2E6,
              width: 20,
              borderRadius: BorderRadius.circular(3)
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: 16,
              color: cDEE2E6,
              width: 20,
              borderRadius: BorderRadius.circular(3)
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];

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
              boxSubtitle: dashboardCountData != null 
              ? double.parse(dashboardCountData!.sUBMITTED.toString()).truncate().toString() : '',
              hasIcon: true,
              iconPath: ImageAssets.exportIcnPng,
            ), 
            DashboardBoxWidget(
              boxHeight: 60,
              boxWidth: MediaQuery.of(context).size.width * .42,
              boxColor: cFFF7EF,
              boxTitle: Strings.delvrdTtl,
              boxSubtitle: dashboardCountData != null 
              ? double.parse(dashboardCountData!.dELIVERED.toString()).truncate().toString() : '',
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
              boxSubtitle: dashboardCountData != null 
              ? double.parse(dashboardCountData!.fAILED.toString()).truncate().toString() : '',
              hasIcon: true,
              iconPath: ImageAssets.failedIcnPng,
            ), 
            DashboardBoxWidget(
              boxHeight: 60,
              boxWidth: MediaQuery.of(context).size.width * .42,
              boxColor: cECF7FF,
              boxTitle: Strings.seenTtl,
              // + dashboardCountData != null 
              // ? double.parse(dashboardCountData!.seenPercent.toString()).toString() : '',
              boxSubtitle: dashboardCountData != null 
              ? double.parse(dashboardCountData!.sEEN.toString()).truncate().toString() : '',
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
              boxSubtitle: dashboardCountData != null 
              ? double.parse(dashboardCountData!.totalCount.toString()).truncate().toString() : '',
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardBoxWidget(
                  boxHeight: 60,
                  boxWidth: 220,
                  boxColor: cEEFFF2,
                  boxTitle: Strings.openTtl,
                  boxSubtitle: dashboardCountData != null 
                  ? double.parse(dashboardCountData!.opened.toString()).truncate().toString() : '',
                  hasIcon: true,
                  iconPath: ImageAssets.openIcnPng,
                ), 
                SizedBox(height: 15),
                DashboardBoxWidget(
                  boxHeight: 60,
                  boxWidth: 220,
                  boxColor: cFFF1F1,
                  boxTitle: Strings.closedTtl,
                  boxSubtitle: dashboardCountData != null 
                  ? double.parse(dashboardCountData!.closed.toString()).truncate().toString() : '',
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
              boxSubtitle: dashboardCountData != null 
              ? double.parse(dashboardCountData!.pending.toString()).truncate().toString() : '',
              hasIcon: true,
              iconPath: ImageAssets.pendingIcnPng,
            ), 
            DashboardBoxWidget(
              boxHeight: 60,
              boxWidth: 220,
              boxColor: cECF7FF,
              boxTitle: Strings.avgRespTtl,
              boxSubtitle: dashboardCountData != null 
              ? double.parse(dashboardCountData!.average.toString()).truncate().toString() : '',
              hasIcon: true,
              iconPath: ImageAssets.avgRespIcnPng,
            ), 
          ],
        ),
      ]
    );
  }
}