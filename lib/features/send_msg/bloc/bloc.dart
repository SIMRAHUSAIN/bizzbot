// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/send_msg/bloc/event.dart';
import 'package:mim_whatsup/features/send_msg/bloc/state.dart';
import 'package:mim_whatsup/features/send_msg/model/countryCode_model.dart';
import 'package:mim_whatsup/features/send_msg/model/send_schedule_model.dart';
import 'package:mim_whatsup/features/send_msg/model/templateId_model.dart';
import 'package:mim_whatsup/features/send_msg/model/csv_model.dart';
import 'package:mim_whatsup/features/send_msg/model/get_group_model.dart';
import 'package:mim_whatsup/features/send_msg/model/templateType_model.dart';
import 'package:mim_whatsup/features/send_msg/repo/repo.dart';
import 'package:mim_whatsup/utils/jsonPostData.dart';

import '../model/template_id_message_model.dart';
import '../unique_count/model/get_unique_count_model.dart';
import '../model/post_group_model.dart';

class SendMessageBloc extends Bloc<SendMsgEvent, SendMessageState> {
  
  SendMsgRepo repo;
  SendMessageBloc({required this.repo}) : super(SendMsgInitialState()) {

    on<GetCountryCodeEvent>(((event, emit) async {
      emit(SendMsgLoadingState());
      try{
        CountryCodeModel countryCodeModel = await repo.getCountryCode();
        if(countryCodeModel.statusCode == 200) {
          debugPrint('Code 001');
          emit(CountryCdSuccessState(countryCodeModel));
        } else {
          debugPrint('Code 002');
          emit(CountryCdFailedState(countryCodeModel.error.toString()));
        }
      } catch(e) {
        debugPrint('Code 003');
        emit(CountryCdFailedState(e.toString()));
      }
    }));

    on<GetTemplateTypeEvent>(((event, emit) async {
      emit(SendMsgLoadingState());
      try{
        TemplateTypeModel templateTypeModel = await repo.getTemplateType();
        if(templateTypeModel.statusCode == 200) {
          debugPrint('Temp 001');
          emit(TemplateTypeSuccessState(templateTypeModel));
        } else {
          debugPrint('Temp 002');
          emit(TemplateTypeFailedState(templateTypeModel.error.toString()));
        }
      } catch(e) {
        debugPrint('Temp 003');
        emit(TemplateTypeFailedState(e.toString()));
      }
    }));

    on<GetTemplateIdEvent>(((event, emit) async {
      emit(SendMsgLoadingState());
      try{
        TemplateIdModel templateIdModel = await repo.getTemplateId();
        if(templateIdModel.statusCode == 200) {
          debugPrint('TempId 001');
          emit(TemplateIdSuccessState(templateIdModel));
        } else {
          debugPrint('TempId 002');
          emit(TemplateIdFailedState(templateIdModel.error.toString()));
        }
      } catch(e) {
        debugPrint('TempId 003 $e.toString()');
        emit(TemplateIdFailedState(e.toString()));
      }
    }));

    on<GetSendorScheduleEvent>(((event, emit) async {
      emit(SendMsgLoadingState());
      try{
        Map jsonPostData  = RequestUtils().getSendSchedule(
          countrycode: event.countrycode,
          whatsappType: event.whatsappType,
          campaignName: event.campaignName,
          xLUPLOADED: event.xLUPLOADED,
          uPLOADFILENM: event.uPLOADFILENM,
          group: event.group,
          dTXLDistinct: event.dTXLDistinct,
          totalgroupMember: event.totalgroupMember,
          mobileList: event.mobileList,
          allowDuplicate: event.allowDuplicate,
          duplicate: event.duplicate,
          notDuplicate: event.notDuplicate,
          mobileCount: event.mobileCount,
          manual: event.manual,
          templateId: event.templateId,
          cbFailover: event.cbFailover,
          fileOrUrl: event.fileOrUrl,
          mediaUName: event.mediaUName,
          fileUrl: event.fileUrl,
          caption: event.caption,
          msgText: event.msgText,
          locnameid: event.locnameid,
          headerType: event.headerType,
          lstMappedField: event.lstMappedField,
          senderId: event.senderId,
          chkOptOut: event.chkOptOut,
          optOut: event.optOut,
          lstTemplateFld: event.lstTemplateFld,
          lstScheduleDate: event.lstScheduleDate,
          mediaFileName: event.mediaFileName,
          mediaUrl: event.mediaUrl,
          scratchCard: event.scratchCard,
          totCount: event.totCount,
          preview: event.preview,
          textBox1: event.textBox1,
          textBox2: event.textBox2,
          textBox3: event.textBox3,
          textBox4: event.textBox4,
          textBox5: event.textBox5,
          textBox6: event.textBox6,
          textBox7: event.textBox7,
          textBox8: event.textBox8,
          textBox9: event.textBox9,
          textBox10: event.textBox10,
        );
        SendScheduleModel sendScheduleModel = await repo.getSendorSchedule(
          jsonPostData,
        );
        if(sendScheduleModel.statusCode == 200) {
          debugPrint('Send 001');
          emit(SendOrScheduleSuccessState(sendScheduleModel));
        } else {
          debugPrint('Send 002');
          emit(SendOrScheduleFailedState(sendScheduleModel.error.toString()));
        }
      } catch(e) {
        debugPrint('Send 003 $e.toString()');
        emit(SendOrScheduleFailedState(e.toString()));
      }
    }));
    on<GetGroupEvent>(((event, emit) async {
      emit(GetGroupLoadingState());
      try{
        GetGroupModel getGroupModel = await repo.getGroup();
        if(getGroupModel.statusCode == 200) {
          debugPrint('Temp 001');
          emit(GetGroupSuccessState(getGroupModel));
        } else {
          debugPrint('Temp 002');
          emit(GetGroupFailedState(getGroupModel.error.toString()));
        }
      } catch(e) {
        debugPrint('Temp 003');
        emit(GetGroupFailedState(e.toString()));
      }
    }));

    on<UploadCsv>(((event, emit) async {
      emit(UploadCsvLoadingState());
      try{
        CsvModel csvModel = await repo.getCsv(file: event.fileType!);
        if(csvModel.statusCode == "200") {
          debugPrint('Temp 001');
          emit(UploadCsvSuccessState(csvModel));
        } else {
          debugPrint('Temp 002');
          emit(UploadCsvFailedState(csvModel.error.toString()));
        }
      } catch(e) {
        debugPrint('Temp 003');
        emit(UploadCsvFailedState(e.toString()));
      }
    }));

    on<PostGroupEvent>(((event, emit) async {
      emit(PostGroupLoadingState());
      try{
        Map jsonPostData = {
          "ListGroupItem": event.groupId,
        };
        PostGroupModel postGroupModel = await repo.postGroup(jsonPostData: jsonPostData);
        if(postGroupModel.statusCode == 200) {
          debugPrint('Temp 001');
          emit(PostGroupSuccessState(postGroupModel));
        } else {
          debugPrint('Temp 002');
          emit(PostGroupFailedState(postGroupModel.error.toString()));
        }
      } catch(e) {
        debugPrint('Temp 003');
        emit(PostGroupFailedState(e.toString()));
      }
    }));

    on<GetTemplateIdMessageEvent>(((event, emit) async {
      emit(GetTemplateIdMessageLoadingState());
      try{
        TemplateIdMessageModel getTemplateIdMessageModel = await repo.getTemplateIdMessage(id: event.groupId);
        if(getTemplateIdMessageModel.statusCode == 200) {
          debugPrint('Temp 001');
          emit(GetTemplateIdMessageSuccessState(getTemplateIdMessageModel));
        } else {
          debugPrint('Temp 002');
          emit(GetTemplateIdMessageFailedState(getTemplateIdMessageModel.error.toString()));
        }
      } catch(e) {
        debugPrint('Temp 003');
        emit(GetTemplateIdMessageFailedState(e.toString()));
      }
    }));
  }
}