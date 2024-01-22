import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/individual_chat/bloc/bloc.dart';
import 'package:mim_whatsup/features/individual_chat/repo/repo.dart';
import 'package:mim_whatsup/features/user_chat/model/user_chat_model.dart';
import 'package:mim_whatsup/features/individual_chat/screen/individual_chatting_screen.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/widgets/listing_card.dart';

class UserChatList extends StatefulWidget {
  UserChatModel userChatModel;
  UserChatList({required this.userChatModel, Key? key}) : super(key: key);

  @override
  State<UserChatList> createState() => _UserChatListState();
}

class _UserChatListState extends State<UserChatList> {
  @override
  Widget build(BuildContext context) {
    print("YOY " + (widget.userChatModel.data?[0].contact??""));
    return Container(
      color: Colors.white,
      child: widget.userChatModel.data!.isEmpty?const Center(
        child: Text(
          Strings.noDataAvailable,
        ),
      ):ListView.builder(
        itemCount: widget.userChatModel.data?.length??0,
        itemBuilder: (context, index) {
          return ListingCard(
            userName: widget.userChatModel.data?[index].contact??"",
            date: widget.userChatModel.data?[index].insertdatetime??"",
            mobNum: widget.userChatModel.data?[index].fromMob??"",
            notificationNum: widget.userChatModel.data?[index].msgCount??"",
            label1Text: widget.userChatModel.data?[index].flag1nm??"",
            label1Color: widget.userChatModel.data?[index].flag1col??"",
            label2Text: widget.userChatModel.data?[index].flag2nm??"",
            label2Color: widget.userChatModel.data?[index].flag2col??"",
            label3Text: widget.userChatModel.data?[index].flag3nm??"",
            label3Color: widget.userChatModel.data?[index].flag3col??"",
            label4Text: widget.userChatModel.data?[index].flagplus??"0",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IndividualChattingScreen(
                    userName: widget.userChatModel.data?[index].contact??"",
                    userMobileNumber: widget.userChatModel.data?[index].fromMob??"",
                  )
                )
              );
            },
          );
        }
      ),
    );
  }
}
