import 'package:equatable/equatable.dart';
import 'package:mim_whatsup/features/user_chat/model/user_chat_model.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatInitialState extends ChatState {
  ChatInitialState();

  @override
  List<Object> get props => [];
}

class ActiveChatLoadingState extends ChatState {
  ActiveChatLoadingState();

  @override
  List<Object> get props => [];
}

class ActiveChatSuccessState extends ChatState {
  final UserChatModel userChatModel;
  ActiveChatSuccessState(this.userChatModel);

  @override
  List<Object> get props => [userChatModel];
}

class ActiveChatFailedState extends ChatState {
  final String? message;
  ActiveChatFailedState(this.message);

  @override
  List<Object> get props => [];
}

class OldChatLoadingState extends ChatState {
  OldChatLoadingState();

  @override
  List<Object> get props => [];
}

class OldChatSuccessState extends ChatState {
  final UserChatModel userChatModel;
  OldChatSuccessState(this.userChatModel);

  @override
  List<Object> get props => [userChatModel];
}

class OldChatFailedState extends ChatState {
  final String? message;
  OldChatFailedState(this.message);

  @override
  List<Object> get props => [];
}

class SortChatLoadingState extends ChatState {
  SortChatLoadingState();

  @override
  List<Object> get props => [];
}

class SortChatSuccessState extends ChatState {
  final UserChatModel userChatModel;
  SortChatSuccessState(this.userChatModel);

  @override
  List<Object> get props => [userChatModel];
}

class SortChatFailedState extends ChatState {
  final String? message;
  SortChatFailedState(this.message);

  @override
  List<Object> get props => [];
}

class UnreadChatLoadingState extends ChatState {
  UnreadChatLoadingState();

  @override
  List<Object> get props => [];
}

class UnreadChatSuccessState extends ChatState {
  final UserChatModel userChatModel;
  UnreadChatSuccessState(this.userChatModel);

  @override
  List<Object> get props => [userChatModel];
}

class UnreadChatFailedState extends ChatState {
  final String? message;
  UnreadChatFailedState(this.message);

  @override
  List<Object> get props => [];
}

class FilteredChatLoadingState extends ChatState {
  FilteredChatLoadingState();

  @override
  List<Object> get props => [];
}

class FilteredChatSuccessState extends ChatState {
  final UserChatModel userChatModel;
  FilteredChatSuccessState(this.userChatModel);

  @override
  List<Object> get props => [userChatModel];
}

class FilteredChatFailedState extends ChatState {
  final String? message;
  FilteredChatFailedState(this.message);

  @override
  List<Object> get props => [];
}