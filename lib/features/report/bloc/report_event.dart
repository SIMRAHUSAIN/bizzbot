import 'dart:core';
import 'package:equatable/equatable.dart';

abstract class ReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetReportEvent extends ReportEvent {

  String toDate;
  String fromDate;

  GetReportEvent({required this.toDate, required this.fromDate});

  @override
  List<Object> get props => [];
}