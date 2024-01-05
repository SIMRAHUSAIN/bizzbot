// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/dashboard/bloc/bloc.dart';
import 'package:mim_whatsup/features/dashboard/bloc/event.dart';
import 'package:mim_whatsup/features/dashboard/bloc/state.dart';
import 'package:mim_whatsup/features/individual_chat/bloc/bloc.dart';
import 'package:mim_whatsup/features/individual_chat/bloc/event.dart';
import 'package:mim_whatsup/features/individual_chat/bloc/state.dart';
import 'package:mim_whatsup/features/login/bloc/bloc.dart';
import 'package:mim_whatsup/features/login/bloc/event.dart';
import 'package:mim_whatsup/features/login/bloc/state.dart';
import 'package:mim_whatsup/features/login/model/login_model.dart';
import 'package:mim_whatsup/features/user_chat/bloc/bloc.dart';
import 'package:mim_whatsup/features/user_chat/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat/bloc/state.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/bloc.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/state.dart';
import 'package:mim_whatsup/home_screen.dart';
import 'package:mim_whatsup/utils/assets.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/global_variables.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/solid_button.dart';
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
                  if(GlobalVar.visitedCount == 0){
                    BlocProvider.of<LoginBloc>(context).add(
                        GetLoginEvent(
                            userName: 'MIM2200038',
                            passWord: 'FE1F\$FD9_738'
                        )
                    );
                    GlobalVar.visitedCount++;
                  } else {
                    print("KELA " + GlobalVar.globalToken);
                    if(GlobalVar.recentEvent[0] is DashboardFailedState){
                      BlocProvider.of<DashboardBloc>(context).add(
                          GetDashboardEvent()
                      );
                    } else if(GlobalVar.recentEvent[0] is ActiveChatFailedState){
                      BlocProvider.of<ChatBloc>(context).add(
                          GetActiveChatEvent()
                      );
                    } else if(GlobalVar.recentEvent[0] is OldChatFailedState){
                      BlocProvider.of<ChatBloc>(context).add(
                          GetOldChatEvent()
                      );
                    } else if(GlobalVar.recentEvent[0] is SortChatFailedState){
                      BlocProvider.of<ChatBloc>(context).add(
                          GetSortChatEvent(chatType: GlobalVar.activeTab == 0?"0":"1")
                      );
                    } else if(GlobalVar.recentEvent[0] is UnreadChatFailedState){
                      BlocProvider.of<ChatBloc>(context).add(
                          GetUnreadChatEvent(chatType: GlobalVar.activeTab == 0?"0":"1")
                      );
                    } else if(GlobalVar.recentEvent[0] is FilteredChatFailedState){
                      BlocProvider.of<ChatBloc>(context).add(
                          GetFilteredChatEvent(
                            chatType: GlobalVar.activeTab == 0?"0":"1",
                            flagName: GlobalVar.filterFlagName,
                            flagId: GlobalVar.filterFlagId
                          )
                      );
                    } else if(GlobalVar.recentEvent[0] is FetchChatLabelFailedState){
                      BlocProvider.of<ChatFilterBloc>(context).add(GetChatLabelEvent(mobileNo: GlobalVar.filterMobile));
                    } else if(GlobalVar.recentEvent[0] is UnreadMessageFailedState){
                      BlocProvider.of<ChatFilterBloc>(context).add(
                          UnreadMessageEvent(
                            customerMobile: GlobalVar.filterMobile,
                          )
                      );
                    } else if(GlobalVar.recentEvent[0] is IndividualChatFailedState){
                       BlocProvider.of<IndividualChatBloc>(context).add(GetIndividualChatEvent(customerMobile: GlobalVar.filterMobile, checkOld: '1'));
                    }
                  }
                } else if(state is AuthTokenFailedState) {
                  _getAlertSnackbar(state.message.toString());
                } else if(state is LoginSuccessState) {
                  loginSuccessModel = state.loginModel.data!;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(loginSuccessModel: loginSuccessModel)));
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
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return Strings.emptyUsrNmTxt;
        //   }
        //   return null;
        // },
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
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return Strings.emptyPsswrdTxt;
        //   }
        //   return null;
        // },
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
            onPressed: () {
              // if(_userNameController.text.isEmpty) {
              //   _getAlertSnackbar(Strings.emptyUsrNmTxt);
              // } else if(_passwordController.text.isEmpty) {
              //   _getAlertSnackbar(Strings.emptyPsswrdTxt);
              // } else {
                BlocProvider.of<LoginBloc>(context).add(
                  GetAuthTokenEvent(
                    userName: 'MIM2200038',
                    passWord: 'FE1F\$FD9_738'
                    // userName: _userNameController.text,
                    // passWord: _passwordController.text,
                  )
                );
              //}
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