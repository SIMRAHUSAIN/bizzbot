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

  ListingCard({Key? key, 
    required this.userName, 
    required this.date, 
    required this.mobNum,
    required this.notificationNum,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: cFFFFFF,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconAvatar(
                      userNameString: userName,
                    ),
                    const ChipWidget(
                      label1: 'Label1',
                    ),
                  ],
                ),
                const SizedBox(width: 15),
                Column(
                  children: [
                    Text(
                      userName,
                      style: TextStyles.s18_w500_c000000,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '($mobNum)',
                      style: TextStyles.s14_w400_cB3AEAE,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: TextStyles.s14_w400_cB3AEAE,
                ),
                Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: c0FC333,
                    border: Border.all(width: 1.5, color: c606CC4),
                  ),
                  child: Center(
                    child: Text(
                      notificationNum,
                      style: TextStyles.s14_w500_cFFFFFF,
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