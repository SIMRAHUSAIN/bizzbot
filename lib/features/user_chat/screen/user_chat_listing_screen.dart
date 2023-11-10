// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/user_chat/bloc/bloc.dart';
import 'package:mim_whatsup/features/user_chat/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat/model/user_chat_model.dart';
import 'package:mim_whatsup/features/user_chat/screen/user_chat_data_loader.dart';
import 'package:mim_whatsup/utils/assets.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/global_variables.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/app_bar.dart';
import 'package:mim_whatsup/widgets/labellist_dialogbox.dart';
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
  UserChatModel? userChatModel;
  UserChatModel? userFilterChatModel, unfilteredChatModel, tempDataModel;

  @override
  void initState() {
    super.initState();
    _loadData(context, ChatType.ACTIVE);
    tabController = TabController(length: 2, vsync: this);
    // Timer.periodic(const Duration(seconds: 5), (timer) {
    //   GlobalVar.activeTab == 0?
    //   _loadData(context, GlobalVar.unreadBox?ChatType.UNREAD:ChatType.ACTIVE):null;
    // });
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
                        width: MediaQuery.of(context).size.width * 1,
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
                              UserChatDataLoader(chatType: ChatType.ACTIVE, callBackData: (UserChatModel userChatModel){
                                userFilterChatModel = userChatModel;
                                unfilteredChatModel ??= userChatModel;
                              }, modelData: userChatModel),
                              UserChatDataLoader(chatType: ChatType.OLD, callBackData: (UserChatModel userChatModel){
                                userFilterChatModel = userChatModel;
                                unfilteredChatModel ??= userChatModel;
                              }, modelData: userChatModel),
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

  void _filterChatList(String searchText) {
    setState(() {
      tempDataModel = userFilterChatModel!.data!.isEmpty?unfilteredChatModel:userFilterChatModel;
      if(searchText.isNotEmpty){
        userChatModel = UserChatModel(
          statusCode: tempDataModel!.statusCode,
          data: tempDataModel!.data!.where((data) =>
              data.contact!.toLowerCase().contains(searchText.toLowerCase())).toList(),
        );
      } else {
        userChatModel = unfilteredChatModel;
      }
    });
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
                _filterChatList(text);
              },
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return LabelListDialogBox();
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
              child: Image.asset(
                ImageAssets.sortIcon, 
                fit: BoxFit.fill, 
                height: 25, 
                width: 25,
              )
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
                    GlobalVar.unreadBox = newValue!;
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