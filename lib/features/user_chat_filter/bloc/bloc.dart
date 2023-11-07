import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/login/bloc/event.dart';
import 'package:mim_whatsup/features/login/bloc/state.dart';
import 'package:mim_whatsup/features/login/model/login_model.dart';
import 'package:mim_whatsup/features/login/model/token_model.dart';
import 'package:mim_whatsup/features/user_chat/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat/bloc/state.dart';
import 'package:mim_whatsup/features/user_chat/model/user_chat_model.dart';
import 'package:mim_whatsup/features/user_chat/repo/repo.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/state.dart';
import 'package:mim_whatsup/features/user_chat_filter/repo/repo.dart';
import 'package:mim_whatsup/utils/jsonPostData.dart';
import 'package:mim_whatsup/utils/static_var.dart';

class ChatFilterBloc extends Bloc<ChatFilterEvent, ChatFilterState> {
  
  ChatFilterRepo repo;
  ChatFilterBloc({required this.repo}) : super(ChatFilterInitialState()) {

    on<GetChatLabelEvent>((event, emit) async {
      emit(FetchChatLabelLoadingState());
      try{
        UserChatModel userChatModel = await repo.getChatLabel(mobileNo: event.mobileNo);
        if(userChatModel.statusCode == "200") {
          print("POP");
          emit(FetchChatLabelSuccessState(userChatModel));
        } else {
          print("KOK");
          emit(FetchChatLabelFailedState(userChatModel.data.toString()));
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
  }
}