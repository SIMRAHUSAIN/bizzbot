// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/login/bloc/event.dart';
import 'package:mim_whatsup/features/login/bloc/state.dart';
import 'package:mim_whatsup/features/login/model/login_model.dart';
import 'package:mim_whatsup/features/login/model/token_model.dart';
import 'package:mim_whatsup/utils/jsonPostData.dart';
import 'package:mim_whatsup/utils/global_variables.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  
  var repo;
  LoginBloc({this.repo}) : super(LoginInitialState()) {

    on<GetAuthTokenEvent>((event, emit) async {
      emit(LoginLoadingState());
      try{
        debugPrint('Auth 1');
        Map jsonPostData  = RequestUtils().getAuthToken(
          userName: event.userName,
          passWord: event.passWord,
        );
        TokenModel tokenModel = await repo.getToken(
          jsonPostData: jsonPostData,
        );
        if(tokenModel.statusCode == 200) {
          debugPrint('Auth 2');
          GlobalVar.globalToken = tokenModel.data?.token?? '';
          emit(AuthTokenSuccessState(tokenModel));
        } else {
          debugPrint('Auth 3');
          emit(AuthTokenFailedState(tokenModel.data!.message.toString()));
        }
      } catch(e) {
        debugPrint('Auth 4');
        emit(AuthTokenFailedState(e.toString()));
      }
    });

    on<GetLoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      try{
        debugPrint('Login 1');
        Map jsonPostData  = RequestUtils().getLoginDetail(
          userName: event.userName,
          passWord: event.passWord,
        );
        LoginModel loginModel = await repo.getLogin(
          jsonPostData: jsonPostData,
        );
        if(loginModel.statusCode == 200) {
          debugPrint('Login 2');
          GlobalVar.mobileNo = loginModel.data?.agentMobile! ?? "";
          emit(LoginSuccessState(loginModel));
        } else {
          debugPrint('Login 3');
          emit(LoginFailedState(loginModel.data.toString()));
        }
      } catch(e) {
        debugPrint('Login 4');
        emit(LoginFailedState(e.toString()));
      }
    });
  }
}