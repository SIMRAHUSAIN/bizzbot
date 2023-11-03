// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:mim_whatsup/utils/assets.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/addnewlabel_dialogbox.dart';

class LabelListDialogBox extends StatefulWidget {

  @override
  State<LabelListDialogBox> createState() => _LabelListDialogBoxState();
}

class _LabelListDialogBoxState extends State<LabelListDialogBox> {

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: SizedBox(
          height: 350,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              Container(
                color: c0D8578,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.labelTtl,
                      style: TextStyles.s14_w500_cFFFFFF,
                    ),
                  ],
                ),
              ),
              Container(
                color: cFFFFFF,
                padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
                child: Column(
                  children: [
                    _getLabelWidget('Hot lead'),
                    _getLabelWidget('Interested'),
                    _getLabelWidget('Not Interested'),
                    _getLabelWidget('Testing'),
                    _getLabelWidget('Hot lead'),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _getButtons(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getButtons() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                isDismissible: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return Align(
                    alignment: Alignment.center,
                    child: AddNewLabelDialogBox()
                  );
              });
            },
            child: Text(
              Strings.addNewLabel,
              style: TextStyles.s16_w500_c544FFF,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 8),
              padding: const EdgeInsets.symmetric(
                horizontal: 6, vertical: 8),
              decoration: BoxDecoration(
                color: cCC2525,
                border: Border.all(
                  color: cCC2525,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                Strings.saveBtn,
                style: TextStyles.s14_w500_cFFFFFF,
              ),
            ),
          ), 
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(
                horizontal: 6, vertical: 8),
              decoration: BoxDecoration(
                color: c544FFF,
                border: Border.all(
                  color: c544FFF,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                Strings.deleteBtn,
                style: TextStyles.s14_w500_cFFFFFF,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 6, vertical: 8),
              decoration: BoxDecoration(
                color: cCC2525,
                border: Border.all(
                  color: cCC2525,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                Strings.cancelBtn,
                style: TextStyles.s14_w500_cFFFFFF,
              ),
            ),
          ), 
        ],
      ),
    );
  }

  _getLabelWidget(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                width: 30,
                height: 30,
                child: Image.asset(
                  ImageAssets.labelPng,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                label,
                style: TextStyles.s14_w500_c000000,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: Checkbox(
                  onChanged: (newValue) {
                    setState(() {
                      isChecked = newValue!;
                    });
                  },
                  value: isChecked,
                  activeColor: c137700,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 15),
                width: 22,
                height: 22,
                child: Image.asset(
                  ImageAssets.labelCheckboxPng,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}