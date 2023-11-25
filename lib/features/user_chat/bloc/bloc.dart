import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/user_chat/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat/bloc/state.dart';
import 'package:mim_whatsup/features/user_chat/model/user_chat_model.dart';
import 'package:mim_whatsup/features/user_chat/repo/repo.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  
  ChatRepo repo;
  ChatBloc({required this.repo}) : super(ChatInitialState()) {

    on<GetActiveChatEvent>((event, emit) async {
      emit(ActiveChatLoadingState());
      try{
        UserChatModel userChatModel = await repo.getActiveChat();
        if(userChatModel.statusCode == "200") {
          emit(ActiveChatSuccessState(userChatModel));
        } else {
          emit(ActiveChatFailedState(userChatModel.data.toString()));
        }
      } catch(e) {
        emit(ActiveChatFailedState(e.toString()));
      }
    });

    on<GetOldChatEvent>((event, emit) async {
      emit(OldChatLoadingState());
      try{
        UserChatModel userChatModel = await repo.getOldChat();
        if(userChatModel.statusCode == "200") {
          emit(OldChatSuccessState(userChatModel));
        } else {
          emit(OldChatFailedState(userChatModel.data.toString()));
        }
      } catch(e) {
        emit(OldChatFailedState(e.toString()));
      }
    });

    on<GetSortChatEvent>((event, emit) async {
      emit(SortChatLoadingState());
      try{
        UserChatModel userChatModel = await repo.getSortChat(chatType: event.chatType??"");
        if(userChatModel.statusCode == "200") {
          emit(SortChatSuccessState(userChatModel));
        } else {
          emit(SortChatFailedState(userChatModel.data.toString()));
        }
      } catch(e) {
        emit(SortChatFailedState(e.toString()));
      }
    });

    on<GetUnreadChatEvent>((event, emit) async {
      emit(UnreadChatLoadingState());
      try{
        UserChatModel userChatModel = await repo.getUnreadChat(chatType: event.chatType??"");
        if(userChatModel.statusCode == "200") {
          emit(UnreadChatSuccessState(userChatModel));
        } else {
          emit(UnreadChatFailedState(userChatModel.data.toString()));
        }
      } catch(e) {
        emit(UnreadChatFailedState(e.toString()));
      }
    });

    on<GetFilteredChatEvent>((event, emit) async {
      emit(FilteredChatLoadingState());
      try{
        UserChatModel userChatModel = await repo.getFilteredChat(chatType: event.chatType??"", flagName: event.flagName??"", flagId: event.flagId??"");
        if(userChatModel.statusCode == "200") {
          emit(FilteredChatSuccessState(userChatModel));
        } else {
          emit(FilteredChatFailedState(userChatModel.data.toString()));
        }
      } catch(e) {
        emit(FilteredChatFailedState(e.toString()));
      }
    });
  }
}