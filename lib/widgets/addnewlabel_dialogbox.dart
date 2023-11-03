// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:mim_whatsup/utils/assets.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';

class AddNewLabelDialogBox extends StatefulWidget {

  @override
  State<AddNewLabelDialogBox> createState() => _AddNewLabelDialogBoxState();
}

class _AddNewLabelDialogBoxState extends State<AddNewLabelDialogBox> {

  final TextEditingController _labelController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 250,
        child: Column(
          children: [
            Container(
              color: c0D8578,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.addNewLabel,
                    style: TextStyles.s14_w500_cFFFFFF,
                  ),
                ],
              ),
            ),
            Container(
              color: cFFFFFF,
              padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 30,
                        height: 30,
                        child: Image.asset(
                          ImageAssets.labelPng,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          onSaved: (String? val) {
                            _labelController.text = val!;
                          },
                          autovalidateMode: AutovalidateMode.always,
                          controller: _labelController,
                          enabled: true,
                          maxLength: 1,
                          style: TextStyles.s14_w400_cFFE3E1,
                          decoration: const InputDecoration(
                            hintText: Strings.addNewLabel,
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: cA4A0A0
                            ),
                            filled: true,
                            fillColor: cFFFFFF,
                            counterText: '',
                            contentPadding: EdgeInsets.only(top: 10, left: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(width: 1, color: cA4A0A0)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(width: 1, color: cA4A0A0)
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(width: 1, color: cA4A0A0)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(width: 1, color: cA4A0A0)
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(right: 10, top: 90),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: c544FFF,
                            border: Border.all(
                              color: c544FFF,
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
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 90),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}