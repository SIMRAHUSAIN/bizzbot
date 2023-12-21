import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/user_chat/bloc/bloc.dart';
import 'package:mim_whatsup/features/user_chat/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/bloc.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/state.dart';
import 'package:mim_whatsup/features/user_chat_filter/repo/repo.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/global_variables.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/chip_widget.dart';
import 'package:mim_whatsup/widgets/image_avatar.dart';
import 'package:mim_whatsup/features/user_chat_filter/screen/labelfilter_dialogbox.dart';

class ListingCard extends StatefulWidget {
  final String userName;
  final String date;
  final String mobNum;
  final String notificationNum;
  void Function()? onTap;
  final String label1Text;
  final String label1Color;
  final String label2Text;
  final String label2Color;
  final String label3Text;
  final String label3Color;
  final String label4Text;

  ListingCard({Key? key, 
    required this.userName, 
    required this.date, 
    required this.mobNum,
    required this.notificationNum,
    required this.onTap,
    required this.label1Text,
    required this.label1Color,
    required this.label2Text,
    required this.label2Color,
    required this.label3Text,
    required this.label3Color,
    required this.label4Text
  }) : super(key: key);

  @override
  State<ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<ListingCard> {

  bool enableExpandedOption = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        //margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: cFFFFFF,
          //borderRadius: BorderRadius.circular(10),
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.5), // You can change the color to your desired color
              width: 0.5,         // You can adjust the border width as needed
            ),
          ),
        ),
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconAvatar(
                          userNameString: widget.userName,
                        ),
                        InkWell(
                          onTap: (){
                            setState((){
                              enableExpandedOption = enableExpandedOption?false:true;
                            });
                          },
                          child: Icon(Icons.more_horiz),
                        )
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     label1Text == ""?Container():ChipWidget(
                        //       label1: label1Text??"",
                        //     ),
                        //     label1Text == ""?Container():const SizedBox(width: 5),
                        //     label2Text == ""?Container():ChipWidget(
                        //       label1: label2Text??"",
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                    const SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.userName.split(" ")[0]} ${widget.userName.split(" ")[1]}",
                          style: TextStyles.s14_w500_c9EA2AD,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '(${widget.mobNum})',
                          style: TextStyles.s14_w400_cB3AEAE,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.label1Text == ""?Container():ChipWidget(
                              labelText: widget.label1Text??"",
                              labelColor: Color(int.parse(widget.label1Color.replaceFirst('#', '0xFF'))),
                            ),
                            widget.label1Text == ""?Container():const SizedBox(width: 2),
                            widget.label2Text == ""?Container():ChipWidget(
                              labelText: widget.label2Text??"",
                              labelColor: Color(int.parse(widget.label2Color.replaceFirst('#', '0xFF'))),
                            ),
                            widget.label2Text == ""?Container():const SizedBox(width: 2),
                            widget.label3Text == ""?Container():ChipWidget(
                              labelText: widget.label3Text??"",
                              labelColor: Color(int.parse(widget.label3Color.replaceFirst('#', '0xFF'))),
                            ),
                            int.parse(widget.label4Text)>0?const SizedBox(width: 2):Container(),
                            int.parse(widget.label4Text)>0?ChipWidget(
                              labelText: "+${widget.label4Text}"??"",
                              labelColor: Colors.grey.withOpacity(0.8),
                            ):Container()
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.date.split(" ").first,
                      style: TextStyles.s14_w400_cB3AEAE,
                    ),
                    Text(
                      widget.date.split(" ").last,
                      style: TextStyles.s14_w400_cB3AEAE,
                    ),
                    widget.notificationNum == "0"?Container():Container(
                      width: 18,
                      height: 18,
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: c0FC333,
                        border: Border.all(width: 1.5, color: cFFFFFF),
                      ),
                      child: Center(
                        child: Text(
                          widget.notificationNum,
                          style: TextStyles.s11_w500_cFFFFFF,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            enableExpandedOption?SizedBox(height: 10):Container(),
            enableExpandedOption?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Center(
                    child: InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return LabelListDialogBox(mobileNo: widget.mobNum??"");
                          }).then((value){
                            if(value == true){
                              BlocProvider.of<ChatBloc>(context).add(GlobalVar.activeTab == 0?GetActiveChatEvent():GetOldChatEvent());
                            }
                        });
                      },
                      child: Icon(Icons.flag, size: 20, color: Colors.grey),
                    )
                  )
                ),
                BlocProvider<ChatFilterBloc>(
                  create: (BuildContext context) => ChatFilterBloc(
                      repo: ChatFilterRepoImpl()
                  ),
                  child: BlocConsumer<ChatFilterBloc, ChatFilterState>(
                    listener: (context, state){
                      if(state is UnreadMessageSuccessState){
                        BlocProvider.of<ChatBloc>(context).add(GlobalVar.activeTab == 0?GetActiveChatEvent():GetOldChatEvent());
                      }
                      // else if(state is UnreadMessageFailedState){
                      //   Navigator.pop(context);
                      // }
                    },
                    builder: (context, state){
                      return  Flexible(
                        child: Center(
                          child: InkWell(
                            onTap: (){
                              BlocProvider.of<ChatFilterBloc>(context).add(
                                UnreadMessageEvent(
                                  customerMobile: widget.mobNum,
                                )
                              );
                            },
                            child: Icon(Icons.mark_email_unread, size: 20, color: Colors.grey),
                          )
                        )
                      );
                    },
                  ),
                ),
              ],
            ):Container()
          ],
        ),
      ),
    );
  }
}