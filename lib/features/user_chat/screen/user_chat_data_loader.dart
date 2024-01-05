import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/login/bloc/bloc.dart';
import 'package:mim_whatsup/features/login/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat/bloc/bloc.dart';
import 'package:mim_whatsup/features/user_chat/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat/bloc/state.dart';
import 'package:mim_whatsup/features/user_chat/model/user_chat_model.dart';
import 'package:mim_whatsup/features/user_chat/screen/user_chat_list.dart';
import 'package:mim_whatsup/utils/global_variables.dart';

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
    print("Hello " + (widget.modelData?.data?[0].flag3nm??""));
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state){
          print("JOJo " + state.toString());
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
          } else if(state is ActiveChatFailedState){
            if(state.message!.contains("Token Expire")){
              GlobalVar.recentEvent = [];
              GlobalVar.recentEvent.add(state);
              BlocProvider.of<LoginBloc>(context).add(
                  GetAuthTokenEvent(
                      userName: 'MIM2200038',
                      passWord: 'FE1F\$FD9_738'
                    // userName: _userNameController.text,
                    // passWord: _passwordController.text,
                  )
              );
            }
          }
          else if(state is OldChatSuccessState){
            if(widget.modelData != null){
              data = widget.modelData;
            } else {
              data = state.userChatModel;
            }
            widget.callBackData(state.userChatModel);
            // displayWidget =  UserChatList(
            //     userChatModel: data
            // );
          } else if(state is OldChatFailedState){
            print("AOAO" + state.message.toString());
            if(state.message!.contains("Token Expire")){
              GlobalVar.recentEvent = [];
              GlobalVar.recentEvent.add(state);
              BlocProvider.of<LoginBloc>(context).add(
                  GetAuthTokenEvent(
                      userName: 'MIM2200038',
                      passWord: 'FE1F\$FD9_738'
                    // userName: _userNameController.text,
                    // passWord: _passwordController.text,
                  )
              );
            }
          }
          else if(state is SortChatSuccessState){
            if(widget.modelData != null){
              data = widget.modelData;
            } else {
              data = state.userChatModel;
            }
            GlobalVar.recentEvent.add(state);
            widget.callBackData(state.userChatModel);
            // displayWidget =  UserChatList(
            //     userChatModel: data
            // );
          } else if(state is SortChatFailedState){
            if(state.message!.contains("Token Expire")){
              GlobalVar.recentEvent = [];
              GlobalVar.recentEvent.add(state);
              BlocProvider.of<LoginBloc>(context).add(
                  GetAuthTokenEvent(
                      userName: 'MIM2200038',
                      passWord: 'FE1F\$FD9_738'
                    // userName: _userNameController.text,
                    // passWord: _passwordController.text,
                  )
              );
            }
          }
          else if(state is UnreadChatSuccessState){
            if(widget.modelData != null){
              data = widget.modelData;
            } else {
              data = state.userChatModel;
            }
            widget.callBackData(state.userChatModel);
            // displayWidget =  UserChatList(
            //     userChatModel: data
            // );
          } else if(state is UnreadChatFailedState){
            if(state.message!.contains("Token Expire")){
              GlobalVar.recentEvent = [];
              GlobalVar.recentEvent.add(state);
              BlocProvider.of<LoginBloc>(context).add(
                  GetAuthTokenEvent(
                      userName: 'MIM2200038',
                      passWord: 'FE1F\$FD9_738'
                    // userName: _userNameController.text,
                    // passWord: _passwordController.text,
                  )
              );
            }
          }
          else if(state is FilteredChatSuccessState){
            if(widget.modelData != null){
              data = widget.modelData;
            } else {
              data = state.userChatModel;
            }
            widget.callBackData(state.userChatModel);
            // displayWidget =  UserChatList(
            //     userChatModel: data
            // );
          } else if(state is FilteredChatFailedState){
            if(state.message!.contains("Token Expire")){
              GlobalVar.recentEvent = [];
              GlobalVar.recentEvent.add(state);
              BlocProvider.of<LoginBloc>(context).add(
                  GetAuthTokenEvent(
                      userName: 'MIM2200038',
                      passWord: 'FE1F\$FD9_738'
                    // userName: _userNameController.text,
                    // passWord: _passwordController.text,
                  )
              );
            }
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
          print("ULO " + state.toString());
          if(counter == 0){
            counter++;
            return Center(
              child: CircularProgressIndicator()
            );
          }
          else if (data == null){
            return Center(
              child: Text("No Data Found"),
            );
          }
          else if(state is ActiveChatSuccessState){
            if(widget.modelData != null){
              data = widget.modelData;
            } else {
              data = state.userChatModel;
            }
            widget.callBackData(state.userChatModel);
            return UserChatList(
                userChatModel: data!
            );
          }
          else if(state is OldChatSuccessState){
            if(widget.modelData != null){
              data = widget.modelData;
            } else {
              data = state.userChatModel;
            }
            widget.callBackData(state.userChatModel);
            return UserChatList(
              userChatModel: data!
            );
          }
          else if(state is SortChatSuccessState){
            if(widget.modelData != null){
              data = widget.modelData;
            } else {
              data = state.userChatModel;
            }
            GlobalVar.recentEvent.add(state);
            widget.callBackData(state.userChatModel);
            return UserChatList(
              userChatModel: data!
            );
          }
          else if(state is UnreadChatSuccessState){
            if(widget.modelData != null){
              data = widget.modelData;
            } else {
              data = state.userChatModel;
            }
            widget.callBackData(state.userChatModel);
            return UserChatList(
                userChatModel: data!
            );
          }
          else if(state is FilteredChatSuccessState){
            if(widget.modelData != null){
              data = widget.modelData;
            } else {
              data = state.userChatModel;
            }
            widget.callBackData(state.userChatModel);
            return UserChatList(
                userChatModel: data!
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
