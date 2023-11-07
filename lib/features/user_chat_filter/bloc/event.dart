import 'dart:core';
import 'package:equatable/equatable.dart';

abstract class ChatFilterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetChatLabelEvent extends ChatFilterEvent {
  final String mobileNo;
  GetChatLabelEvent({required this.mobileNo});

  @override
  List<Object> get props => [];
}

class AddChatLabelEvent extends ChatFilterEvent {
  final String? labelName, colorCode;

  AddChatLabelEvent({this.labelName, this.colorCode});

  @override
  List<Object> get props => [];
}

class EditChatLabelEvent extends ChatFilterEvent {
  final String? labelName, colorCode, flagId;

  EditChatLabelEvent({this.labelName, this.colorCode, this.flagId});

  @override
  List<Object> get props => [];
}

class DeleteChatLabelEvent extends ChatFilterEvent {
  final String? flagId;

  DeleteChatLabelEvent({this.flagId});

  @override
  List<Object> get props => [];
}