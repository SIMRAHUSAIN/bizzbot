import 'package:equatable/equatable.dart';
import 'package:mim_whatsup/features/send_msg/model/countryCode_model.dart';

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
  final CountryCodeModelSuccess countryCodeModelSuccess;

  CountryCdSuccessState(this.countryCodeModelSuccess);

  @override
  List<Object> get props => [];
}

class CountryCdFailedState extends SendMessageState {
  final String? message;

  CountryCdFailedState(this.message);

  @override
  List<Object> get props => [];
}