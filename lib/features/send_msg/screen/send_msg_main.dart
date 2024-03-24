// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables, avoid_print

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mim_whatsup/features/send_msg/bloc/bloc.dart';
import 'package:mim_whatsup/features/send_msg/bloc/event.dart';
import 'package:mim_whatsup/features/send_msg/bloc/state.dart';
import 'package:mim_whatsup/utils/assets.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/action_button.dart';
import 'package:mim_whatsup/widgets/app_bar.dart';
import '../../../utils/assets.dart';
import 'group_list.dart';

class SendMsgMainScreen extends StatefulWidget {
  const SendMsgMainScreen({Key? key}) : super(key: key);

  @override
  State<SendMsgMainScreen> createState() => _SendMsgMainScreenState();
}

class _SendMsgMainScreenState extends State<SendMsgMainScreen> {

  final TextEditingController _cmpgnNmController = TextEditingController();
  final TextEditingController _whatsAppMessageController = TextEditingController();
  final TextEditingController date1Controller = TextEditingController();
  final TextEditingController time1Controller = TextEditingController();
  final TextEditingController date2Controller = TextEditingController();
  final TextEditingController time2Controller = TextEditingController();
  final TextEditingController date3Controller = TextEditingController();
  final TextEditingController time3Controller = TextEditingController();

  List<String?>? templateTypeList = [];
  List<String?>? countryCdList = [];
  List<String?>? templateIdList = [];

  String? templateTypeInitVal = '';
  String? countryCdInitVal = '';
  String? templateIdNameInitVal = '';
  String uploadFilePath = "";
  String totalCount = "0", uniqueCount = "0";
  Map<String, Map<String, int>> mapData = {};
  Map<int, TextEditingController> textControllers = {};


  bool isDuplicateData = false;
  bool isUploadFile = false;
  
