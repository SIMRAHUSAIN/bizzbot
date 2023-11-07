import 'package:flutter/material.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/chip_widget.dart';
import 'package:mim_whatsup/widgets/image_avatar.dart';

class ListingCard extends StatelessWidget {
  final String userName;
  final String date;
  final String mobNum;
  final String notificationNum;
  void Function()? onTap;
  final String label1Text;
  final String label1Color;
  final String label2Text;
  final String label2Color;
  final String label3Text;
  final String label3Color;

  ListingCard({Key? key, 
    required this.userName, 
    required this.date, 
    required this.mobNum,
    required this.notificationNum,
    required this.onTap,
    required this.label1Text,
    required this.label1Color,
    required this.label2Text,
    required this.label2Color,
    required this.label3Text,
    required this.label3Color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        //margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: cFFFFFF,
          //borderRadius: BorderRadius.circular(10),
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.5), // You can change the color to your desired color
              width: 0.5,         // You can adjust the border width as needed
            ),
          ),
        ),
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconAvatar(
                      userNameString: userName,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     label1Text == ""?Container():ChipWidget(
                    //       label1: label1Text??"",
                    //     ),
                    //     label1Text == ""?Container():const SizedBox(width: 5),
                    //     label2Text == ""?Container():ChipWidget(
                    //       label1: label2Text??"",
                    //     ),
                    //   ],
                    // )
                  ],
                ),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName.split(" ").first,
                      style: TextStyles.s18_w500_c000000,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '($mobNum)',
                      style: TextStyles.s14_w400_cB3AEAE,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        label1Text == ""?Container():ChipWidget(
                          label1: label1Text??"",
                        ),
                        label1Text == ""?Container():const SizedBox(width: 5),
                        label2Text == ""?Container():ChipWidget(
                          label1: label2Text??"",
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date.split(" ").first,
                  style: TextStyles.s14_w400_cB3AEAE,
                ),
                Text(
                  date.split(" ").last,
                  style: TextStyles.s14_w400_cB3AEAE,
                ),
                notificationNum == "0"?Container():Container(
                  width: 18,
                  height: 18,
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: c0FC333,
                    border: Border.all(width: 1.5, color: cFFFFFF),
                  ),
                  child: Center(
                    child: Text(
                      notificationNum,
                      style: TextStyles.s11_w500_cFFFFFF,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}