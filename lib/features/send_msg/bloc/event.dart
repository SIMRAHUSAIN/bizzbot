import 'dart:core';
import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class SendMsgEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCountryCodeEvent extends SendMsgEvent {
  @override
  List<Object> get props => [];
}

class GetTemplateTypeEvent extends SendMsgEvent {
  @override
  List<Object> get props => [];
}

class GetTemplateIdEvent extends SendMsgEvent {
  @override
  List<Object> get props => [];
}

class GetGroupEvent extends SendMsgEvent {
  @override
  List<Object> get props => [];
}

class UploadCsv extends SendMsgEvent {
  final File fileType;
  UploadCsv({required this.fileType});
  @override
  List<Object> get props => [];
}