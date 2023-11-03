import 'package:flutter/material.dart';
import 'package:mim_whatsup/utils/textstyle.dart';

class DashboardBoxWidget extends StatelessWidget {
  Color? boxColor;
  double boxHeight;
  double boxWidth;
  String boxTitle;
  String boxSubtitle;
  bool hasIcon;
  String iconPath;

  DashboardBoxWidget({
    Key? key,
    this.boxColor,
    this.boxHeight = 100,
    this.boxWidth = 100,
    this.boxTitle = '',
    this.boxSubtitle = '',
    this.hasIcon = false,
    this.iconPath = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: boxHeight,
      width: boxWidth,
      child: Row(
        children: [
          hasIcon
          ? SizedBox(
            width: 30,
            height: 30,
            child: Image.asset(
              iconPath,
              fit: BoxFit.fill,
            ),
          ) : const SizedBox.shrink(),
          hasIcon ? const SizedBox(width: 10) : const SizedBox.shrink(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  boxTitle,
                  maxLines: 2,
                  style: TextStyles.s14_w500_c000000,
                  textAlign:TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  boxSubtitle,
                  style: TextStyles.s14_w600_c000000,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}