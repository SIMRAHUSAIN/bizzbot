import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/send_msg/bloc/bloc.dart';
import 'package:mim_whatsup/features/send_msg/bloc/event.dart';
import 'package:mim_whatsup/features/send_msg/bloc/state.dart';
import 'package:mim_whatsup/utils/assets.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/action_button.dart';
import 'package:mim_whatsup/widgets/app_bar.dart';

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
  String? templateIdInitVal;

  bool? isDuplicateData = false;

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
                for(int i = 0; i < state.templateIdModel.data!.length; i++) {
                  templateIdList!.add(state.templateIdModel.data![i].name.toString());
                }
              }
              else if(state is SendOrScheduleSuccessState) {
                //
              }
            }),
            child: BlocBuilder<SendMessageBloc, SendMessageState>(
              builder: (((context, state) {
                return _getBodyContent();
              })),
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
          CommonActionButton(
            title: 'Send', 
            onTap: () {
              // BlocProvider.of<SendMessageBloc>(context).add(
              //   GetSendorScheduleEvent(
              //     countrycode: countryCdInitVal,
              //     whatsappType: templateTypeInitVal,
              //     campaignName: _cmpgnNmController.text,
              //     xLUPLOADED: '',
              //     uPLOADFILENM: '',
              //     group: false,
              //     dTXLDistinct: '',
              //     totalgroupMember: '',
              //     mobileList: '',
              //     allowDuplicate: false,  
              //     duplicate: false,
              //     notDuplicate: false,
              //     mobileCount: '',
              //     manual: true,
              //     templateId: '',
              //     cbFailover: false,
              //     fileOrUrl: event.fileOrUrl,
              //     mediaUName: event.mediaUName,
              //     fileUrl: event.fileUrl,
              //     caption: event.caption,
              //     msgText: '',
              //     locnameid: '',
              //     headerType: event.headerType,
              //     lstMappedField: event.lstMappedField,
              //     senderId: event.senderId,
              //     chkOptOut: false,
              //     optOut: event.optOut,
              //     lstTemplateFld: event.lstTemplateFld,
              //     lstScheduleDate: event.lstScheduleDate,
              //     mediaFileName: event.mediaFileName,
              //     mediaUrl: event.mediaUrl,
              //     scratchCard: event.scratchCard,
              //     totCount: event.totCount,
              //     preview: event.preview,
              //     textBox1: event.textBox1,
              //     textBox2: event.textBox2,
              //     textBox3: event.textBox3,
              //     textBox4: event.textBox4,
              //     textBox5: event.textBox5,
              //     textBox6: event.textBox6,
              //     textBox7: event.textBox7,
              //     textBox8: event.textBox8,
              //     textBox9: event.textBox9,
              //     textBox10: event.textBox10,
              //   )
              // );
              /* 
              "{
    ""JSONPostData"": {
        ""Countrycode"": ""91"",
        ""WhatsappType"": ""Media Template"",
        ""CampaignName"": ""25OCTtesting1"",
        ""XLUPLOADED"": ""Y"",
        ""UPLOADFILENM"": ""MIM2200038_20231025113546045.csv"",
        ""group"": """",
        ""DTXLDistinct"": [],
        ""TotalgroupMember"": """",
        ""MobileList"": """",
        ""AllowDuplicate"": ""false"",
        ""Duplicate"": """",
        ""NotDuplicate"": ""2"",
        ""MobileCount"": ""2"",
        ""Manual"": ""false"",
        ""TemplateId"": ""1716"",
        ""CbFailover"": ""false"",
        ""FileOrUrl"": ""FILE"",
        ""MediaUName"": ""2ec7bbd3-3cbc-445b-8593-277af7b98790.png"",
        ""FileUrl"": """",
        ""Caption"": """",
        ""MsgText"": ""Hello {{1}} Testing image"",
        ""Locname"": """",
        ""HeaderType"": """",
        ""lstMappedField"": [],
        ""SenderId"": """",
        ""chkOptOut"": ""false"",
        ""OptOut"": ""DND7726"",
        ""lstTemplateFld"": [],
        ""lstScheduleDate"": [],
        ""MediaFileName"": """",
        ""MediaUrl"": ""2ec7bbd3-3cbc-445b-8593-277af7b98790.png"",
        ""ScratchCard"": ""0"",
        ""TotCount"": ""2"",
        ""Preview"": """",
        ""TextBox1"": ""Hello"",
        ""TextBox2"": """",
        ""TextBox3"": """",
        ""TextBox4"": """",
        ""TextBox5"": """",
        ""TextBox6"": """",
        ""TextBox7"": """",
        ""TextBox8"": """",
        ""TextBox9"": """",
        ""TextBox10"": """"
    }
}"
              */
            },
            btnColor: cECF7FF,
          ),
          CommonActionButton(
            title: 'Cancel', 
            onTap: () {
              setState(() {
                _cmpgnNmController.clear();
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
                items: templateIdList!.map<DropdownMenuItem<String>>((String? value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
      templateIdInitVal = newValue;
    });
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
              () {
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
        height: MediaQuery.of(context).size.height * .18,
        width: MediaQuery.of(context).size.width * .7,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
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
                InkWell(
                  onTap: () {},
                  child: Text(
                    'No File Chosen',
                    style: TextStyles.s14_w600_c000000
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Maximum File Size 6MB',
              style: TextStyles.s14_w400_cCC2525,
            ),
            const SizedBox(height: 10),
            Text(
              '(Mobile numbers with Country code)',
              style: TextStyles.s14_w600_cCC2525,
            ),
          ],
        ),
      ),
    );
  }

  _getScheduleDialog() {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          children: [
            Container(
              color: c0D8578,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
              height: MediaQuery.of(context).size.height * 0.28,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'Schedule Date 1',
                        style: TextStyles.s14_w600_c000000,
                      ),
                      Container(
                        height: 40,
                        width: 100,
                        margin: const EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          color: cFFFFFF,
                          border: Border.all(
                            color: c000000,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(''),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Time (HH:MM)',
                        style: TextStyles.s14_w600_c000000,
                      ),
                      Container(
                        height: 40,
                        width: 100,
                        margin: const EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          color: cFFFFFF,
                          border: Border.all(
                            color: c000000,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(''),
                      ),
                    ],
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
                          Strings.cancelBtn,
                          style: TextStyles.s14_w500_cFFFFFF,
                        ),
                      ),
                    ),
                ],
              )
            ),
          ]
        )
      )
    );
  }
}