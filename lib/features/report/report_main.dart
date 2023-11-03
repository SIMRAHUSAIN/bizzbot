import 'package:flutter/material.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/widgets/app_bar.dart';

class ReportMainScreen extends StatefulWidget {
  const ReportMainScreen({Key? key}) : super(key: key);

  @override
  State<ReportMainScreen> createState() => _ReportMainScreenState();
}

class _ReportMainScreenState extends State<ReportMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarWithBackButton(
          title: 'Report',
          onLeadingPressed: () {},
          onSuffixPressed: () {},
          isleadingIcon: false,
        ),
      ),
      backgroundColor: cFFFFFF,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(),
        ),
      ),
    );
  }
}