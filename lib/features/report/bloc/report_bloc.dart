import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/report/bloc/report_event.dart';
import 'package:mim_whatsup/features/report/bloc/report_state.dart';
import 'package:mim_whatsup/features/report/model/report_model.dart';
import 'package:mim_whatsup/features/report/repository/report_repository.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {

  ReportRepo repo;
  ReportBloc({required this.repo}) : super(ReportInitialState()) {

    on<GetReportEvent>((event, emit) async {
      emit(ReportLoadingState());
      try{
        ReportModel reportModel = await repo.getReport(fromDate: event.fromDate, toDate: event.toDate);
        if(reportModel.statusCode == 200) {
          emit(ReportSuccessState(reportModel));
        } else {
          emit(ReportFailedState(reportModel.error.toString()));
        }
      } catch(e) {
        emit(ReportFailedState(e.toString()));
      }
    });
  }
}