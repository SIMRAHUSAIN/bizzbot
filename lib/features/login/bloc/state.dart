import 'package:equatable/equatable.dart';
import 'package:mim_whatsup/features/login/model/login_model.dart';
import 'package:mim_whatsup/features/login/model/token_model.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {
  LoginInitialState();

  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  LoginLoadingState();

  @override
  List<Object> get props => [];
}

class AuthLoadingState extends LoginState {
  AuthLoadingState();
  
  @override
  List<Object> get props => [];
}

class AuthTokenSuccessState extends LoginState {
  final TokenModel tokenModel;
  AuthTokenSuccessState(this.tokenModel);

  @override
  List<Object> get props => [];
}

class AuthTokenFailedState extends LoginState {
  final String? message;
  AuthTokenFailedState(this.message);

  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginState {
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);

  @override
  List<Object> get props => [];
}

class LoginFailedState extends LoginState {
  final String? message;
  LoginFailedState(this.message);
  
  @override
  List<Object> get props => [];
}