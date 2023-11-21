import 'dart:core';
import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class IndividualChatEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetIndividualChatEvent extends IndividualChatEvent {

  final String customerMobile;
  final String checkOld;

  GetIndividualChatEvent({required this.customerMobile, required this.checkOld});

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends IndividualChatEvent {

  final String customerMobile;
  final String templateName;
  final String type;
  final String text;
  final String fileName;

  SendMessageEvent({required this.customerMobile, required this.templateName,
    required this.type, required this.text, required this.fileName});

  @override
  List<Object> get props => [];
}

class SendFileEvent extends IndividualChatEvent {
  final File fileType;
  SendFileEvent({required this.fileType});

  @override
  List<Object> get props => [];
}
