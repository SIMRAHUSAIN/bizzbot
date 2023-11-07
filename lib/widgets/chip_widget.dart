import 'package:flutter/material.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/textstyle.dart';

class ChipWidget extends StatelessWidget {
  final String? label1;
  const ChipWidget({Key? key, this.label1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: c606CC4,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Text(
            label1!,
            style: TextStyles.s8_w400_cFFFFFF,
          ),
        ),
      ],
    );
  }
}