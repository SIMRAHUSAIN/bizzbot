import 'package:equatable/equatable.dart';
import 'package:mim_whatsup/features/user_chat/model/user_chat_model.dart';

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
  final UserChatModel userChatModel;
  FetchChatLabelSuccessState(this.userChatModel);

  @override
  List<Object> get props => [userChatModel];
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
