import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/colors.dart';
import '../../../utils/textstyle.dart';
import '../bloc/bloc.dart';
import '../bloc/event.dart';
import '../bloc/state.dart';
import '../unique_count/bloc/unique_bloc.dart';
import '../unique_count/bloc/unique_event.dart';
import '../unique_count/bloc/unique_state.dart';

class GroupList extends StatefulWidget {
  Function(String, String) callBack;
  GroupList({Key? key, required this.callBack}) : super(key: key);

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  static List<bool> isCheckedList = [];
  int groupListCount = 0;
  bool selectAll = false;
  List<String> groupId = [];
  String totalCount = "0", uniqueCount = "0";
  List<String> groupMobileNumber = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SendMessageBloc>(context).add(
        GetGroupEvent()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocConsumer<SendMessageBloc, SendMessageState>(
            listener: (context, state){
              debugPrint("LAMA 1 ${state.toString()} $isCheckedList");
              if(state is PostGroupSuccessState){
                groupMobileNumber = state.postGroupModel.data!.map((e) => e.mobile!.toString()).toList();
                Navigator.pop(context, totalCount);
              } else if(state is PostGroupFailedState){
                Navigator.pop(context);
              }
            },
            builder: (context, state){
              debugPrint("LAMA 2 ${state.toString()} $isCheckedList");
              if(state is GetGroupLoadingState){
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if(state is GetGroupSuccessState){
                isCheckedList = [];
                isCheckedList = List.generate(state.getGroupModel.data?.length??0, (index) => false);
                groupListCount = state.getGroupModel.data?.length??0;
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.47,
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
                                SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: Checkbox(
                                    onChanged: (newValue) {
                                      debugPrint("RAHUL $groupListCount $isCheckedList");
                                      if(newValue == true){
                                        isCheckedList = [];
                                        isCheckedList = List.generate(groupListCount, (index) => true);
                                        groupId = List.generate(groupListCount, (index) => state.getGroupModel.data?[index].id?.toInt()?.toString()??"0");
                                        selectAll = true;
                                        BlocProvider.of<UniqueBloc>(context).add(
                                            GetUniqueCountEvent(groupId: groupId.length==1?groupId[0]:groupId.join(","))
                                        );
                                      } else {
                                        isCheckedList = List.generate(groupListCount, (index) => false);
                                        selectAll = false;
                                        groupId = [];
                                        totalCount = "0";
                                        uniqueCount = "0";
                                      }
                                      debugPrint("LAMA $groupListCount $isCheckedList");
                                      stateChange(() {});
                                    },
                                    value: selectAll,
                                    activeColor: c137700,
                                  )
                                ),
                                const SizedBox(width: 10),
                                const Text("Select All"),
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
                                                if(newValue == true){
                                                  groupId.add(state.getGroupModel.data?[index].id?.toInt()?.toString()??"0");
                                                  BlocProvider.of<UniqueBloc>(context).add(
                                                      GetUniqueCountEvent(groupId: groupId.length==1?groupId[0]:groupId.join(","))
                                                  );
                                                } else {
                                                  groupId.removeLast();
                                                  BlocProvider.of<UniqueBloc>(context).add(
                                                      GetUniqueCountEvent(groupId: groupId.length==1?groupId[0]:groupId.join(","))
                                                  );
                                                }
                                              });
                                            },
                                            value: isCheckedList[index],
                                            activeColor: c137700,
                                          )
                                      ),
                                      const SizedBox(width: 10),
                                      Text(state.getGroupModel.data?[index].shortName??"")
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else if (state is GetGroupFailedState){
                return const Text("No Data Found");
              } else if(state is PostGroupLoadingState){
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.47,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if(state is PostGroupSuccessState){
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.47,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ));
              } else if (state is PostGroupFailedState){
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.47,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ));
              } else {
                return Container();
              }
            }
          ),
          BlocConsumer<UniqueBloc, UniqueState>(
            listener: (context, state){
              debugPrint("LAMA 3 ${state.toString()}");
              if(state is GetUniqueCountSuccessState){
                totalCount = state.getUniqueCountModel.data?.totalMobileCount??"0";
                uniqueCount = state.getUniqueCountModel.data?.totalUniqueMobilecount??"0";
                widget.callBack(totalCount, uniqueCount);
              }
            },
            builder: (context, state){
              return Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Total : $totalCount"),
                    Text("Unique : $uniqueCount")
                  ],
                ),
              );
            },
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: InkWell(
              onTap: () {
                BlocProvider.of<SendMessageBloc>(context).add(
                    PostGroupEvent(groupId: groupId)
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 15, top: 10, bottom: 15),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: c0D8578,
                  border: Border.all(
                    color: c0D8578,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Submit",
                  style: TextStyles.s14_w500_cFFFFFF,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _getLabelWidget(String label, int index, String id) {
    debugPrint("INSIDE $isCheckedList");
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
                  },
                  value: isCheckedList[index],
                  activeColor: c137700,
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Text(label)
        ],
      ),
    );
  }
}
