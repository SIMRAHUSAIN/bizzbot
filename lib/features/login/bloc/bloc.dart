// ignore_for_file: prefer_typing_uninitialized_variables

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
        Map jsonPostData  = RequestUtils().getAuthToken(
          userName: event.userName,
          passWord: event.passWord,
        );
        TokenModel tokenModel = await repo.getToken(
          jsonPostData: jsonPostData,
        );
        if(tokenModel.statusCode == 200) {
          GlobalVar.globalToken = tokenModel.data?.token?? '';
          emit(AuthTokenSuccessState(tokenModel));
        } else {
          emit(AuthTokenFailedState(tokenModel.data.toString()));
        }
      } catch(e) {
        emit(AuthTokenFailedState(e.toString()));
      }
    });

    on<GetLoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      try{
        Map jsonPostData  = RequestUtils().getLoginDetail(
          userName: event.userName,
          passWord: event.passWord,
        );
        LoginModel loginModel = await repo.getLogin(
          jsonPostData: jsonPostData,
        );
        if(loginModel.status == 200) {
          emit(LoginSuccessState(loginModel));
        } else {
          emit(LoginFailedState(loginModel.success.toString()));
        }
      } catch(e) {
        emit(AuthTokenFailedState(e.toString()));
      }
    });
  }
}