import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/send_msg/bloc/bloc.dart';
import 'package:mim_whatsup/features/send_msg/bloc/event.dart';
import 'package:mim_whatsup/features/send_msg/bloc/state.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/app_bar.dart';

import 'group_list.dart';

class SendMsgMainScreen extends StatefulWidget {
  const SendMsgMainScreen({Key? key}) : super(key: key);

  @override
  State<SendMsgMainScreen> createState() => _SendMsgMainScreenState();
}

class _SendMsgMainScreenState extends State<SendMsgMainScreen> {

  final TextEditingController _cmpgnNmController = TextEditingController();

  List<String?>? templateTypeList = [];
  List<String?>? countryCdList = [];
  List<String?>? templateIdList = [];

  String? templateTypeInitVal = '';
  String? countryCdInitVal = '';
  String? templateIdInitVal = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SendMessageBloc>(context).add(
      GetCountryCodeEvent()
    );
    BlocProvider.of<SendMessageBloc>(context).add(
      GetTemplateTypeEvent()
    );
    BlocProvider.of<SendMessageBloc>(context).add(
      GetTemplateIdEvent()
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
          child: SingleChildScrollView(
            child: BlocListener<SendMessageBloc, SendMessageState>(
              listener: ((context, state) {
                debugPrint('SIM Send Message states --> $state');
                if(state is CountryCdSuccessState) {
                  countryCdInitVal = state.countryCodeModel.data![0].countryCode;
                  for(int i = 0; i < state.countryCodeModel.data!.length; i++) {
                    countryCdList!.add(state.countryCodeModel.data![i].countryCode);
                  }
                }
                else if(state is TemplateTypeSuccessState) {
                  templateTypeInitVal = state.templateTypeModel.data![6].templateType!;
                  debugPrint('SIM Send Msg Type length ${state.templateTypeModel.data!.length}');
                  debugPrint('SIM Send Msg Type init val $templateTypeInitVal');
                  for(int i = 0; i < state.templateTypeModel.data!.length; i++) {
                    templateTypeList!.add(state.templateTypeModel.data![i].templateType);
                  }
                } 
                else if(state is TemplateIdSuccessState) {
                  templateIdInitVal = state.templateIdModel.data![0].name!;
                  debugPrint('SIM 1 Send Msg Type length ${state.templateIdModel.data!.length}');
                  debugPrint('SIM 1 Send Msg Type init val $templateIdInitVal');
                  for(int i = 0; i < state.templateIdModel.data!.length; i++) {
                    templateIdList!.add(state.templateIdModel.data![i].name.toString());
                    debugPrint('SIM 1 temp id list $templateIdList');
                  }
                }
              }),
              child: BlocBuilder<SendMessageBloc, SendMessageState>(
                builder: (((context, state) {
                  return _getBodyContent();
                })),
              )
            )
          )
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
        _getTemplateTypDrpdwn(),
        _getCmpgnNmTxtFld(),
        _getMobNumRow(),
        currentIndex == 2?Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey), // Add border
              borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 5, // Set maxLines to allow at least 5 lines
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Enter up to five lines of text',
                  border: InputBorder.none, // Hide TextField's border
                ),
              ),
            ),
          ),
        ):SizedBox(),
        _getDuplicate(),
        // _getUploadFileRow(),
        // _getLinkRow(),
        _tempIdDrpdwn(),
        _getWhtAppTxt(),
        _getDuplicate(),
        _getActnBtnRow()
      ],
    );
  }

  _getTemplateTypDrpdwn() {
    return IgnorePointer(
      ignoring: true,  // disabled dropdown for default value to be media template
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            borderRadius: BorderRadius.circular(12),
            elevation: 4,
            items: templateTypeList!.map<DropdownMenuItem<String>>((String? value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value!,
                  maxLines: 1,
                  style: TextStyles.s16_w700_c137700,
                ),
              );
            }).toSet().toList(),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: c137700,
            ),
            iconSize: 30,
            value: templateTypeInitVal,
            style: TextStyles.s16_w700_c137700,
            onChanged: _templateTypecallBack,
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
      ),
    );
  }

  _templateTypecallBack(newValue) {
    setState(() {
      templateTypeInitVal = newValue;
    });
    debugPrint('SIM Template Type new value $newValue');
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
    return countryCdList != null
    ? Container(
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
          }).toSet().toList(),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: c137700,
          ),
          iconSize: 30,
          value: countryCdInitVal ?? '',
          style: TextStyles.s16_w700_c137700,
          onChanged: _countryCdCallBack,
          decoration: const InputDecoration(
            label: Text(
              'Country Code',
            ),
            labelStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: c137700,
                fontFamily: 'Lato',
            ),
            prefixText: 'INDIA- ',
            prefixStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: c137700,
                fontFamily: 'Lato',
            ),
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
    ) : const SizedBox.shrink();
  } 

  _countryCdCallBack(newValue) {
    setState(() {
      countryCdInitVal = newValue;
    });
  }
  
  _getWhtAppTxt() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: MediaQuery.of(context).size.height * 0.15,
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
      margin: const EdgeInsets.only(top: 5),
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
    debugPrint('SIM 1 $templateIdList');
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Template ID',
            style: TextStyles.s16_w700_c137700
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * .65,
            height: MediaQuery.of(context).size.height * .1,
            // margin: const EdgeInsets.only(top: 10),
            // padding: const EdgeInsets.only(left: 10),
            child: Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(12),
                  elevation: 4,
                  hint: Text(
                    '--Select--',
                    style: TextStyles.s14_w400_cB3AEAE,
                  ),
                  items: templateIdList != null
                  ? templateIdList!.map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value!,
                        maxLines: 1,
                        style: TextStyles.s16_w700_c137700,
                      ),
                    );
                  }).toSet().toList() : [],
                  // icon: const Icon(
                  //   Icons.keyboard_arrow_down,
                  //   color: c137700,
                  // ),
                  // iconSize: 30,
                  value: templateIdInitVal!.isNotEmpty ? templateIdInitVal : '',
                  style: TextStyles.s16_w700_c137700,
                  onChanged: _templateIdCallback,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: 1.5, color: c137700),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: 1.5, color: c137700),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: 1.5, color: c137700),
                    ),
                  )
                ),
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
    debugPrint('SIM 1 temp id callback $newValue');
  }

  // _getLinkRow() {
  //   return Container(
  //     height: MediaQuery.of(context).size.height * 0.05,
  //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
  //     decoration: BoxDecoration(
  //       color: cC2FFA0.withOpacity(0.5),
  //       borderRadius: const BorderRadius.all(Radius.circular(8)),
  //       border: Border.all(
  //         color: cC2FFA0.withOpacity(0.5),
  //       ),
  //     ),
  //   );
  // }

  // _getUploadFileRow() {
  //   return Container(
  //     margin: const EdgeInsets.only(top: 10, bottom: 10),
  //     child: Row(
  //       children: [
  //         _cmnRectangularActnBtn(
  //           true, 
  //           () { }, 
  //           'Upload Files'
  //         ),
  //         _cmnRectangularActnBtn(
  //           false, 
  //           () { }, 
  //           'No Files Chosen'
  //         )
  //       ],
  //     ),
  //   );
  // }

  int currentIndex = 0;

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
              0,
              true,
              () async {
                setState((){
                  currentIndex = 0;
                });
                FilePickerResult? result = await FilePicker.platform.pickFiles();
                if (result != null) {
                  String filePath = result.files.single.path!;
                  BlocProvider.of<SendMessageBloc>(context).add(
                      UploadCsv(fileType: File(filePath))
                  );
                  // Use the file path as needed
                }
              },
              'Upload Files(TXT/CSV)'
            ),
            _cmnCircularActnBtn(
              1,
              false,
              () {
                setState((){
                  currentIndex = 1;
                });
                showDialog(
                  context: context,
                  builder: (context) {
                    return const GroupList();
                  }
                );
              },
              'Group'
            ),
            _cmnCircularActnBtn(
              2,
              false,
              () {
                setState((){
                  currentIndex = 2;
                });
              },
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

  _cmnCircularActnBtn(int index, bool isTapped, void Function()? onTap, String title) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
        decoration: BoxDecoration(
          color: index == currentIndex ? c137700 : cFFFFFF,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        child: Center(
          child: Text(
            title,
            style: index == currentIndex ? TextStyles.s12_w400_cFFFFFF : TextStyles.s12_w500_c939292_lato,
          ),
        ),
      ),
    );
  }

  // _cmnRectangularActnBtn(bool isTapped, void Function()? onTap, String title) {
  //   return InkWell(
  //     onTap: onTap,
  //     child: Container(
  //       height: MediaQuery.of(context).size.height * 0.06,
  //       width: MediaQuery.of(context).size.height * 0.225,
  //       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
  //       decoration: BoxDecoration(
  //         color: isTapped ? c3690E3.withOpacity(0.08) : cE2DEDE.withOpacity(0.2),
  //         borderRadius: const BorderRadius.all(Radius.circular(8)),
  //         border: Border.all(
  //           color: isTapped ? c3690E3 : cE2DEDE.withOpacity(0.2),
  //         )
  //       ),
  //       child: Center(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             title == 'Upload Files'
  //             ? SizedBox(
  //               width: 20,
  //               height: 20,
  //               child: Image.asset(
  //                 ImageAssets.uploadPng,
  //                 fit: BoxFit.fill,
  //               ),
  //             ) : const SizedBox.shrink(),
  //             title == 'Upload Files'
  //             ? const SizedBox(width: 5) : const SizedBox.shrink(),
  //             Text(
  //               title,
  //               style: isTapped ? TextStyles.s14_w500_c3690E3 : TextStyles.s14_w500_c000000,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }   

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