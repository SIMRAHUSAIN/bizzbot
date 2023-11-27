// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/user_chat/model/user_chat_model.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/state.dart';
import 'package:mim_whatsup/features/user_chat_filter/model/chat_label_list_model.dart';
import 'package:mim_whatsup/features/user_chat_filter/repo/repo.dart';

class ChatFilterBloc extends Bloc<ChatFilterEvent, ChatFilterState> {
  
  ChatFilterRepo repo;
  ChatFilterBloc({required this.repo}) : super(ChatFilterInitialState()) {

    on<GetChatLabelEvent>((event, emit) async {
      emit(FetchChatLabelLoadingState());
      try{
        ChatLabelListModel chatLabelListModel = await repo.getChatLabel(mobileNo: event.mobileNo);
        if(chatLabelListModel.statusCode == "200") {
          print("POP");
          emit(FetchChatLabelSuccessState(chatLabelListModel));
        } else {
          print("KOK");
          emit(FetchChatLabelFailedState(chatLabelListModel.data.toString()));
        }
      } catch(e) {
        print("LOL");
        emit(FetchChatLabelFailedState(e.toString()));
      }
    });

    on<AddChatLabelEvent>((event, emit) async {
      emit(AddChatLabelLoadingState());
      try{
        Map jsonPostData = {
          "LabelName": event.labelName,
          "ColorCode": event.colorCode
        };
        UserChatModel userChatModel = await repo.addChatLabel(jsonPostData: jsonPostData);
        if(userChatModel.statusCode == "200") {
          print("POP1");
          emit(AddChatLabelSuccessState(userChatModel));
        } else {
          print("KOK1");
          emit(AddChatLabelFailedState(userChatModel.data.toString()));
        }
      } catch(e) {
        print("LOL1");
        emit(AddChatLabelFailedState(e.toString()));
      }
    });

    on<EditChatLabelEvent>((event, emit) async {
      emit(EditChatLabelLoadingState());
      try{
        Map jsonPostData = {
          "LabelName": event.labelName,
          "ColorCode": event.colorCode,
          "FlagId": event.flagId
        };
        UserChatModel userChatModel = await repo.editChatLabel(jsonPostData: jsonPostData);
        if(userChatModel.statusCode == "200") {
          print("POP2");
          emit(EditChatLabelSuccessState(userChatModel));
        } else {
          print("KOK2");
          emit(EditChatLabelFailedState(userChatModel.data.toString()));
        }
      } catch(e) {
        print("LOL2");
        emit(EditChatLabelFailedState(e.toString()));
      }
    });

    on<DeleteChatLabelEvent>((event, emit) async {
      emit(DeleteChatLabelLoadingState());
      try{
        Map jsonPostData = {
          "FlagId": event.flagId,
        };
        UserChatModel userChatModel = await repo.deleteChatLabel(jsonPostData: jsonPostData);
        if(userChatModel.statusCode == "200") {
          print("POP3");
          emit(DeleteChatLabelSuccessState(userChatModel));
        } else {
          print("KOK3");
          emit(DeleteChatLabelFailedState(userChatModel.data.toString()));
        }
      } catch(e) {
        print("LOL3");
        emit(DeleteChatLabelFailedState(e.toString()));
      }
    });

    on<SaveFlagEvent>((event, emit) async {
      emit(SaveFlagLoadingState());
      try{
        Map jsonPostData = {
          "CustomerMob": event.customerMobile,
          "FlagId": event.flagId,
        };
        Map saveFlagModel = await repo.saveFlag(jsonPostData: jsonPostData);
        if(saveFlagModel["statusCode"] == "200") {
          print("POP3");
          emit(SaveFlagSuccessState());
        } else {
          print("KOK3");
          emit(SaveFlagFailedState("Error"));
        }
      } catch(e) {
        print("LOL3");
        emit(SaveFlagFailedState(e.toString()));
      }
    });

    on<UnreadMessageEvent>((event, emit) async {
      emit(UnreadMessageLoadingState());
      try{
        Map jsonPostData = {
          "CustomerMob": event.customerMobile,
        };
        Map unreadMessageModel = await repo.unreadMessage(jsonPostData: jsonPostData);
        if(unreadMessageModel["statusCode"] == "200") {
          print("POP3");
          emit(UnreadMessageSuccessState());
        } else {
          print("KOK3");
          emit(UnreadMessageFailedState("Error"));
        }
      } catch(e) {
        print("LOL3");
        emit(UnreadMessageFailedState(e.toString()));
      }
    });
  }
}