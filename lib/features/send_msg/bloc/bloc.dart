// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/send_msg/bloc/event.dart';
import 'package:mim_whatsup/features/send_msg/bloc/state.dart';
import 'package:mim_whatsup/features/send_msg/model/countryCode_model.dart';

class SendMessageBloc extends Bloc<SendMsgEvent, SendMessageState> {
  
  var repo;
  SendMessageBloc({this.repo}) : super(SendMsgInitialState()) {

    on<GetCountryCodeEvent>(((event, emit) async {
      emit(SendMsgLoadingState());
      try{
        CountryCodeModel countryCodeModel = await repo.getCountryCode();
        if(countryCodeModel.statusCode == 200) {
          debugPrint('SIM Cntry cd 200');
          emit(CountryCdSuccessState(countryCodeModel.data!));
        } else {
          debugPrint('SIM Cntry cd failed');
          emit(CountryCdFailedState(countryCodeModel.error.toString()));
        }
      } catch(e) {
        debugPrint('SIM Cntry cd catch');
        emit(CountryCdFailedState(e.toString()));
      }
    }));
  }
}