  var groupData;
  List<Widget> textFields = [];
  String filePath = '';

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
      body: Container(
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
                for(int i = 0; i < state.templateTypeModel.data!.length; i++) {
                  templateTypeList!.add(state.templateTypeModel.data![i].templateType);
                }
              } 
              else if(state is TemplateIdSuccessState) {
                templateIdNameInitVal = state.templateIdModel.data![0].name!;
                for(int i = 0; i < state.templateIdModel.data!.length; i++) {
                  templateIdList!.add(state.templateIdModel.data![i].name.toString());
                }
                BlocProvider.of<SendMessageBloc>(context).add(
                    GetTemplateIdMessageEvent(
                        groupId: templateIdNameInitVal?.split(' ').first??""
                    )
                );
              }
              else if(state is SendOrScheduleSuccessState) {
                //
              } 
              else if(state is GetTemplateIdMessageSuccessState){
                  _whatsAppMessageController.text = state.templateIdMessageModel.data?[0].tbodytext??"";
                  _getVarTextField();
              }
            }),
            child: BlocBuilder<SendMessageBloc, SendMessageState>(
              builder: (((context, state) {
                return _getBodyContent();
              })),
            )
          ),
        )
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
              border: Border.all(color: Colors.grey), 
              borderRadius: BorderRadius.circular(8.0), 
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 5, 
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Enter up to five lines of text',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ):const SizedBox(),
        _tempIdDrpdwn(),
        _getWhtAppTxt(),
        _whatsAppMessageController.text.contains("{{")?
        Column(
          children: textFields,
        ):Container(),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _whatsAppMessageController,
            maxLines: 10,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              hintText: 'Whatsapp Text',
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  _getVarTextField() {
    String inputText = _whatsAppMessageController.text;
    List<String> splitText = inputText.split(RegExp(r'\{\{\d+\}\}'));
    for (int i = 0; i < splitText.length - 1; i++) {
      mapData["{{${i+1}}}"] = {"{{${i+1}}}": _whatsAppMessageController.text.indexOf("{{${i+1}}}")};
      print(mapData["{{${i+1}}}"]);
        TextEditingController controller = TextEditingController(text: '');
        textControllers[i] = controller;
        int initialIndex = 0;
        textFields.add(
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: MediaQuery.of(context).size.height * 0.07,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: c137700.withOpacity(0.08),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onChanged: (value) {
                      if(_whatsAppMessageController.text.contains("{{${i+1}}")){
                        initialIndex = _whatsAppMessageController.text.indexOf("{{${i+1}}}");
                      }
                      _updateText(i + 1, value, mapData, initialIndex, splitText.length);
                    },
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: "{{${i+1}}}",
                      border: InputBorder.none, // Hide TextField's border
                    ),
                  ),
                ),
              ),
            )
        );
      }
  }

  void _updateText(int index, String value, Map targetMapValue, int initialIndex, int splitTextLength) {
    Map<String, int> placeholderMap = targetMapValue["{{$index}}"];
    print("Hi index: $index value: $value map: $targetMapValue intialIndex: $initialIndex");
    String currentText = _whatsAppMessageController.text;
    // initialIndex = currentText.indexOf(index>1?targetMapValue["{{${index-1}}}"]:targetMapValue["{{${index}}}"], initialIndex);
    // int placeholderIndex = currentText.indexOf(placeholder, initialIndex);
    // if (placeholderIndex != -1) {
    //   int endIndex = placeholderIndex + placeholder.length;
    String placeHolderKey = placeholderMap.entries.first.key;
    int initial = placeholderMap[placeHolderKey]??0;
    print("HELLO Key: $placeHolderKey Value: $initial PlaceholderKey: ${placeHolderKey.length}");
    print("Interim Index Value: $index Value Length: ${value.length} Intial Value: $initial Total Length: ${initial+placeHolderKey.length}");
    String newText = currentText.replaceRange(
          initial, initial+placeHolderKey.length, value);
    if(index == 1){
      mapData["{{$index}}"] = {value: initial};
    }
    for (int i = index; i<splitTextLength-1; i++) {
      mapData["{{${i+1}}}"] = {mapData["{{${i+1}}}"]?.entries.first.key??"": ((mapData["{{${i+1}}}"]?.entries.first.value??0)+1-(_whatsAppMessageController.text.contains("{{1}}")?5:0))};
    }
    if(index > 1){
      mapData["{{$index}}"] = {value: ((mapData["{{$index}}"]?.entries.first.value??0))};
    }
    print("BYE New Map Value: $mapData");
      _whatsAppMessageController.text = newText;
    // }    // String newText = currentText.replaceAll(targetMapValue["{{$index}}"], value);
    // print("OK ${newText}");
    // mapData["{{$index}}"] = value;
    // _whatsAppMessageController.text = newText;
    // print("HII ${_whatsAppMessageController.text}");
  }

  _getActnBtnRow() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonActionButton(
            title: 'Send', 
            onTap: () {
              BlocProvider.of<SendMessageBloc>(context).add(
                GetSendorScheduleEvent(
                  countrycode: countryCdInitVal,
                  whatsappType: templateTypeInitVal,
                  campaignName: _cmpgnNmController.text,
                  xLUPLOADED: isUploadFile ? 'Y' : '',
                  uPLOADFILENM: filePath,
                  group: totalCount.isNotEmpty ? true : false,
                  dTXLDistinct: const [], // pass fetched group list
                  totalgroupMember: totalCount,
                  mobileList: '', // pas manually entered // it should be a list not string
                  allowDuplicate: isDuplicateData ? true : false,  
                  duplicate: '0', // always
                  notDuplicate: '0', // always
                  mobileCount: '', // Total Mobile Count in Case Of Manual
                  manual: true,  // if user types mobile numbers
                  templateId: templateIdNameInitVal?.split(' ').first ?? "",
                  cbFailover: false, // always
                  fileOrUrl: '',
                  mediaUName: '',
                  fileUrl: '',
                  caption: '',
                  msgText: '', // always
                  locnameid: '', // always
                  headerType: '', 
                  lstMappedField: const [],  // always
                  senderId: '', // always
                  chkOptOut: false, // always
                  optOut: '', // always
                  lstTemplateFld: const [], // always
                  lstScheduleDate: const [],
                  mediaFileName: '', // always
                  mediaUrl: '', // always
                  scratchCard: false, // always
                  totCount: '',
                  preview: '',
                  textBox1: "",
                  textBox2: "",
                  textBox3: "",
                  textBox4: "",
                  textBox5: "",
                  textBox6: "",
                  textBox7: "",
                  textBox8: "",
                  textBox9: "",
                  textBox10: "",
                )
              );
            },
            btnColor: cECF7FF,
          ),
          CommonActionButton(
            title: 'Cancel', 
            onTap: () {
              setState(() {
                _cmpgnNmController.clear();
                isUploadFile = false;
                // to reset dropdowns
              });
            },
            btnColor: cFFF1F1,
          ),
          CommonActionButton(
            title: 'Schedule', 
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return _getScheduleDialog();
                }
              );
            },
            btnColor: cFFF7EF,
          ),
        ],
      ),
    );
  }

  _tempIdDrpdwn() {
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
            child: Center(
              child: DropdownButtonFormField<String>(
                borderRadius: BorderRadius.circular(12),
                elevation: 4,
                hint: Text(
                  '--Select--', 
                  style: TextStyles.s14_w400_cB3AEAE,
                ),
                isExpanded: true,
                items: templateIdList != null
                    ? templateIdList!.map<DropdownMenuItem<String>>((String? value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.s16_w700_c137700,
                    ),
                  );
                }).toSet().toList() : [],
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: c137700,
                ),
                iconSize: 30,
                value: templateIdNameInitVal!.isNotEmpty ? templateIdNameInitVal : '',
                style: TextStyles.s16_w700_c137700,
                onChanged: _templateIdCallback,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
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
        ],
      ),
    );
  }

  _templateIdCallback(newValue) {
    setState(() {
      templateIdNameInitVal = newValue;
    });

    BlocProvider.of<SendMessageBloc>(context).add(
      GetTemplateIdMessageEvent(
        groupId: templateIdNameInitVal?.split(' ').first??""
      )
    );
    textFields = [];
  }

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
                showDialog(
                    context: context,
                    builder: (context) {
                      return _getUploadFileDialog();
                    }
                );
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
                groupData = showDialog(
                  context: context,
                  builder: (context) {
                    return GroupList(
                      callBack: (String totalCountValue, String uniqueCountValue){
                        totalCount = totalCountValue;
                        uniqueCount = uniqueCountValue;
                      }
                    );
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

  _getDuplicate() {
    return Row(
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: Checkbox(
            onChanged: (newValue) {
              setState(() {
                isDuplicateData = newValue!;
              });
            },
            value: isDuplicateData,
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

  _getUploadFileDialog() {
    return Dialog(
      backgroundColor: cFFFFFF,
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        height: MediaQuery.of(context).size.height * .16,
        width: MediaQuery.of(context).size.width * .7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles();
                    if (result != null) {
                      filePath = result.files.single.path!;
                      BlocProvider.of<SendMessageBloc>(context).add(
                          UploadCsv(fileType: File(filePath))
                      );
                      // Use the file path as needed
                    }
                    // upload file on tap
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    margin: const EdgeInsets.only(left: 10, right: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 1,
                            color: c606CC4
                        )
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          ImageAssets.uploadPng,
                          fit: BoxFit.fill,
                          height: 25,
                          width: 25,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Upload File',
                          style: TextStyles.s14_w700_c606CC4,
                        ),
                      ],
                    ),
                  ),
                ),
                BlocConsumer<SendMessageBloc, SendMessageState>(
                  listener: (context, state){
                    debugPrint('LAMA 4 $state');
                    if(state is UploadCsvSuccessState){
                      uploadFilePath = state.csvModel.data?.fileName??"";
                    }
                  },
                    builder: (context, state){
                      if(state is UploadCsvLoadingState){
                        return Text(
                          'No File Chosen',
                          style: TextStyles.s14_w600_c000000
                        );
                      }
                      else if(state is UploadCsvFailedState){
                        return Text(
                          'No File Chosen',
                          style: TextStyles.s14_w600_c000000
                        );
                      } else if(state is UploadCsvSuccessState){
                        return const Spacer();
                      } else {
                        return Text(
                            'No File Chosen',
                            style: TextStyles.s14_w600_c000000
                        );
                      }
                    }
                ),
              ],
            ),
            BlocBuilder<SendMessageBloc, SendMessageState>(
              builder: (context, state){
                if(state is UploadCsvLoadingState){
                  return const Padding(
                    padding: EdgeInsets.all(15),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if(state is UploadCsvSuccessState){
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                        state.csvModel.data?.fileName??"",
                        style: TextStyles.s14_w600_c000000
                    ),
                  );
                }
                else if(state is UploadCsvFailedState){
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        state.message??"",
                        style: TextStyles.s14_w400_cCC2525,
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              }
            )
          ],
        ),
      ),
    );
  }

  _getScheduleDialog() {
    return Dialog(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          child: Column(
              children: [
                Container(
                  color: c0D8578,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Schedule Message',
                        style: TextStyles.s14_w500_cFFFFFF,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: cFFFFFF,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Schedule Date 1',
                            style: TextStyles.s14_w600_c000000,
                          ),
                          GestureDetector(
                            onTap: () async {
                                DateTime? date = await showDatePicker(
                                  context: context,
                                  lastDate: DateTime(2100),
                                  firstDate: DateTime(1900),
                                  initialDate: DateTime.now(),
                                );
                                if(date != null) {
                                  String formattedDate = DateFormat('dd-mm-yyyy').format(date);
                                  setState(() {
                                    date1Controller.text = formattedDate;
                                  });
                                } 
                              },
                            child: Container(
                              height: 40,
                              width: 130,
                              margin: const EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                color: cFFFFFF,
                                border: Border.all(
                                  color: c000000,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 60,
                                    height: 40,
                                    child: TextField(
                                      controller: date1Controller,
                                      enabled: false,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: c000000,
                                      ),
                                      decoration: const InputDecoration(
                                          hintText: "dd-mm-yyyy",
                                          hintStyle: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey,
                                          ),
                                        contentPadding: EdgeInsets.zero
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    ImageAssets.calenderPng,
                                    fit: BoxFit.cover,
                                    height: 18,
                                    width: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Time (HH:MM)',
                            style: TextStyles.s14_w600_c000000,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final TimeOfDay? timePicker = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now()
                              );
                              if(timePicker != null) {
                                setState(() {
                                  time1Controller.text = "${timePicker.hour}:${timePicker.minute}";
                                });
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 120,
                              margin: const EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                color: cFFFFFF,
                                border: Border.all(
                                  color: c000000,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                controller: time1Controller,
                                  enabled: false,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: c000000,
                                  ),
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          // on click, new row of scheduler ui will pop up
                          // _schedulerWidget(1)
                        },
                        child: Image.asset(
                          ImageAssets.plusSignPng,
                          fit: BoxFit.cover,
                           height: 30,
                           width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 8),
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
                              'Schedule Message',
                              style: TextStyles.s14_w500_cFFFFFF,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              date1Controller.clear();
                              time1Controller.clear();
                            });
                            Navigator.pop(context);
                          },
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
                              Strings.cancelBtn,
                              style: TextStyles.s14_w500_cFFFFFF,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ]
          ),
        )
    );
  }

  // _schedulerWidget(int count) {
  //   return ListView.builder(
  //     itemCount: count,
  //     scrollDirection: Axis.vertical,
  //     itemBuilder: (BuildContext context, int index) {
  //       return Column(
  //         children: [
  //           Column(
  //                       children: [
  //                         Text(
  //                           'Schedule Date $index',
  //                           style: TextStyles.s14_w600_c000000,
  //                         ),
  //                         GestureDetector(
  //                           onTap: () async {
  //                               DateTime? date = await showDatePicker(
  //                                 context: context,
  //                                 lastDate: DateTime(2100),
  //                                 firstDate: DateTime(1900),
  //                                 initialDate: DateTime.now(),
  //                               );
  //                               if(date != null) {
  //                                 String formattedDate = DateFormat('dd-mm-yyyy').format(date);
  //                                 setState(() {
  //                                   date1Controller.text = formattedDate;
  //                                 });
  //                               } 
  //                             },
  //                           child: Container(
  //                             height: 40,
  //                             width: 130,
  //                             margin: const EdgeInsets.only(top: 5),
  //                             decoration: BoxDecoration(
  //                               color: cFFFFFF,
  //                               border: Border.all(
  //                                 color: c000000,
  //                                 width: 1,
  //                               ),
  //                               borderRadius: BorderRadius.circular(8),
  //                             ),
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                               crossAxisAlignment: CrossAxisAlignment.center,
  //                               children: [
  //                                 SizedBox(
  //                                   width: 60,
  //                                   height: 40,
  //                                   child: TextField(
  //                                     controller: date1Controller,
  //                                     enabled: false,
  //                                     style: const TextStyle(
  //                                       fontSize: 11,
  //                                       fontWeight: FontWeight.w700,
  //                                       color: c000000,
  //                                     ),
  //                                     decoration: const InputDecoration(
  //                                         hintText: "dd-mm-yyyy",
  //                                         hintStyle: TextStyle(
  //                                           fontSize: 10,
  //                                           fontWeight: FontWeight.w700,
  //                                           color: Colors.grey,
  //                                         ),
  //                                       contentPadding: EdgeInsets.zero
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Image.asset(
  //                                   ImageAssets.calenderPng,
  //                                   fit: BoxFit.cover,
  //                                   height: 18,
  //                                   width: 18,
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Column(
  //                       children: [
  //                         Text(
  //                           'Time (HH:MM)',
  //                           style: TextStyles.s14_w600_c000000,
  //                         ),
  //                         GestureDetector(
  //                           onTap: () async {
  //                             final TimeOfDay? timePicker = await showTimePicker(
  //                               context: context,
  //                               initialTime: TimeOfDay.now()
  //                             );
  //                             if(timePicker != null) {
  //                               setState(() {
  //                                 time1Controller.text = "${timePicker.hour}:${timePicker.minute}";
  //                               });
  //                             }
  //                           },
  //                           child: Container(
  //                             height: 40,
  //                             width: 120,
  //                             margin: const EdgeInsets.only(top: 5),
  //                             decoration: BoxDecoration(
  //                               color: cFFFFFF,
  //                               border: Border.all(
  //                                 color: c000000,
  //                                 width: 1,
  //                               ),
  //                               borderRadius: BorderRadius.circular(8),
  //                             ),
  //                             child: TextField(
  //                               controller: time1Controller,
  //                                 enabled: false,
  //                                 style: const TextStyle(
  //                                   fontSize: 12,
  //                                   fontWeight: FontWeight.w700,
  //                                   color: c000000,
  //                                 ),
  //                                 textAlign: TextAlign.center,
  //                                 decoration: const InputDecoration(
  //                                 contentPadding: EdgeInsets.zero
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     GestureDetector(
  //                       onTap: () {

  //                       },
  //                       child: Image.asset(
  //                         ImageAssets.plusSignPng,
  //                         fit: BoxFit.cover,
  //                          height: 30,
  //                          width: 30,
  //                       ),
  //                     ),
  //         ],
  //       );
  //     },
  //   );
  // }
}