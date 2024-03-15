import 'dart:core';
import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class UniqueEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUniqueCountEvent extends UniqueEvent {
  String groupId;
  GetUniqueCountEvent({required this.groupId});
  @override
  List<Object> get props => [];
}