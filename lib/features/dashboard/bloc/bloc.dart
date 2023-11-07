// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/dashboard/bloc/event.dart';
import 'package:mim_whatsup/features/dashboard/bloc/state.dart';
import 'package:mim_whatsup/features/dashboard/model/dashboard_model.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  
  var repo;
  DashboardBloc({this.repo}) : super(DashboardInitialState()) {

    on<DashboardEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try{
        debugPrint('Dash 0');
        DashboardModel dashboardModel = await repo.getDashboard();
        if(dashboardModel.statusCode == 200) {
          debugPrint('Dash 1');
          emit(DashboardSuccessState(dashboardModel));
        } else {
          debugPrint('Dash 2');
          emit(DashboardFailedState(dashboardModel.data.toString()));
        }
      } catch(e) {
        debugPrint('Dash 4');
        emit(DashboardFailedState(e.toString()));
      }
    });
  }
}