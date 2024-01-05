import 'package:flutter/material.dart';
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

  final TextEditingController _cntrycodeController = TextEditingController();
    final TextEditingController _whtsAppTypController = TextEditingController();
      final TextEditingController _cmpgnNmController = TextEditingController();

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
        _getCountryCodeTxtFld(),
        _getWhtsAppTypTxtFld(),
        _getCmpgnNmTxtFld()
      ],
    );
  }

  _getCountryCodeTxtFld() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      margin: const EdgeInsets.only(top: 40),
      child: TextFormField(
        // autofillHints: const [AutofillHints.username],
        textAlign: TextAlign.start,
        onSaved: (String? val) {
          _cntrycodeController.text = val!;
        },
        controller: _cntrycodeController,
        enabled: true,
        style: TextStyles.s14_w400_cB3AEAE,
        decoration: InputDecoration(
          hintText: Strings.compCd,
          hintStyle: TextStyles.s14_w400_c939292,
          label: const Text(Strings.countryCode),
          labelStyle: TextStyles.s16_w500_c137700,
          filled: true,
          fillColor: cFFFFFF,
          counterText: '',
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

  _getWhtsAppTypTxtFld() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      margin: const EdgeInsets.only(top: 40),
      child: TextFormField(
        // autofillHints: const [AutofillHints.username],
        textAlign: TextAlign.start,
        onSaved: (String? val) {
          _whtsAppTypController.text = val!;
        },
        controller: _whtsAppTypController,
        enabled: true,
        style: TextStyles.s14_w400_cB3AEAE,
        decoration: InputDecoration(
          hintText: Strings.compCd,
          hintStyle: TextStyles.s14_w400_c939292,
          label: const Text(Strings.whatsappType),
          labelStyle: TextStyles.s16_w500_c137700,
          filled: true,
          fillColor: cFFFFFF,
          counterText: '',
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

  _getCmpgnNmTxtFld() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      margin: const EdgeInsets.only(top: 40),
      child: TextFormField(
        // autofillHints: const [AutofillHints.username],
        textAlign: TextAlign.start,
        onSaved: (String? val) {
          _cmpgnNmController.text = val!;
        },
        controller: _cmpgnNmController,
        enabled: true,
        style: TextStyles.s14_w400_cB3AEAE,
        decoration: InputDecoration(
          label: const Text(Strings.campaignNm),
          labelStyle: TextStyles.s16_w500_c137700,
          filled: true,
          fillColor: cFFFFFF,
          counterText: '',
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
}