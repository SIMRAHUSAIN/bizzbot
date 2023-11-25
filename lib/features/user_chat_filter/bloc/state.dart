import 'package:equatable/equatable.dart';
import 'package:mim_whatsup/features/user_chat/model/user_chat_model.dart';
import 'package:mim_whatsup/features/user_chat_filter/model/chat_label_list_model.dart';

abstract class ChatFilterState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatFilterInitialState extends ChatFilterState {
  ChatFilterInitialState();

  @override
  List<Object> get props => [];
}

class FetchChatLabelLoadingState extends ChatFilterState {
  FetchChatLabelLoadingState();

  @override
  List<Object> get props => [];
}

class FetchChatLabelSuccessState extends ChatFilterState {
  final ChatLabelListModel chatLabelListModel;
  FetchChatLabelSuccessState(this.chatLabelListModel);

  @override
  List<Object> get props => [chatLabelListModel];
}

class FetchChatLabelFailedState extends ChatFilterState {
  final String? message;
  FetchChatLabelFailedState(this.message);

  @override
  List<Object> get props => [];
}

class AddChatLabelLoadingState extends ChatFilterState {
  AddChatLabelLoadingState();

  @override
  List<Object> get props => [];
}

class AddChatLabelSuccessState extends ChatFilterState {
  final UserChatModel userChatModel;
  AddChatLabelSuccessState(this.userChatModel);

  @override
  List<Object> get props => [userChatModel];
}

class AddChatLabelFailedState extends ChatFilterState {
  final String? message;
  AddChatLabelFailedState(this.message);

  @override
  List<Object> get props => [];
}

class EditChatLabelLoadingState extends ChatFilterState {
  EditChatLabelLoadingState();

  @override
  List<Object> get props => [];
}

class EditChatLabelSuccessState extends ChatFilterState {
  final UserChatModel userChatModel;
  EditChatLabelSuccessState(this.userChatModel);

  @override
  List<Object> get props => [userChatModel];
}

class EditChatLabelFailedState extends ChatFilterState {
  final String? message;
  EditChatLabelFailedState(this.message);

  @override
  List<Object> get props => [];
}

class DeleteChatLabelLoadingState extends ChatFilterState {
  DeleteChatLabelLoadingState();

  @override
  List<Object> get props => [];
}

class DeleteChatLabelSuccessState extends ChatFilterState {
  final UserChatModel userChatModel;
  DeleteChatLabelSuccessState(this.userChatModel);

  @override
  List<Object> get props => [userChatModel];
}

class DeleteChatLabelFailedState extends ChatFilterState {
  final String? message;
  DeleteChatLabelFailedState(this.message);

  @override
  List<Object> get props => [];
}

class SaveFlagLoadingState extends ChatFilterState {
  SaveFlagLoadingState();

  @override
  List<Object> get props => [];
}

class SaveFlagSuccessState extends ChatFilterState {
  // final UserChatModel userChatModel;
  // SaveFlagSuccessState(this.userChatModel);

  @override
  List<Object> get props => [];
}

class SaveFlagFailedState extends ChatFilterState {
  final String? message;
  SaveFlagFailedState(this.message);

  @override
  List<Object> get props => [];
}

class UnreadMessageLoadingState extends ChatFilterState {
  UnreadMessageLoadingState();

  @override
  List<Object> get props => [];
}

class UnreadMessageSuccessState extends ChatFilterState {
  // final UserChatModel userChatModel;
  // UnreadMessageSuccessState(this.userChatModel);

  @override
  List<Object> get props => [];
}

class UnreadMessageFailedState extends ChatFilterState {
  final String? message;
  UnreadMessageFailedState(this.message);

  @override
  List<Object> get props => [];
}
