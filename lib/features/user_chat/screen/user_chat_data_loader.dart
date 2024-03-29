import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/user_chat/bloc/bloc.dart';
import 'package:mim_whatsup/features/user_chat/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat/bloc/state.dart';
import 'package:mim_whatsup/features/user_chat/model/user_chat_model.dart';
import 'package:mim_whatsup/features/user_chat/screen/user_chat_list.dart';

enum ChatType{
  ACTIVE,
  OLD,
  SORT,
  UNREAD
}

class UserChatDataLoader extends StatefulWidget {
  ChatType chatType;
  Function callBackData;
  UserChatModel? modelData;
  UserChatDataLoader({required this.chatType, required this.callBackData, this.modelData, Key? key}) : super(key: key);

  @override
  State<UserChatDataLoader> createState() => _UserChatDataLoaderState();
}

class _UserChatDataLoaderState extends State<UserChatDataLoader> {
  dynamic displayWidget;
  ChatEvent? chatEvent;
  UserChatModel? data;
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state){
          // if(state is ChatInitialState){
          //   displayWidget = Container();
          // }
          // else if(state is ActiveChatLoadingState || state is OldChatLoadingState || state is SortChatLoadingState || state is UnreadChatLoadingState || state is FilteredChatLoadingState){
          //   displayWidget =  const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          //else
          if(state is ActiveChatSuccessState){
            if(widget.modelData != null){
              data = widget.modelData;
            } else {
              data = state.userChatModel;
            }
            widget.callBackData(state.userChatModel);
            // displayWidget =  UserChatList(
            //     userChatModel: data
            // );
          }
          else if(state is OldChatSuccessState){
            if(widget.modelData != null){
              data = widget.modelData;
            } else {
              data = state.userChatModel;
            }
            // widget.callBackData(state.userChatModel);
            // displayWidget =  UserChatList(
            //     userChatModel: data
            // );
          }
          else if(state is SortChatSuccessState){
            if(widget.modelData != null){
              data = widget.modelData;
            } else {
              data = state.userChatModel;
            }
            // widget.callBackData(state.userChatModel);
            // displayWidget =  UserChatList(
            //     userChatModel: data
            // );
          }
          else if(state is UnreadChatSuccessState){
            if(widget.modelData != null){
              data = widget.modelData;
            } else {
              data = state.userChatModel;
            }
            // widget.callBackData(state.userChatModel);
            // displayWidget =  UserChatList(
            //     userChatModel: data
            // );
          }
          else if(state is FilteredChatSuccessState){
            if(widget.modelData != null){
              data = widget.modelData;
            } else {
              data = state.userChatModel;
            }
            // widget.callBackData(state.userChatModel);
            // displayWidget =  UserChatList(
            //     userChatModel: data
            // );
          }
          // else if(state is ActiveChatFailedState || state is OldChatFailedState || state is SortChatFailedState || state is UnreadChatFailedState || state is FilteredChatFailedState){
          //   displayWidget =  Container(
          //     child: Center(
          //       child: Text("No Data"),
          //     ),
          //   );
          // }
        },
        builder: (context, state) {
          if(counter == 0){
            counter++;
            return const Center(
              child: CircularProgressIndicator()
            );
          }
          else if (data == null){
            return const Center(
              child: Text("No Data Found"),
            );
          }
          else {
            return UserChatList(
                userChatModel: data!
            );
          }
          // dynamic data;
          // if(state is ChatInitialState){
          //   displayWidget = Container();
          // } else if(state is ActiveChatLoadingState || state is OldChatLoadingState || state is SortChatLoadingState || state is UnreadChatLoadingState || state is FilteredChatLoadingState){
          //   displayWidget =  const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // } else if(state is ActiveChatSuccessState){
          //   if(widget.modelData != null){
          //     data = widget.modelData;
          //   } else {
          //     data = state.userChatModel;
          //   }
          //   widget.callBackData(state.userChatModel);
          //   displayWidget =  UserChatList(
          //     userChatModel: data
          //   );
          // } else if(state is OldChatSuccessState){
          //   if(widget.modelData != null){
          //     data = widget.modelData;
          //   } else {
          //     data = state.userChatModel;
          //   }
          //   widget.callBackData(state.userChatModel);
          //   displayWidget =  UserChatList(
          //     userChatModel: data
          //   );
          // } else if(state is SortChatSuccessState){
          //   if(widget.modelData != null){
          //     data = widget.modelData;
          //   } else {
          //     data = state.userChatModel;
          //   }
          //   widget.callBackData(state.userChatModel);
          //   displayWidget =  UserChatList(
          //     userChatModel: data
          //   );
          // } else if(state is UnreadChatSuccessState){
          //   if(widget.modelData != null){
          //     data = widget.modelData;
          //   } else {
          //     data = state.userChatModel;
          //   }
          //   widget.callBackData(state.userChatModel);
          //   displayWidget =  UserChatList(
          //     userChatModel: data
          //   );
          // } else if(state is FilteredChatSuccessState){
          //   if(widget.modelData != null){
          //     data = widget.modelData;
          //   } else {
          //     data = state.userChatModel;
          //   }
          //   widget.callBackData(state.userChatModel);
          //   displayWidget =  UserChatList(
          //     userChatModel: data
          //   );
          // } else if(state is ActiveChatFailedState || state is OldChatFailedState || state is SortChatFailedState || state is UnreadChatFailedState || state is FilteredChatFailedState){
          //   displayWidget =  Container(
          //     child: Center(
          //       child: Text("No Data"),
          //     ),
          //   );
          // }
          // return displayWidget;
        },
      ),
    );
  }
}
