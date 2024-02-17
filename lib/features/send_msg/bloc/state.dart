import 'package:equatable/equatable.dart';
import 'package:mim_whatsup/features/send_msg/model/countryCode_model.dart';
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