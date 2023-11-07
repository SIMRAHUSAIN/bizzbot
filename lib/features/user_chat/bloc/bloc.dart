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
          print("AAA");
          emit(ActiveChatSuccessState(userChatModel));
        } else {
          print("BBB");
          emit(ActiveChatFailedState(userChatModel.data.toString()));
        }
      } catch(e) {
        print("FFF");
        emit(ActiveChatFailedState(e.toString()));
      }
    });

    on<GetOldChatEvent>((event, emit) async {
      emit(OldChatLoadingState());
      try{
        UserChatModel userChatModel = await repo.getOldChat();
        if(userChatModel.statusCode == "200") {
          print("CCC");
          emit(OldChatSuccessState(userChatModel));
        } else {
          print("DDD");
          emit(OldChatFailedState(userChatModel.data.toString()));
        }
      } catch(e) {
        print("EEE");
        emit(OldChatFailedState(e.toString()));
      }
    });

    on<GetSortChatEvent>((event, emit) async {
      emit(SortChatLoadingState());
      try{
        UserChatModel userChatModel = await repo.getSortChat(chatType: event.chatType??"");
        if(userChatModel.statusCode == "200") {
          print("XXX");
          emit(SortChatSuccessState(userChatModel));
        } else {
          print("YYY");
          emit(SortChatFailedState(userChatModel.data.toString()));
        }
      } catch(e) {
        print("ZZZ");
        emit(SortChatFailedState(e.toString()));
      }
    });

    on<GetUnreadChatEvent>((event, emit) async {
      emit(UnreadChatLoadingState());
      try{
        UserChatModel userChatModel = await repo.getUnreadChat(chatType: event.chatType??"");
        if(userChatModel.statusCode == "200") {
          print("XXX1");
          emit(UnreadChatSuccessState(userChatModel));
        } else {
          print("YYY1");
          emit(UnreadChatFailedState(userChatModel.data.toString()));
        }
      } catch(e) {
        print("ZZZ1");
        emit(UnreadChatFailedState(e.toString()));
      }
    });
  }
}