// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/bloc.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/event.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/state.dart';
import 'package:mim_whatsup/features/user_chat_filter/repo/repo.dart';
import 'package:mim_whatsup/utils/assets.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/strings.dart';
import 'package:mim_whatsup/utils/textstyle.dart';

enum OperationType{
  ADD,
  EDIT
}

class AddNewLabelDialogBox extends StatefulWidget {
  OperationType operationType;
  String? id, colorCode, labelName;

  AddNewLabelDialogBox({required this.operationType, this.id, this.colorCode, this.labelName = ""});
  @override
  State<AddNewLabelDialogBox> createState() => _AddNewLabelDialogBoxState();
}

class _AddNewLabelDialogBoxState extends State<AddNewLabelDialogBox> {

  final TextEditingController _labelController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    _labelController.text = widget.labelName??"";
    return Dialog(
      child: SizedBox(
        height: 250,
        child: Column(
          children: [
            Container(
              color: c0D8578,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.operationType == OperationType.ADD?Strings.addNewLabel:Strings.editLabel,
                    style: TextStyles.s14_w500_cFFFFFF,
                  ),
                ],
              ),
            ),
            Container(
              color: cFFFFFF,
              padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 30,
                        height: 30,
                        child: Image.asset(
                          ImageAssets.labelPng,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          onSaved: (String? val) {
                            _labelController.text = val!;
                          },
                          autovalidateMode: AutovalidateMode.always,
                          controller: _labelController,
                          enabled: true,
                          maxLength: 10,
                          style: TextStyles.s14_w600_c000000,
                          decoration: InputDecoration(
                            hintText: widget.operationType == OperationType.ADD?Strings.addNewLabel:Strings.editLabel,
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: cA4A0A0
                            ),
                            filled: true,
                            fillColor: cFFFFFF,
                            counterText: '',
                            contentPadding: EdgeInsets.only(top: 10, left: 10),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(width: 1, color: cA4A0A0)
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(width: 1, color: cA4A0A0)
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(width: 1, color: cA4A0A0)
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(width: 1, color: cA4A0A0)
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                      )
                    ],
                  ),
                  BlocProvider<ChatFilterBloc>(
                    create: (BuildContext context) => ChatFilterBloc(
                      repo: ChatFilterRepoImpl()
                    ),
                    child: BlocConsumer<ChatFilterBloc, ChatFilterState>(
                      listener: (context, state){
                        if(state is AddChatLabelSuccessState){
                          Navigator.pop(context);
                        } else if(state is AddChatLabelFailedState){
                          Navigator.pop(context);
                        } else if(state is EditChatLabelFailedState){
                          Navigator.pop(context);
                        } else if(state is EditChatLabelFailedState){
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                _labelController.text.isNotEmpty?BlocProvider.of<ChatFilterBloc>(context).add(
                                    widget.operationType == OperationType.ADD?AddChatLabelEvent(
                                        labelName: _labelController.text,
                                        colorCode: "FFFFFF"
                                    ):EditChatLabelEvent(
                                      labelName: _labelController.text,
                                      flagId: widget.id??"",
                                      colorCode: widget.colorCode??""
                                    )
                                ):null;
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10, top: 90),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                  color: c544FFF,
                                  border: Border.all(
                                    color: c544FFF,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  Strings.saveBtn,
                                  style: TextStyles.s14_w500_cFFFFFF,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 90),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}