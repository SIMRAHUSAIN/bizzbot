import 'package:flutter/material.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/textstyle.dart';

class ChipWidget extends StatelessWidget {
  final String? labelText;
  final Color? labelColor;
  const ChipWidget({Key? key, this.labelText, this.labelColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: labelColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Text(
            labelText!,
            style: TextStyles.s8_w400_cFFFFFF,
          ),
        ),
      ],
    );
  }
}