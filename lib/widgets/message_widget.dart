import 'package:flutter/material.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/textstyle.dart';

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final String sender;
  final String time;

  const ChatMessageWidget({
    Key? key,
    required this.text, 
    required this.sender,
    required this.time
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      constraints: const BoxConstraints(
        maxWidth: 200,
        minWidth: 100
      ),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: sender == 'us' ? cE0E0E0 : cCFE3E1,
        borderRadius: BorderRadius.only(
          topLeft: sender == 'us' ? const Radius.circular(30) : const Radius.circular(0),
          topRight: sender == 'us' ? const Radius.circular(0) : const Radius.circular(30),
          bottomLeft: const Radius.circular(8),
          bottomRight: const Radius.circular(8)
        ),
      ),
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text, 
            maxLines: 10,
            style: TextStyles.s16_w500_c000000,
          ),
          Text(
            time,
            style: TextStyles.s10_w400_c939292,
          ),
        ],
      ),
    );
  }
}