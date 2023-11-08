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
              debugPrint('Login states ==> $state');
                if(state is AuthTokenSuccessState) {
                  BlocProvider.of<LoginBloc>(context).add(
                    GetLoginEvent(
                      userName: 'MIM2200038',
                      passWord: 'FE1F\$FD9_738'
                    )
                  );
                } else if(state is AuthTokenFailedState) {
                  _getAlertSnackbar(state.message.toString());
                } else if(state is LoginSuccessState) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
        textAlign: TextAlign.start,
        onSaved: (String? val) {
          _userNameController.text = val!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return Strings.emptyUsrNmTxt;
          }
          return null;
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
        textAlign: TextAlign.start,
        onSaved: (String? val) {
          _passwordController.text = val!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return Strings.emptyPsswrdTxt;
          }
          return null;
        },
        controller: _passwordController,
        enabled: true,
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
          if(_userNameController.text.isEmpty) {
            _getAlertSnackbar(Strings.emptyUsrNmTxt);
          } else if(_passwordController.text.isEmpty) {
            _getAlertSnackbar(Strings.emptyPsswrdTxt);
          } else {
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
    );
  }
}