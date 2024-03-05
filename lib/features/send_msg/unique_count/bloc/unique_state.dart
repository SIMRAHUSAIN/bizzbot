import 'package:equatable/equatable.dart';
import 'package:mim_whatsup/features/send_msg/model/countryCode_model.dart';
import 'package:mim_whatsup/features/send_msg/model/templateId_model.dart';
import 'package:mim_whatsup/features/send_msg/model/csv_model.dart';
import 'package:mim_whatsup/features/send_msg/model/get_group_model.dart';
import 'package:mim_whatsup/features/send_msg/model/templateType_model.dart';

import '../model/get_unique_count_model.dart';


abstract class UniqueState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUniqueInitialState extends UniqueState {
  GetUniqueInitialState();

  @override
  List<Object> get props => [];
}

class GetUniqueCountLoadingState extends UniqueState {
  GetUniqueCountLoadingState();

  @override
  List<Object> get props => [];
}

class GetUniqueCountSuccessState extends UniqueState {
  final GetUniqueCountModel getUniqueCountModel;

  GetUniqueCountSuccessState(this.getUniqueCountModel);

  @override
  List<Object> get props => [];
}

class GetUniqueCountFailedState extends UniqueState {
  final String? message;

  GetUniqueCountFailedState(this.message);

  @override
  List<Object> get props => [];
}

