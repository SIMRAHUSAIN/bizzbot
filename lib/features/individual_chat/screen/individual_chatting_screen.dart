// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/individual_chat/bloc/bloc.dart';
import 'package:mim_whatsup/features/individual_chat/bloc/event.dart';
import 'package:mim_whatsup/features/individual_chat/bloc/state.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/global_variables.dart';
import 'package:mim_whatsup/utils/textstyle.dart';
import 'package:mim_whatsup/widgets/message_widget.dart';
import 'package:file_picker/file_picker.dart';

class IndividualChattingScreen extends StatefulWidget {
  
  final String userName;
  final String userMobileNumber;
  const IndividualChattingScreen({Key? key, required this.userName, required this.userMobileNumber}) : super(key: key);

  @override
  State<IndividualChattingScreen> createState() => _IndividualChattingScreenState();
}

class _IndividualChattingScreenState extends State<IndividualChattingScreen> {

  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  dynamic displayWidget;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    focusNode.requestFocus();
    return Scaffold(
      appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: cFFFFFF,
                      child: Text(
                        widget.userName.substring(0,1),
                        style: TextStyles.s14_w800_c577D91,
                      ),
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName,
                        style: TextStyles.s18_w700_cFFFFFF,
                      ),
                      Text(
                        "last seen today at 12:05",
                        style: TextStyles.s14_w500_cFFFFFF,
                      )
                    ],
                  ),
                ),
              ),
              backgroundColor: c577D91,
              actions: [
                IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                PopupMenuButton<String>(
                  padding: const EdgeInsets.all(0),
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: "Search",
                        child: Text("Search"),
                      ),
                      const PopupMenuItem(
                        value: "Mute Notification",
                        child: Text("Mute Notification"),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
      body: Container(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<IndividualChatBloc, IndividualChatState>(
                listener: (context, state){
                  print("RAHUL " + state.toString());
                  if(state is SendFileSuccessState){
                    BlocProvider.of<IndividualChatBloc>(context).add(
                      SendMessageEvent(
                        customerMobile: widget.userMobileNumber,
                        templateName: "",
                        text: "",
                        type: "Image",
                        fileName: state.sendFileModel.data?.file??""
                      )
                    );
                  } else if(state is SendMessageSuccessState){
                    _controller.text = "";
                    BlocProvider.of<IndividualChatBloc>(context).add(GetIndividualChatEvent(customerMobile: widget.userMobileNumber, checkOld: '1'));
                  }
                },
                builder: (context, state){
                  if(state is IndividualChatInitialState){
                    BlocProvider.of<IndividualChatBloc>(context).add(GetIndividualChatEvent(customerMobile: widget.userMobileNumber, checkOld: '1'));
                    displayWidget = const Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: CircularProgressIndicator()
                        )
                      ),
                    );
                  }
                  else if(state is IndividualChatLoadingState){
                    displayWidget = const Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                            child: CircularProgressIndicator()
                        )
                      ),
                    );
                  } else if(state is IndividualChatSuccessState){
                    displayWidget = ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: state.individualChatModel.data?.conversation?.length??0,
                      itemBuilder: (context, index) {
                        // if (index == messages.length) {
                        //   return Container(
                        //     height: 70,
                        //   );
                        // }
                        // if (messages[index].type == "source") {
                        //   return OwnMessageCard(
                        //     message: messages[index].message,
                        //     time: messages[index].time,
                        //   );
                        // } else {
                        //   return ReplyCard(
                        //     message: messages[index].message,
                        //     time: messages[index].time,
                        //   );
                        // }
                        return ChatMessageWidget(
                            text: state.individualChatModel?.data?.conversation?[index].msgtext??"",
                            time: state.individualChatModel?.data?.conversation?[index].inserttime??"",
                            sendFrom: state.individualChatModel?.data?.conversation?[index].sentfrom??"",
                        );
                      },
                    );
                    // Scroll to the last item after the ListView.builder has been built
                    WidgetsBinding.instance?.addPostFrameCallback((_) {
                      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                    });
                  } else if(state is IndividualChatFailedState){
                    displayWidget = Container();
                  }
                  return displayWidget;
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Card(
                            margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextFormField(
                              controller: _controller,
                              focusNode: focusNode,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    sendButton = true;
                                  });
                                } else {
                                  setState(() {
                                    sendButton = false;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type a message",
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon: IconButton(
                                  icon: Icon(
                                    //show ?
                                    Icons.keyboard
                                        //: Icons.emoji_emotions_outlined,
                                  ),
                                  onPressed: () {
                                    // if (!show) {
                                    //   focusNode.unfocus();
                                    //   focusNode.canRequestFocus = false;
                                    // }
                                    // setState(() {
                                    //   show = !show;
                                    // });
                                  },
                                ),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        //Future<void> pickFile() async {
                                          FilePickerResult? result = await FilePicker.platform.pickFiles();
                                          if (result != null) {
                                            String filePath = result.files.single.path!;
                                            print('Selected file path: $filePath');
                                            BlocProvider.of<IndividualChatBloc>(context).add(
                                              SendFileEvent(fileType: File(filePath))
                                            );
                                            // Use the file path as needed
                                          } else {
                                            // User canceled the file picking
                                          }
                                        //}
                                      },
                                      icon: const Icon(Icons.attach_file),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.camera_alt),
                                    )
                                  ],
                                ),
                                contentPadding: const EdgeInsets.all(5),
                              )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8, right: 2, left: 2),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: const Color(0xFF128C7E),
                            child: IconButton(
                              icon: Icon(
                                sendButton ? Icons.send : Icons.mic,
                                color: cFFFFFF,
                              ),
                              onPressed: () {
                                if(sendButton){
                                  BlocProvider.of<IndividualChatBloc>(context).add(
                                    SendMessageEvent(
                                      customerMobile: widget.userMobileNumber,
                                      templateName: "",
                                      type: "Text",
                                      text: _controller.text,
                                      fileName: ""
                                    )
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}