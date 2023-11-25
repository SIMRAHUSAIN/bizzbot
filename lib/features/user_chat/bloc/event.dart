import 'dart:core';
import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetActiveChatEvent extends ChatEvent {

  GetActiveChatEvent();

  @override
  List<Object> get props => [];
}

class GetOldChatEvent extends ChatEvent {

  GetOldChatEvent();

  @override
  List<Object> get props => [];
}

class GetSortChatEvent extends ChatEvent {
  final String? chatType;
  GetSortChatEvent({this.chatType});

  @override
  List<Object> get props => [];
}

class GetUnreadChatEvent extends ChatEvent {
  final String? chatType;
  GetUnreadChatEvent({this.chatType});

  @override
  List<Object> get props => [];
}

class GetFilteredChatEvent extends ChatEvent {
  final String? chatType;
  final String? flagName;
  final String? flagId;
  GetFilteredChatEvent({this.chatType, this.flagName, this.flagId});

  @override
  List<Object> get props => [];
}