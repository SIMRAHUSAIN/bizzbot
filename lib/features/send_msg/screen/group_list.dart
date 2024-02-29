import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/utils/assets.dart';

import '../../../utils/colors.dart';
import '../../../utils/textstyle.dart';
import '../bloc/bloc.dart';
import '../bloc/event.dart';
import '../bloc/state.dart';

class GroupList extends StatefulWidget {
  const GroupList({Key? key}) : super(key: key);

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  static List<bool> isCheckedList = [];
  int groupListCount = 0;
  bool selectAll = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SendMessageBloc>(context).add(
        GetGroupEvent()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocConsumer<SendMessageBloc, SendMessageState>(
        listener: (context, state){},
        builder: (context, state){
          if(state is GetGroupLoadingState){
            return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          else if(state is GetGroupSuccessState){
            isCheckedList = [];
            isCheckedList = List.generate(state.getGroupModel.data?.length??0, (index) => false);
            groupListCount = state.getGroupModel.data?.length??0;
            return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: StatefulBuilder(
                builder: (context, stateChange){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        color: c0D8578,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Group",
                              style: TextStyles.s14_w500_cFFFFFF,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              child: Checkbox(
                                onChanged: (newValue) {
                                  print("RAHUL $groupListCount $isCheckedList");
                                  if(newValue == true){
                                    isCheckedList = [];
                                    isCheckedList = List.generate(groupListCount, (index) => true);
                                    selectAll = true;
                                  } else {
                                    isCheckedList = List.generate(groupListCount, (index) => false);
                                    selectAll = false;
                                  }
                                  print("LAMA $groupListCount $isCheckedList");
                                  stateChange(() {});
                                  // setState(() {});
                                  // print(newValue.toString() + index.toString() + label);
                                  // stateChange(() {
                                  //   isCheckedList[index] = newValue ?? true;
                                  // });
                                  // newValue!?checkBoxId.add(id):checkBoxId.removeLast();
                                },
                                value: selectAll,
                                activeColor: c137700,
                              )
                            ),
                            SizedBox(width: 10),
                            Text("Select All"),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        color: cFFFFFF,
                        padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.getGroupModel.data?.length??0,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: Checkbox(
                                        onChanged: (newValue) {
                                          stateChange(() {
                                            isCheckedList[index] = newValue ?? true;
                                          });
                                          // newValue!?checkBoxId.add(id):checkBoxId.removeLast();
                                        },
                                        value: isCheckedList[index],
                                        activeColor: c137700,
                                      )
                                  ),
                                  SizedBox(width: 10),
                                  Text(state.getGroupModel.data?[index].shortName??"")
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          } else if (state is GetGroupFailedState){
            return Text("No Data Found");
          } else {
            return Container();
          }
        }
      ),
    );
  }
  _getLabelWidget(String label, int index, String id) {
    print("INSIDE $isCheckedList");
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 25,
            width: 25,
            child: StatefulBuilder(
              builder: (context, stateChange){
                return Checkbox(
                  onChanged: (newValue) {
                    stateChange(() {
                      isCheckedList[index] = newValue ?? true;
                    });
                    // newValue!?checkBoxId.add(id):checkBoxId.removeLast();
                  },
                  value: isCheckedList[index],
                  activeColor: c137700,
                );
              },
            ),
          ),
          SizedBox(width: 10),
          Text(label)
        ],
      ),
    );
  }
}
