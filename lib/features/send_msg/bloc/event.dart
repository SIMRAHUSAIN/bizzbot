import 'dart:core';
import 'package:equatable/equatable.dart';

abstract class SendMsgEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCountryCodeEvent extends SendMsgEvent {
  @override
  List<Object> get props => [];
}