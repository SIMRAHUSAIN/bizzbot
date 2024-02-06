// use bottom nav here and do navigation from here 


import 'package:flutter/material.dart';
import 'package:mim_whatsup/features/dashboard/screen/dashboard_screen.dart';
import 'package:mim_whatsup/features/report/report_main.dart';
import 'package:mim_whatsup/features/send_msg/screen/send_msg_main.dart';
import 'package:mim_whatsup/features/user_chat/screen/user_chat_listing_screen.dart';
import 'package:mim_whatsup/utils/assets.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/textstyle.dart';


class HomeScreen extends StatefulWidget {
  // final LoginSuccessModel loginSuccessModel;

  const HomeScreen({Key? key,
    // required this.loginSuccessModel
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static List<Widget> tabs = [];
  int currentTabIndex = 0;
  
  @override
  void initState() {
    super.initState();
    tabs = [
      const DashboardScreen(),
      const UserChatMainScreen(),
      const SendMsgMainScreen(),
      const ReportMainScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: cFFFFFF,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 20,
              width: 20,
              child: Image.asset(
                ImageAssets.homeNav,
                fit: BoxFit.fill,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 20,
              width: 20,
              child: Image.asset(
                ImageAssets.userChatNav,
                fit: BoxFit.fill,
              ),
            ),
            label: 'User Chat',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 20,
              width: 20,
              child: Image.asset(
                ImageAssets.sendMsgNav,
                fit: BoxFit.fill,
              ),
            ),
            label: 'Send Msg',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 20,
              width: 20,
              child: Image.asset(
                ImageAssets.reportNav,
                fit: BoxFit.fill,
              ),
            ),
            label: 'Report',
          ),
        ],
        selectedItemColor: c577D91,
        unselectedItemColor: c9EA2AD,
        selectedLabelStyle: TextStyles.s14_w800_c577D91,
        unselectedLabelStyle: TextStyles.s14_w500_c9EA2AD,
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            currentTabIndex = value;
          });
        },
        iconSize: 18,
        selectedFontSize: 20,
        unselectedFontSize: 18,
      ),
      body: tabs[currentTabIndex],
    );
  }
}