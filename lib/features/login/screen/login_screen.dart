// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/login/bloc/bloc.dart';
import 'package:mim_whatsup/features/login/bloc/event.dart';
import 'package:mim_whatsup/features/login/bloc/state.dart';
import 'package:mim_whatsup/features/login/model/login_model.dart';
import 'package:mim_whatsup/home_screen.dart';
import 'package:mim_whatsup/utils/assets.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/global_variables.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/solid_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginSuccessModel loginSuccessModel = LoginSuccessModel();

  Future<void>? _launched;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  final Uri toLaunch =  Uri(scheme: 'https', path: '//privacypolicy.myinboxmedia.in/privacy-policy.html');

  void sharedPrefIdPassword() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("Id", _userNameController.text);
    prefs.setString("Password", _passwordController.text);
    prefs.setBool("LoggedIn", true);
  }

  void sharedPrefToken(String token) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("Token", token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.9],
              colors: [
                c577D91,
                cFFFFFF,
              ]
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              debugPrint('Login listener states ==> $state');
                if(state is AuthTokenSuccessState) {
                  sharedPrefToken(state.tokenModel.data!.token.toString());
                  BlocProvider.of<LoginBloc>(context).add(
                    GetLoginEvent(
                      userName: 'MIM2200038',
                      passWord: 'FE1F\$FD9_738'
                    )
                  );
                } else if(state is AuthTokenFailedState) {
                  _getAlertSnackbar(state.message.toString());
                } else if(state is LoginSuccessState) {
                  loginSuccessModel = state.loginModel.data!;
                  sharedPrefIdPassword();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                } else if(state is LoginFailedState) {
                  _getAlertSnackbar(state.message.toString());
                }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return _getBodyContent();
              },
            ),
          )
        ),
      ),
    );
  }

  _getAlertSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          message,
          textAlign: TextAlign.center,
        )
      ),
    );
  }

  _getBodyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _getLoginText(),
        _getAppIcon(),
        _getUserNameTextfield(),
        _getPasswordTextfield(),
        _getLoginButton()
      ],
    );
  }

  _getUserNameTextfield() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      margin: const EdgeInsets.only(top: 40),
      child: TextFormField(
        autofillHints: const [AutofillHints.username],
        textAlign: TextAlign.start,
        onSaved: (String? val) {
          _userNameController.text = val!;
        },
        controller: _userNameController,
        enabled: true,
        style: TextStyles.s14_w400_cB3AEAE,
        decoration: InputDecoration(
          hintText: Strings.usrnmeTxtFldLbl,
          hintStyle: TextStyles.s14_w400_c939292,
          filled: true,
          fillColor: cFFFFFF,
          counterText: '',
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 0.75, color: c939292)
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 0.75, color: c939292)
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 0.75, color: c939292)
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 0.75, color: c939292)
          ),
        ),
        onChanged: (value) {},
      ),
    );
  }

  _getPasswordTextfield() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        autofillHints: const [AutofillHints.password],
        textAlign: TextAlign.start,
        onSaved: (String? val) {
          _passwordController.text = val!;
        },
        controller: _passwordController,
        enabled: true,
        obscureText: true,
        style: TextStyles.s14_w400_cB3AEAE,
        decoration: InputDecoration(
          hintText: Strings.psswrdTxtFldLbl,
          hintStyle: TextStyles.s14_w400_c939292,
          filled: true,
          fillColor: cFFFFFF,
          counterText: '',
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 0.75, color: c939292)
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 0.75, color: c939292)
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 0.75, color: c939292)
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 0.75, color: c939292)
          ),
        ),
        onChanged: (value) {},
      ),
    );
  }

  _getAppIcon() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Image.asset(
              ImageAssets.appLogoPng,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            Strings.appLbl,
            style: TextStyles.s25_w900_c2488B4_inter,
          ),
        ],
      ),
    );
  }
  
  _getLoginText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 150),
        Text(
          Strings.login,
          style: TextStyles.s22_w500_cFFFFFF_inter,
        ),
      ],
    );
  }

  _getLoginButton() {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          SoliButton(
            text: Strings.loginBtn,
            backgroundColor: cAAD4E7,
            textColor: c000000,
            textStyle: TextStyles.s16_w800,
            verticalSpacing: 15,
            onPressed: () async {
              if(_userNameController.text.isEmpty) {
                _getAlertSnackbar(Strings.emptyUsrNmTxt);
              } else if(_passwordController.text.isEmpty) {
                _getAlertSnackbar(Strings.emptyPsswrdTxt);
              } else {
                // if successfully logged in
                BlocProvider.of<LoginBloc>(context).add(
                  GetAuthTokenEvent(
                    // userName: 'MIM2200038',
                    // passWord: 'FE1F\$FD9_738' 
                    userName: _userNameController.text,
                    passWord: _passwordController.text,
                  )
                );
              }
            },
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              _launched = _launchInBrowser(toLaunch);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Privacy Policy', 
                  style: TextStyles.s12_w500_c000000_lato,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}