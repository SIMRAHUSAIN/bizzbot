import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/login/bloc/bloc.dart';
import 'package:mim_whatsup/features/login/bloc/event.dart';
import 'package:mim_whatsup/features/login/bloc/state.dart';
import 'package:mim_whatsup/home_screen.dart';
import 'package:mim_whatsup/utils/assets.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/solid_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              debugPrint('Auth list states $state');
              if(state is AuthTokenSuccessState) {
                  BlocProvider.of<LoginBloc>(context).add(
                    GetLoginEvent(
                      userName: 'MIM2200038',
                      passWord: 'FE1F\$FD9_738'
                    )
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                } else if(state is AuthTokenFailedState) {
                  // show alert
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
        textAlign: TextAlign.start,
        onSaved: (String? val) {
          _userNameController.text = val!;
        },
        autovalidateMode: AutovalidateMode.always,
        controller: _userNameController,
        enabled: true,
        maxLength: 1,
        style: TextStyles.s14_w400_cFFE3E1,
        decoration: const InputDecoration(
          hintText: Strings.usrnmeTxtFldLbl,
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: c939292
          ),
          filled: true,
          fillColor: cFFFFFF,
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 0.75, color: c939292)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 0.75, color: c939292)
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 0.75, color: c939292)
          ),
          focusedBorder: OutlineInputBorder(
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
        textAlign: TextAlign.start,
        onSaved: (String? val) {
          _passwordController.text = val!;
        },
        autovalidateMode: AutovalidateMode.always,
        controller: _passwordController,
        enabled: true,
        maxLength: 1,
        style: TextStyles.s14_w400_cFFE3E1,
        decoration: const InputDecoration(
          hintText: Strings.psswrdTxtFldLbl,
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: c939292
          ),
          filled: true,
          fillColor: cFFFFFF,
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 0.75, color: c939292)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 0.75, color: c939292)
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 0.75, color: c939292)
          ),
          focusedBorder: OutlineInputBorder(
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
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        width: 160,
        height: 160,
        child: Image.asset(
          ImageAssets.appLogoPng,
          fit: BoxFit.fill,
        ),
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
          style: TextStyles.s22_w700_c000000,
        ),
      ],
    );
  }

  _getLoginButton() {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: SoliButton(
        text: Strings.loginBtn,
        backgroundColor: cAAD4E7,
        textColor: c000000,
        textStyle: TextStyles.s16_w800,
        verticalSpacing: 15,
        onPressed: () {
          BlocProvider.of<LoginBloc>(context).add(
            GetAuthTokenEvent(
              userName: 'MIM2200038',
              passWord: 'FE1F\$FD9_738'
            )
          );
        },
      ),
    );
  }
}