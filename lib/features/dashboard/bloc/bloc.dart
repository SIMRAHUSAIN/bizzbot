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
        DashboardModel dashboardModel = await repo. getDashboard();
        if(dashboardModel.statusCode == 200) {
          emit(DashboardSuccessState(dashboardModel));
        } else {
          emit(DashboardFailedState(dashboardModel.data.toString()));
        }
      } catch(e) {
        emit(DashboardFailedState(e.toString()));
      }
    });
  }
}