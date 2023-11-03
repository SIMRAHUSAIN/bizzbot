import 'package:equatable/equatable.dart';
import 'package:mim_whatsup/features/dashboard/model/dashboard_model.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object> get props => [];
}

class DashboardInitialState extends DashboardState {
  DashboardInitialState();

  @override
  List<Object> get props => [];
}

class DashboardLoadingState extends DashboardState {
  DashboardLoadingState();

  @override
  List<Object> get props => [];
}

class DashboardSuccessState extends DashboardState {
  final DashboardModel dashboardModel;
  DashboardSuccessState(this.dashboardModel);

  @override
  List<Object> get props => [];  
}

class DashboardFailedState extends DashboardState {
  final String message;
  DashboardFailedState(this.message);

  @override
  List<Object> get props => [];
}