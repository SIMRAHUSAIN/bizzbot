import 'package:flutter/material.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/textstyle.dart';

class IconAvatar extends StatelessWidget {
  final String userNameString;
  const IconAvatar({Key? key, this.userNameString = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: c606CC4,
        border: Border.all(width: 1.5, color: c606CC4),
      ),
      child: Center(
        child: Text(
          userNameString.substring(0,1),
          style: TextStyles.s16_w500_cFFFFFF,
        ),
      ),
    );
  }
}