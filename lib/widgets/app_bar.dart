import 'package:flutter/material.dart';
import 'package:mim_whatsup/home_screen.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/textstyle.dart';

class AppBarWithBackButton extends StatelessWidget{

  final String title;
  final VoidCallback? onLeadingPressed;
  final Color? backgroundColor;
  final bool isleadingIcon;
  final IconData leadingIcon;
  final IconData suffixIcon;
  final bool isSuffixIcon;
  final VoidCallback? onSuffixPressed;

  const AppBarWithBackButton({
    Key? key,
    required this.title,
    required this.onLeadingPressed,
    this.backgroundColor,
    this.isleadingIcon = false,
    this.leadingIcon = Icons.arrow_back,
    this.suffixIcon = Icons.more_vert,
    this.isSuffixIcon = false,
    required this.onSuffixPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? c577D91,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: TextStyles.s16_w500_cFFFFFF,
      ),
      centerTitle: false,
      actions: [
        isSuffixIcon
        ? GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(suffixIcon),
          ),
        )
        : const SizedBox.shrink()
      ],
      leading: isleadingIcon 
      ? GestureDetector(
          onTap: () {
            if (onLeadingPressed != null) {
              onLeadingPressed!();
            }
          },
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(leadingIcon),
          ),
        )
      : Navigator.canPop(context)
        ? GestureDetector(
          onTap: () {
            if (onLeadingPressed != null) {
              onLeadingPressed!();
            }
            if (Navigator.canPop(context)) {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const HomeScreen()));
            }
          },
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: const Icon(Icons.arrow_back),
          ),
        ): const SizedBox.shrink(),
        elevation: 0,
        titleSpacing: 0,
    );
  }
}