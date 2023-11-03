import 'dart:core';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAuthTokenEvent extends LoginEvent {
  final String? userName;
  final String? passWord;

  GetAuthTokenEvent({this.userName, this.passWord});

  @override
  List<Object> get props => [];
}

class GetLoginEvent extends LoginEvent {
  final String? userName;
  final String? passWord;

  GetLoginEvent({this.userName, this.passWord});

  @override
  List<Object> get props => [];
}