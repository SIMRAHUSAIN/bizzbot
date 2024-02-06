import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/send_msg/bloc/bloc.dart';
import 'package:mim_whatsup/features/send_msg/bloc/event.dart';
import 'package:mim_whatsup/utils/assets.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/app_bar.dart';

class SendMsgMainScreen extends StatefulWidget {
  const SendMsgMainScreen({Key? key}) : super(key: key);

  @override
  State<SendMsgMainScreen> createState() => _SendMsgMainScreenState();
}

class _SendMsgMainScreenState extends State<SendMsgMainScreen> {

  final TextEditingController _cmpgnNmController = TextEditingController();

  List<String?>? whatsAppTypeList = [
    'Text',
    'Image',
    'Video',
    'Document',
    'Audio',
    'Location'
  ];

  List<String?>? countryCdList = [];
  List<String?>? templateIdList = [
    'Text 1',
    'Text 2',
    'Text 3',
    'Text 4',
  ];

  String whatsAppTypeInitVal = 'Text';
  String? countryCdInitVal;
  String templateIdInitVal = 'Text 1';

  @override
  void initState() {
    super.initState();
    debugPrint('SIM 1');
    BlocProvider.of<SendMessageBloc>(context).add(
      GetCountryCodeEvent()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarWithBackButton(
          title: 'Send Msg',
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
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: _getBodyContent()
        ),
      ),
    );
  }

  _getBodyContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getCountryCodeDrpdwn(),
        _getWhtsAppTypDrpdwn(),
        _getCmpgnNmTxtFld(),
        _getMobNumRow(),
        _getDuplicate(),
        _getUploadFileRow(),
        _getLinkRow(),
        _tempIdDrpdwn(),
        _getWhtAppTxt(),
        _getActnBtnRow()
      ],
    );
  }

  _getWhtsAppTypDrpdwn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          borderRadius: BorderRadius.circular(12),
          elevation: 4,
          items: whatsAppTypeList!.map<DropdownMenuItem<String>>((String? value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value!,
                maxLines: 1,
                style: TextStyles.s16_w700_c137700,
              ),
            );
          }).toList(),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: c137700,
          ),
          iconSize: 30,
          value: whatsAppTypeInitVal,
          style: TextStyles.s16_w700_c137700,
          onChanged: _whatsAppTypecallBack,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(width: 1.5, color: c137700),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(width: 1.5, color: c137700),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(width: 1.5, color: c137700),
            ),
          )
        ),
      ),
    );
  }

  _whatsAppTypecallBack(newValue) {
    setState(() {
      whatsAppTypeInitVal = newValue;
    });
  }

  _getCmpgnNmTxtFld() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10, bottom: 15),
      child: TextFormField(
        textAlign: TextAlign.start,
        onSaved: (String? val) {
          _cmpgnNmController.text = val!;
        },
        controller: _cmpgnNmController,
        enabled: true,
        style: TextStyles.s14_w400_cB3AEAE,
        decoration: InputDecoration(
          label: const Text(Strings.campaignNm),
          labelStyle: TextStyles.s16_w700_c137700,
          filled: true,
          fillColor: cFFFFFF,
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 1.5, color: c137700)
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 1.5, color: c137700)
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 1.5, color: c137700)
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 1.5, color: c137700)
          ),
        ),
        onChanged: (value) {},
      ),
    );
  }

  _getCountryCodeDrpdwn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          borderRadius: BorderRadius.circular(12),
          elevation: 4,
          items: countryCdList!.map<DropdownMenuItem<String>>((String? value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value!,
                maxLines: 1,
                style: TextStyles.s16_w700_c137700,
              ),
            );
          }).toList(),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: c137700,
          ),
          iconSize: 30,
          value: countryCdInitVal,
          style: TextStyles.s16_w700_c137700,
          onChanged: _countryCdCallBack,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(width: 1.5, color: c137700),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(width: 1.5, color: c137700),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(width: 1.5, color: c137700),
            ),
          )
        ),
      ),
    );
  } 

  _countryCdCallBack(newValue) {}
  
  _getWhtAppTxt() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: MediaQuery.of(context).size.height * 0.06,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: c137700.withOpacity(0.08),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Whatsapp Text',
          style: TextStyles.s14_w500_c939292_lato,
        ),
      ),
    );
  }

  _getActnBtnRow() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _actionBtn(
            'Send', 
            () {},
            cECF7FF,
          ),
          _actionBtn(
            'Cancel', 
            () {},
            cFFF1F1,
          ),
          _actionBtn(
            'Schedule', 
            () {},
            cFFF7EF,
          ),
        ],
      ),
    );
  }

  _actionBtn(String title, void Function()? onTap, Color btnColor) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.24,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 1, color: btnColor)
        ),
        margin: const EdgeInsets.only(left: 10, right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: Center(
          child: Text(
            title,
            style: TextStyles.s14_w500_c939292_lato,
          ),
        ),
      ),
    );
  }

  _tempIdDrpdwn() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Template ID',
            style: TextStyles.s16_w700_c137700
          ),
          Container(
            width: MediaQuery.of(context).size.width * .65,
            height: MediaQuery.of(context).size.height * .1,
            margin: const EdgeInsets.only(top: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                borderRadius: BorderRadius.circular(12),
                elevation: 4,
                hint: Text(
                  '--Select--',
                  style: TextStyles.s14_w400_cB3AEAE,
                ),
                items: templateIdList!.map<DropdownMenuItem<String>>((String? value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value!,
                      maxLines: 1,
                      style: TextStyles.s16_w700_c137700,
                    ),
                  );
                }).toList(),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: c137700,
                ),
                iconSize: 30,
                value: templateIdInitVal,
                style: TextStyles.s16_w700_c137700,
                onChanged: _templateIdCallback,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(width: 1.5, color: c137700),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(width: 1.5, color: c137700),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(width: 1.5, color: c137700),
                  ),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }

  _templateIdCallback(newValue) {
    setState(() {
      templateIdInitVal = newValue;
    });
  }

  _getLinkRow() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
      decoration: BoxDecoration(
        color: cC2FFA0.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: cC2FFA0.withOpacity(0.5),
        ),
      ),
    );
  }

  _getUploadFileRow() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          _cmnRectangularActnBtn(
            true, 
            () { }, 
            'Upload Files'
          ),
          _cmnRectangularActnBtn(
            false, 
            () { }, 
            'No Files Chosen'
          )
        ],
      ),
    );
  }

  _getMobNumRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.mobNum,
          style: TextStyles.s14_w500_c939292_lato,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _cmnCircularActnBtn(
              true,
              () {},
              'Upload Files(TXT/CSV)'
            ),
            _cmnCircularActnBtn(
              false,
              () {},
              'Group'
            ),
            _cmnCircularActnBtn(
              false,
              () {},
              'Mobile Number'
            ),
          ]
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  _cmnCircularActnBtn(bool isTapped, void Function()? onTap, String title) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
        decoration: BoxDecoration(
          color: isTapped ? c137700 : cFFFFFF,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        child: Center(
          child: Text(
            title,
            style: isTapped ? TextStyles.s12_w400_cFFFFFF : TextStyles.s14_w500_c939292_lato,
          ),
        ),
      ),
    );
  }

  _cmnRectangularActnBtn(bool isTapped, void Function()? onTap, String title) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.height * 0.225,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
        decoration: BoxDecoration(
          color: isTapped ? c3690E3.withOpacity(0.08) : cE2DEDE.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: isTapped ? c3690E3 : cE2DEDE.withOpacity(0.2),
          )
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              title == 'Upload Files'
              ? SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(
                  ImageAssets.uploadPng,
                  fit: BoxFit.fill,
                ),
              ) : const SizedBox.shrink(),
              title == 'Upload Files'
              ? const SizedBox(width: 5) : const SizedBox.shrink(),
              Text(
                title,
                style: isTapped ? TextStyles.s14_w500_c3690E3 : TextStyles.s14_w500_c000000,
              ),
            ],
          ),
        ),
      ),
    );
  }   

  _getDuplicate() {
    return Row(
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: Checkbox(
            onChanged: (newValue) {},
            value: false,
            activeColor: c137700,
          ),
        ),
        Text(
          'Allow Duplicate',
          style: TextStyles.s14_w600_c000000,
        ),
      ],
    );
  }
}