// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/user_chat/bloc/bloc.dart';
import 'package:mim_whatsup/features/user_chat/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat_filter/screen/addnewlabel_dialogbox.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/bloc.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/state.dart';
import 'package:mim_whatsup/features/user_chat_filter/repo/repo.dart';
import 'package:mim_whatsup/utils/assets.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/global_variables.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/features/user_chat_filter/screen/addnewlabel_dialogbox.dart';

class LabelListDialogBox extends StatefulWidget {

  final String mobileNo;
  final bool? filter;

  const LabelListDialogBox({required this.mobileNo, this.filter = false});

  @override
  State<LabelListDialogBox> createState() => _LabelListDialogBoxState();
}

class _LabelListDialogBoxState extends State<LabelListDialogBox> {

  bool isChecked = false;
  dynamic displayWidget;
  List<bool> isCheckedList = [];
  List<String> checkBoxId = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            Container(
              color: c0D8578,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.labelTtl,
                    style: TextStyles.s14_w500_cFFFFFF,
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              color: cFFFFFF,
              padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
              child: BlocProvider<ChatFilterBloc>(
                create: (BuildContext context) => ChatFilterBloc(repo: ChatFilterRepoImpl()),
                child: BlocConsumer<ChatFilterBloc, ChatFilterState>(
                  listener: (context, state){},
                  builder: (context, state) {
                    if(state is ChatFilterInitialState){
                      BlocProvider.of<ChatFilterBloc>(context).add(GetChatLabelEvent(mobileNo: widget.mobileNo));
                      displayWidget = const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: CircularProgressIndicator()
                          )
                        ),
                      );
                    } else if(state is FetchChatLabelLoadingState){
                      displayWidget = const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: CircularProgressIndicator()
                          )
                        ),
                      );
                    } else if(state is FetchChatLabelSuccessState){
                      isCheckedList = [];
                      checkBoxId = [];
                      displayWidget = const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: CircularProgressIndicator()
                          )
                        ),
                      );
                      isCheckedList = List.generate(state.chatLabelListModel.data?.length??0, (index) => false);
                      displayWidget = ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.chatLabelListModel.data?.length??0,
                        itemBuilder: (BuildContext context, int index){
                          if(state.chatLabelListModel.data?[index].chkbox == "1"){
                            isCheckedList[index] = true;
                            checkBoxId.add(state.chatLabelListModel.data?[index].flagID??"");
                          }
                          //isCheckedList[index] = state.chatLabelListModel.data?[index].chkbox == "1"?true:false;
                          return _getLabelWidget(
                            state.chatLabelListModel.data?[index].flagName??"",
                            index,
                            state.chatLabelListModel.data?[index].flagID??"",
                            state.chatLabelListModel.data?[index].flagColorCode??"",
                            state.chatLabelListModel.data?[index].chkbox??"0"
                          );
                        },
                      );
                    } else if(state is FetchChatLabelFailedState){
                      displayWidget = Container();
                    }
                    return displayWidget;
                  }
                ),
              ),
            ),
            widget.filter == true?InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 8),
                decoration: BoxDecoration(
                  color: cCC2525,
                  border: Border.all(
                    color: cCC2525,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  Strings.cancelBtn,
                  style: TextStyles.s14_w500_cFFFFFF,
                ),
              ),
            ):Align(
              alignment: Alignment.bottomCenter,
              child: _getButtons(),
            ),
          ],
        ),
      ),
    );
  }

  _getButtons() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return Align(
                    alignment: Alignment.center,
                    child: AddNewLabelDialogBox(
                      operationType: OperationType.ADD,
                    )
                  );
              });
            },
            child: Text(
              Strings.addNewLabel,
              style: TextStyles.s16_w500_c544FFF,
            ),
          ),
          BlocProvider<ChatFilterBloc>(
            create: (BuildContext context) => ChatFilterBloc(
                repo: ChatFilterRepoImpl()
            ),
            child: BlocConsumer<ChatFilterBloc, ChatFilterState>(
              listener: (context, state){
                if(state is SaveFlagSuccessState){
                  Navigator.pop(context, true);
                } else if(state is SaveFlagFailedState){
                  Navigator.pop(context);
                }
              },
              builder: (context, state){
                return  InkWell(
                  onTap: () {
                    BlocProvider.of<ChatFilterBloc>(context).add(
                      SaveFlagEvent(
                        customerMobile: widget.mobileNo,
                        flagId: checkBoxId
                      )
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 8),
                    decoration: BoxDecoration(
                      color: cCC2525,
                      border: Border.all(
                        color: cCC2525,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      Strings.saveBtn,
                      style: TextStyles.s14_w500_cFFFFFF,
                    ),
                  ),
                );
              },
            ),
          ),
          BlocProvider<ChatFilterBloc>(
            create: (BuildContext context) => ChatFilterBloc(
              repo: ChatFilterRepoImpl()
            ),
            child: BlocConsumer<ChatFilterBloc, ChatFilterState>(
              listener: (context, state){
                if(state is DeleteChatLabelSuccessState){
                  Navigator.pop(context);
                } else if(state is DeleteChatLabelFailedState){
                  Navigator.pop(context);
                }
              },
              builder: (context, state){
                return  InkWell(
                  onTap: () {
                    BlocProvider.of<ChatFilterBloc>(context).add(
                      DeleteChatLabelEvent(
                        flagId: checkBoxId
                      )
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 8),
                    decoration: BoxDecoration(
                      color: c544FFF,
                      border: Border.all(
                        color: c544FFF,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      Strings.deleteBtn,
                      style: TextStyles.s14_w500_cFFFFFF,
                    ),
                  ),
                );
              },
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 6, vertical: 8),
              decoration: BoxDecoration(
                color: cCC2525,
                border: Border.all(
                  color: cCC2525,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                Strings.cancelBtn,
                style: TextStyles.s14_w500_cFFFFFF,
              ),
            ),
          ), 
        ],
      ),
    );
  }

  _getLabelWidget(String label, int index, String id, String colorCode, String checkBoxEnabled) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: widget.filter == true?(){
              BlocProvider.of<ChatBloc>(context).add(GetFilteredChatEvent(
                chatType: GlobalVar.activeTab == 0?"0":"1",
                flagName: label,
                flagId: id
              ));
              Navigator.pop(context, true);
            }:null,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    ImageAssets.labelPng,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Text(
                    label,
                    style: TextStyles.s14_w500_c000000,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          widget.filter == true?Container():Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
                width: 25,
                child: StatefulBuilder(
                  builder: (context, stateChange){
                    return Checkbox(
                      onChanged: (newValue) {
                        // print(newValue.toString() + index.toString() + label);
                        stateChange(() {
                          isCheckedList[index] = newValue ?? true;
                        });
                        newValue!?checkBoxId.add(id):checkBoxId.removeLast();
                      },
                      value: isCheckedList[index],
                      activeColor: c137700,
                    );
                  },
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Align(
                        alignment: Alignment.center,
                        child: AddNewLabelDialogBox(
                          operationType: OperationType.EDIT,
                          id: id,
                          colorCode: colorCode,
                          labelName: label
                        )
                      );
                    }
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 22,
                  height: 22,
                  child: Image.asset(
                    ImageAssets.labelCheckboxPng,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}