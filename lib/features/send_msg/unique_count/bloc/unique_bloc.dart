import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/send_msg/unique_count/bloc/unique_event.dart';
import 'package:mim_whatsup/features/send_msg/unique_count/bloc/unique_state.dart';

import '../model/get_unique_count_model.dart';
import '../repo/unique_repo.dart';

class UniqueBloc extends Bloc<UniqueEvent, UniqueState> {

  UniqueRepo repo;
  UniqueBloc({required this.repo}) : super(GetUniqueInitialState()) {
    on<GetUniqueCountEvent>(((event, emit) async {
      emit(GetUniqueCountLoadingState());
      try{
        GetUniqueCountModel getUniqueCountModel = await repo.getUniqueCount(id: event.groupId);
        if(getUniqueCountModel.statusCode == 200) {
          debugPrint('Temp 001');
          emit(GetUniqueCountSuccessState(getUniqueCountModel));
        } else {
          debugPrint('Temp 002');
          emit(GetUniqueCountFailedState(getUniqueCountModel.error.toString()));
        }
      } catch(e) {
        debugPrint('Temp 003');
        emit(GetUniqueCountFailedState(e.toString()));
      }
    }));
  }
}