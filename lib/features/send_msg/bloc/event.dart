// ignore_for_file: must_be_immutable

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

class PostGroupEvent extends SendMsgEvent {
  List<String> groupId;
  PostGroupEvent({required this.groupId});
  @override
  List<Object> get props => [];
}

class GetTemplateIdMessageEvent extends SendMsgEvent {
  String groupId;
  GetTemplateIdMessageEvent({required this.groupId});
  @override
  List<Object> get props => [];
}

class GetSendorScheduleEvent extends SendMsgEvent {

  String? countrycode;
  String? whatsappType;
  String? campaignName;
  String? xLUPLOADED;
  String? uPLOADFILENM;
  bool? group;
  List<String>? dTXLDistinct;
  String? totalgroupMember;
  List<String>? mobileList;
  bool? allowDuplicate;
  String? duplicate;
  String? notDuplicate;
  String? mobileCount;
  bool? manual;
  String? templateId;
  bool? cbFailover;
  String? fileOrUrl;
  String? mediaUName;
  String? fileUrl;
  String? caption;
  String? msgText;
  String? locnameid;
  String? headerType;
  List<String>? lstMappedField;
  String? senderId;
  bool? chkOptOut;
  String? optOut;
  List<String>? lstTemplateFld;
  List<String>? lstScheduleDate;
  String? mediaFileName;
  String? mediaUrl;
  bool? scratchCard;
  String? totCount;
  String? preview;
  String? textBox1;
  String? textBox2;
  String? textBox3;
  String? textBox4;
  String? textBox5;
  String? textBox6;
  String? textBox7;
  String? textBox8;
  String? textBox9;
  String? textBox10;

  GetSendorScheduleEvent({
    required countrycode,
    required whatsappType,
    required campaignName,
    required xLUPLOADED,
    required uPLOADFILENM,
    required group,
    required dTXLDistinct,
    required totalgroupMember,
    required mobileList,
    required allowDuplicate,
    required duplicate,
    required notDuplicate,
    required mobileCount,
    required manual,
    required templateId,
    required cbFailover,
    required fileOrUrl,
    required mediaUName,
    required fileUrl,
    required caption,
    required msgText,
    required locnameid,
    required headerType,
    required lstMappedField,
    required senderId,
    required chkOptOut,
    required optOut,
    required lstTemplateFld,
    required lstScheduleDate,
    required mediaFileName,
    required mediaUrl,
    required scratchCard,
    required totCount,
    required preview,
    required textBox1,
    required textBox2,
    required textBox3,
    required textBox4,
    required textBox5,
    required textBox6,
    required textBox7,
    required textBox8,
    required textBox9,
    required textBox10,
  });

  @override
  List<Object> get props => [];
}