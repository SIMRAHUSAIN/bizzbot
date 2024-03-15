import 'package:equatable/equatable.dart';
import 'package:mim_whatsup/features/send_msg/model/countryCode_model.dart';
import 'package:mim_whatsup/features/send_msg/model/send_schedule_model.dart';
import 'package:mim_whatsup/features/send_msg/model/templateId_model.dart';
import 'package:mim_whatsup/features/send_msg/model/csv_model.dart';
import 'package:mim_whatsup/features/send_msg/model/get_group_model.dart';
import 'package:mim_whatsup/features/send_msg/model/templateType_model.dart';

abstract class SendMessageState extends Equatable {
  @override
  List<Object> get props => []; 
}

class SendMsgInitialState extends SendMessageState {
  SendMsgInitialState();

  @override
  List<Object> get props => [];
}

class SendMsgLoadingState extends SendMessageState {
  SendMsgLoadingState();

  @override
  List<Object> get props => [];
}

class CountryCdSuccessState extends SendMessageState {
  final CountryCodeModel countryCodeModel;

  CountryCdSuccessState(this.countryCodeModel);

  @override
  List<Object> get props => [];
}

class CountryCdFailedState extends SendMessageState {
  final String? message;

  CountryCdFailedState(this.message);

  @override
  List<Object> get props => [];
}

class TemplateTypeSuccessState extends SendMessageState {
  final TemplateTypeModel templateTypeModel;

  TemplateTypeSuccessState(this.templateTypeModel);

  @override
  List<Object> get props => [];
}

class TemplateTypeFailedState extends SendMessageState {
  final String? message;

  TemplateTypeFailedState(this.message);

  @override
  List<Object> get props => [];
}

class TemplateIdSuccessState extends SendMessageState {
  final TemplateIdModel templateIdModel;

  TemplateIdSuccessState(this.templateIdModel);

  @override
  List<Object> get props => [];
}

class TemplateIdFailedState extends SendMessageState {
  final String? message;

  TemplateIdFailedState(this.message);
  @override
  List<Object> get props => [];
}

class GetGroupLoadingState extends SendMessageState {
  GetGroupLoadingState();

  @override
  List<Object> get props => [];
}

class GetGroupSuccessState extends SendMessageState {
  final GetGroupModel getGroupModel;

  GetGroupSuccessState(this.getGroupModel);

  @override
  List<Object> get props => [];
}

class GetGroupFailedState extends SendMessageState {
  final String? message;

  GetGroupFailedState(this.message);

  @override
  List<Object> get props => [];
}
  
class UploadCsvLoadingState extends SendMessageState {
  UploadCsvLoadingState();

  @override
  List<Object> get props => [];
}

class UploadCsvSuccessState extends SendMessageState {
  final CsvModel csvModel;

  UploadCsvSuccessState(this.csvModel);

  @override
  List<Object> get props => [];
}

class UploadCsvFailedState extends SendMessageState {
  final String? message;

  UploadCsvFailedState(this.message);

  @override
  List<Object> get props => [];
}

class SendOrScheduleSuccessState extends SendMessageState {
  final SendScheduleModel sendScheduleModel;

  SendOrScheduleSuccessState(this.sendScheduleModel);

  @override
  List<Object> get props => [];
}

class SendOrScheduleFailedState extends SendMessageState {
  final String? message;

  SendOrScheduleFailedState(this.message);
  
  @override
  List<Object> get props => [];
}