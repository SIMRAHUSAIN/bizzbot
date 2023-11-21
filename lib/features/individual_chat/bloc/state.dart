import 'package:equatable/equatable.dart';
import 'package:mim_whatsup/features/individual_chat/model/individual_chat_model.dart';
import 'package:mim_whatsup/features/individual_chat/model/send_file_model.dart';
import 'package:mim_whatsup/features/individual_chat/model/send_message_model.dart';
import 'package:mim_whatsup/features/user_chat/model/user_chat_model.dart';

abstract class IndividualChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class IndividualChatInitialState extends IndividualChatState {
  IndividualChatInitialState();

  @override
  List<Object> get props => [];
}

class IndividualChatLoadingState extends IndividualChatState {
  IndividualChatLoadingState();

  @override
  List<Object> get props => [];
}

class IndividualChatSuccessState extends IndividualChatState {
  final IndividualChatModel individualChatModel;
  IndividualChatSuccessState(this.individualChatModel);

  @override
  List<Object> get props => [individualChatModel];
}

class IndividualChatFailedState extends IndividualChatState {
  final String? message;
  IndividualChatFailedState(this.message);

  @override
  List<Object> get props => [];
}

class SendMessageLoadingState extends IndividualChatState {
  SendMessageLoadingState();

  @override
  List<Object> get props => [];
}

class SendMessageSuccessState extends IndividualChatState {
  final SendMessageModel sendMessageModel;
  SendMessageSuccessState(this.sendMessageModel);

  @override
  List<Object> get props => [sendMessageModel];
}

class SendMessageFailedState extends IndividualChatState {
  final String? message;
  SendMessageFailedState(this.message);

  @override
  List<Object> get props => [];
}

class SendFileLoadingState extends IndividualChatState {
  SendFileLoadingState();

  @override
  List<Object> get props => [];
}

class SendFileSuccessState extends IndividualChatState {
  final SendFileModel sendFileModel;
  SendFileSuccessState(this.sendFileModel);

  @override
  List<Object> get props => [sendFileModel];
}

class SendFileFailedState extends IndividualChatState {
  final String? message;
  SendFileFailedState(this.message);

  @override
  List<Object> get props => [];
}