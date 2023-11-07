import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/user_chat/bloc/bloc.dart';
import 'package:mim_whatsup/features/user_chat/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat/bloc/state.dart';
import 'package:mim_whatsup/features/user_chat/repo/repo.dart';
import 'package:mim_whatsup/features/user_chat/screen/user_chat_list.dart';

enum ChatType{
  ACTIVE,
  OLD,
  SORT,
  UNREAD
}

class UserChatDataLoader extends StatefulWidget {
  ChatType chatType;
  UserChatDataLoader({required this.chatType, Key? key}) : super(key: key);

  @override
  State<UserChatDataLoader> createState() => _UserChatDataLoaderState();
}

class _UserChatDataLoaderState extends State<UserChatDataLoader> {
  dynamic displayWidget;
  ChatEvent? chatEvent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state){},
        builder: (context, state) {
          if(state is ChatInitialState){
            displayWidget = Container();
          } else if(state is ActiveChatLoadingState || state is OldChatLoadingState || state is SortChatLoadingState || state is UnreadChatLoadingState){
            displayWidget =  const Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is ActiveChatSuccessState){
            displayWidget =  UserChatList(
              userChatModel: state.userChatModel
            );
          } else if(state is OldChatSuccessState){
            displayWidget =  UserChatList(
              userChatModel: state.userChatModel
            );
          } else if(state is SortChatSuccessState){
            displayWidget =  UserChatList(
              userChatModel: state.userChatModel
            );
          } else if(state is UnreadChatSuccessState){
            displayWidget =  UserChatList(
              userChatModel: state.userChatModel
            );
          } else if(state is ActiveChatFailedState || state is OldChatFailedState || state is SortChatFailedState || state is UnreadChatFailedState){
            displayWidget =  Container();
          }
          return displayWidget;
        },
      ),
    );
  }
}
