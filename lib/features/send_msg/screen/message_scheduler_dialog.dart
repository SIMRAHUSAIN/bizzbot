import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/strings.dart';
import '../../../utils/textstyle.dart';
import 'message_scheduler.dart';

class ScheduleDialog extends StatefulWidget {
  @override
  _ScheduleDialogState createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<ScheduleDialog> {
  int schedulerIndex = 1;
  final TextEditingController date1Controller = TextEditingController();
  final TextEditingController time1Controller = TextEditingController();
  final TextEditingController date2Controller = TextEditingController();
  final TextEditingController time2Controller = TextEditingController();
  final TextEditingController date3Controller = TextEditingController();
  final TextEditingController time3Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.475,
        child: Column(
          children: [
            Container(
              color: c0D8578,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Schedule Message',
                    style: TextStyles.s14_w500_cFFFFFF,
                  ),
                ],
              ),
            ),
            MessageScheduler(
                index: "1",
                dateCallBack: (String data){
                  date1Controller.text = data;
                },
                timeCallBack: (String data){
                  time2Controller.text = data;
                },
                currentIndex: "$schedulerIndex",
                currentIndexCallBack: (int data){
                  print("INTEL $data");
                  schedulerIndex = data;
                  setState(() {});
                }
            ),
            2<=schedulerIndex?MessageScheduler(
                index: "2",
                dateCallBack: (String data){
                  date2Controller.text = data;
                },
                timeCallBack: (String data){
                  time2Controller.text = data;
                },
                currentIndex: "$schedulerIndex",
                currentIndexCallBack: (int data){
                  print("INTEL2 $data");
                  schedulerIndex = data;
                  setState(() {});
                }
            ):Container(),
            3<=schedulerIndex?MessageScheduler(
                index: "3",
                dateCallBack: (String data){
                  date3Controller.text = data;
                },
                timeCallBack: (String data){
                  time3Controller.text = data;
                },
                currentIndex: "$schedulerIndex",
                currentIndexCallBack: (int data){
                  print("INTEL3 $data");
                  schedulerIndex = data;
                  setState(() {});
                }
            ):Container(),
            SizedBox(height: 10),
            // Container(
            //   color: cFFFFFF,
            //   height: MediaQuery.of(context).size.height * 0.25,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(
            //             'Schedule Date 1',
            //             style: TextStyles.s14_w600_c000000,
            //           ),
            //           GestureDetector(
            //             onTap: () async {
            //                 DateTime? date = await showDatePicker(
            //                   context: context,
            //                   lastDate: DateTime(2100),
            //                   firstDate: DateTime(1900),
            //                   initialDate: DateTime.now(),
            //                 );
            //                 if(date != null) {
            //                   String formattedDate = DateFormat('dd-mm-yyyy').format(date);
            //                   setState(() {
            //                     date1Controller.text = formattedDate;
            //                   });
            //                 }
            //               },
            //             child: Container(
            //               height: 40,
            //               width: 130,
            //               margin: const EdgeInsets.only(top: 5),
            //               decoration: BoxDecoration(
            //                 color: cFFFFFF,
            //                 border: Border.all(
            //                   color: c000000,
            //                   width: 1,
            //                 ),
            //                 borderRadius: BorderRadius.circular(8),
            //               ),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   SizedBox(
            //                     width: 60,
            //                     height: 40,
            //                     child: TextField(
            //                       controller: date1Controller,
            //                       enabled: false,
            //                       style: const TextStyle(
            //                         fontSize: 11,
            //                         fontWeight: FontWeight.w700,
            //                         color: c000000,
            //                       ),
            //                       decoration: const InputDecoration(
            //                           hintText: "dd-mm-yyyy",
            //                           hintStyle: TextStyle(
            //                             fontSize: 10,
            //                             fontWeight: FontWeight.w700,
            //                             color: Colors.grey,
            //                           ),
            //                         contentPadding: EdgeInsets.zero
            //                       ),
            //                     ),
            //                   ),
            //                   Image.asset(
            //                     ImageAssets.calenderPng,
            //                     fit: BoxFit.cover,
            //                     height: 18,
            //                     width: 18,
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(
            //             'Time (HH:MM)',
            //             style: TextStyles.s14_w600_c000000,
            //           ),
            //           GestureDetector(
            //             onTap: () async {
            //               final TimeOfDay? timePicker = await showTimePicker(
            //                 context: context,
            //                 initialTime: TimeOfDay.now()
            //               );
            //               if(timePicker != null) {
            //                 setState(() {
            //                   time1Controller.text = "${timePicker.hour}:${timePicker.minute}";
            //                 });
            //               }
            //             },
            //             child: Container(
            //               height: 40,
            //               width: 120,
            //               margin: const EdgeInsets.only(top: 5),
            //               decoration: BoxDecoration(
            //                 color: cFFFFFF,
            //                 border: Border.all(
            //                   color: c000000,
            //                   width: 1,
            //                 ),
            //                 borderRadius: BorderRadius.circular(8),
            //               ),
            //               child: TextField(
            //                 controller: time1Controller,
            //                   enabled: false,
            //                   style: const TextStyle(
            //                     fontSize: 12,
            //                     fontWeight: FontWeight.w700,
            //                     color: c000000,
            //                   ),
            //                   textAlign: TextAlign.center,
            //                   decoration: const InputDecoration(
            //                   contentPadding: EdgeInsets.zero
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       GestureDetector(
            //         onTap: () {
            //           // on click, new row of scheduler ui will pop up
            //           // _schedulerWidget(1)
            //         },
            //         child: Image.asset(
            //           ImageAssets.plusSignPng,
            //           fit: BoxFit.cover,
            //            height: 30,
            //            width: 30,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 8),
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
                          'Schedule Message',
                          style: TextStyles.s14_w500_cFFFFFF,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          date1Controller.clear();
                          time1Controller.clear();
                          date2Controller.clear();
                          time2Controller.clear();
                          date3Controller.clear();
                          time3Controller.clear();
                          schedulerIndex = 1;
                        });
                        Navigator.pop(context);
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
                          Strings.cancelBtn,
                          style: TextStyles.s14_w500_cFFFFFF,
                        ),
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 20),
            // Your dialog content here
            // Make sure to use setState() to update the UI
          ],
        ),
      ),
    );
  }
}
