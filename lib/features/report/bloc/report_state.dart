import 'package:equatable/equatable.dart';
import 'package:mim_whatsup/features/report/model/report_model.dart';

abstract class ReportState extends Equatable {
  @override
  List<Object> get props => [];
}

class ReportInitialState extends ReportState {
  ReportInitialState();

  @override
  List<Object> get props => [];
}

class ReportLoadingState extends ReportState {
  ReportLoadingState();

  @override
  List<Object> get props => [];
}

class ReportSuccessState extends ReportState {
  final ReportModel reportModel;
  ReportSuccessState(this.reportModel);

  @override
  List<Object> get props => [reportModel];
}

class ReportFailedState extends ReportState {
  final String? message;
  ReportFailedState(this.message);

  @override
  List<Object> get props => [];
}