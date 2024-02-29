import 'package:flutter/material.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/textstyle.dart';

class CommonActionButton extends StatelessWidget {
  String? title;
  void Function()? onTap;
  Color? btnColor;

  CommonActionButton({
    Key? key,
    this.title,
    this.onTap,
    this.btnColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.24,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 1, color: btnColor ?? cFFFFFF)
        ),
        margin: const EdgeInsets.only(left: 10, right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: Center(
          child: Text(
            title ?? '',
            style: TextStyles.s14_w500_c939292_lato,
          ),
        ),
      ),
    );
  }
}