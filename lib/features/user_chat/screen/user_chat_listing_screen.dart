// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/user_chat/bloc/bloc.dart';
import 'package:mim_whatsup/features/user_chat/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat/model/user_chat_model.dart';
import 'package:mim_whatsup/features/user_chat/screen/individual_chatting_screen.dart';
import 'package:mim_whatsup/features/user_chat/screen/user_chat_data_loader.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/static_var.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/app_bar.dart';
import 'package:mim_whatsup/widgets/labellist_dialogbox.dart';
import 'package:mim_whatsup/widgets/listing_card.dart';
import 'package:mim_whatsup/widgets/search_bar.dart';

class UserChatMainScreen extends StatefulWidget {
  const UserChatMainScreen({Key? key}) : super(key: key);

  @override
  State<UserChatMainScreen> createState() => _UserChatMainScreenState();
}

class _UserChatMainScreenState extends State<UserChatMainScreen> with SingleTickerProviderStateMixin {

  TextEditingController _searchController = TextEditingController();
  bool isChecked = false;
  TabController? tabController;
  List<UserChatModel> chatList = [];

  @override
  void initState() {
    super.initState();
    _loadData(context, ChatType.ACTIVE);
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarWithBackButton(
          title: Strings.userChatAppBar,
          onLeadingPressed: () {},
          onSuffixPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: cFFFFFF,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              _searchRow(),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                          controller: tabController,
                          indicatorColor: c137700,
                          labelColor: c137700,
                          labelStyle: TextStyles.s16_w500_c137700,
                          tabs: const <Widget>[
                            Tab(text: Strings.actveChtTabTxt),
                            Tab(text: Strings.oldChtTabTxt),
                          ],
                          onTap: (index) {
                            if(index == 0){
                              GlobalVar.activeTab = 0;
                              if(isChecked == true){
                                _loadData(context, ChatType.UNREAD);
                              } else {
                                _loadData(context, ChatType.ACTIVE);
                              }
                            } else {
                              GlobalVar.activeTab = 1;
                              if(isChecked == true){
                                _loadData(context, ChatType.UNREAD);
                              } else {
                                _loadData(context, ChatType.OLD);
                              }
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 60),
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              UserChatDataLoader(chatType: ChatType.ACTIVE),
                              UserChatDataLoader(chatType: ChatType.OLD),
                              // _getChatList(),
                              // _getChatList()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _searchRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SearchBar(
              onPressed: () {},
              searchEnabled: true,
              searchController: _searchController,
              barWidth: MediaQuery.of(context).size.width * 0.5,
              onChanged: (text) {
                // _filterChatList(text);
              },
            ),
            InkWell(
              onTap: () {
                // Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isDismissible: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Align(
                      alignment: Alignment.center,
                      child: LabelListDialogBox()
                    );
                });
              },
              child: const Icon(
                Icons.filter_alt_sharp,
                color: c137700,
                size: 30,
              ),
            ),
            InkWell(
              onTap: (){
                setState(() {
                  isChecked = false;
                });
                _loadData(context, ChatType.SORT);
              },
              child: const Icon(
                Icons.arrow_downward_outlined,
                color: c137700,
                size: 20,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: Checkbox(
                onChanged: (newValue) {
                  setState(() {
                    isChecked = newValue!;
                  });
                  if(isChecked == true){
                    _loadData(context, ChatType.UNREAD);
                  } else if(GlobalVar.activeTab == 0){
                    _loadData(context, ChatType.ACTIVE);
                  } else if(GlobalVar.activeTab == 1){
                    _loadData(context, ChatType.OLD);
                  }
                },
                value: isChecked,
                activeColor: c137700,
              ),
            ),
            Text(
              Strings.unread,
              style: TextStyles.s14_w400_cB3AEAE,
            ),
          ],
        ),
      ],
    );
  }

  void _loadData(BuildContext context, ChatType chatType) {
    ChatEvent chatEvent;
    if (chatType == ChatType.ACTIVE) {
      chatEvent = GetActiveChatEvent();
    } else if (chatType == ChatType.OLD) {
      chatEvent = GetOldChatEvent();
    } else if (chatType == ChatType.SORT) {
      chatEvent = GetSortChatEvent(chatType: GlobalVar.activeTab == 0?"0":"1");
    } else if (chatType == ChatType.UNREAD) {
      chatEvent = GetUnreadChatEvent(chatType: GlobalVar.activeTab == 0?"0":"1");
    } else {
      chatEvent = GetActiveChatEvent();
    }

    BlocProvider.of<ChatBloc>(context).add(chatEvent);
  }
}