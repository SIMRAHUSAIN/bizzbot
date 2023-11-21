import 'package:flutter/material.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/textstyle.dart';

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final String time;
  final String sendFrom;

  const ChatMessageWidget({
    Key? key,
    required this.text,
    required this.time,
    required this.sendFrom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sendFrom == 'WABA' ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 320),
        margin: const EdgeInsets.only(top: 15, left: 5, right: 5),
        decoration: BoxDecoration(
          color: sendFrom == 'WABA' ? cE0E0E0 : cCFE3E1,
          borderRadius: BorderRadius.only(
            topLeft: sendFrom == 'WABA' ? const Radius.circular(30) : const Radius.circular(0),
            topRight: sendFrom == 'WABA' ? const Radius.circular(0) : const Radius.circular(30),
            bottomLeft: const Radius.circular(8),
            bottomRight: const Radius.circular(8),
          ),
        ),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: IntrinsicWidth(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 0.3,
                    wordSpacing: 0.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Loto',
                    color: Colors.black
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                time.split(" ").last.split(":").first + ":" + time.split(" ").last.split(":")[1],
                style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Loto',
                    color: Colors.black
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
