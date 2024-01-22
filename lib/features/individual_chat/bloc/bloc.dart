import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/individual_chat/bloc/event.dart';
import 'package:mim_whatsup/features/individual_chat/bloc/state.dart';
import 'package:mim_whatsup/features/individual_chat/model/individual_chat_model.dart';
import 'package:mim_whatsup/features/individual_chat/model/send_file_model.dart';
import 'package:mim_whatsup/features/individual_chat/model/send_message_model.dart';
import 'package:mim_whatsup/features/individual_chat/repo/repo.dart';

class IndividualChatBloc extends Bloc<IndividualChatEvent, IndividualChatState> {
  
  IndividualChatRepo repo;
  IndividualChatBloc({required this.repo}) : super(IndividualChatInitialState()) {

    on<GetIndividualChatEvent>((event, emit) async {
      emit(IndividualChatLoadingState());
      try{
        Map data = {
          'CustomerMob': event.customerMobile,
          'CheckOld': event.checkOld
        };
        IndividualChatModel individualChatModel = await repo.getIndividualChat(jsonPostData: data);
        if(individualChatModel.statusCode == "200") {
          emit(IndividualChatSuccessState(individualChatModel));
        } else {
          emit(IndividualChatFailedState(individualChatModel.error.toString()));
        }
      } catch(e) {
        emit(IndividualChatFailedState(e.toString()));
      }
    });

    on<SendMessageEvent>((event, emit) async {
      emit(SendMessageLoadingState());
      try{
        Map data = {
          'CustomerMob': event.customerMobile,
          'TemplateName': event.templateName,
          'Type': event.type,
          'Text': event.text,
          'FileName': event.fileName
        };
        SendMessageModel sendMessageModel = await repo.sendMessage(jsonPostData: data);
        if(sendMessageModel.statusCode == "200") {
          emit(SendMessageSuccessState(sendMessageModel));
        } else {
          emit(SendMessageFailedState(sendMessageModel.data.toString()));
        }
      } catch(e) {
        emit(SendMessageFailedState(e.toString()));
      }
    });

    on<SendFileEvent>((event, emit) async {
      emit(SendFileLoadingState());
      try{
        SendFileModel sendFileModel = await repo.sendFile(file: event.fileType!);
        if(sendFileModel.statusCode == "200") {
          emit(SendFileSuccessState(sendFileModel));
        } else {
          emit(SendFileFailedState(sendFileModel.data.toString()));
        }
      } catch(e) {
        emit(SendFileFailedState(e.toString()));
      }
    });

  }
}