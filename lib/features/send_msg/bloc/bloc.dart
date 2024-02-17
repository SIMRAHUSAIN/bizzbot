// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/send_msg/bloc/event.dart';
import 'package:mim_whatsup/features/send_msg/bloc/state.dart';
import 'package:mim_whatsup/features/send_msg/model/countryCode_model.dart';
import 'package:mim_whatsup/features/send_msg/model/templateType_model.dart';
import 'package:mim_whatsup/features/send_msg/repo/repo.dart';

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
  }
}