import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/assets.dart';
import '../../../utils/colors.dart';
import '../../../utils/textstyle.dart';

class MessageScheduler extends StatefulWidget {
  String index;
  Function dateCallBack;
  Function timeCallBack;
  String currentIndex;
  Function currentIndexCallBack;
  MessageScheduler({super.key, required this.index, required this.dateCallBack, required this.timeCallBack, required this.currentIndex, required this.currentIndexCallBack});

  @override
  State<MessageScheduler> createState() => _MessageSchedulerState();
}

class _MessageSchedulerState extends State<MessageScheduler> {

  final TextEditingController date1Controller = TextEditingController();
  final TextEditingController time1Controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    date1Controller.dispose();
    time1Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cFFFFFF,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Schedule Date ${widget.index}',
                style: TextStyles.s14_w600_c000000,
              ),
              GestureDetector(
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    lastDate: DateTime(2100),
                    firstDate: DateTime(1900),
                    initialDate: DateTime.now(),
                  );
                  if(date != null) {
                    String formattedDate = DateFormat('dd-mm-yyyy').format(date);
                    setState(() {
                      date1Controller.text = formattedDate;
                    });
                    widget.dateCallBack(date1Controller.text);
                  }
                },
                child: Container(
                  height: 40,
                  width: 130,
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: cFFFFFF,
                    border: Border.all(
                      color: c000000,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 40,
                        child: TextField(
                          controller: date1Controller,
                          enabled: false,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: c000000,
                          ),
                          decoration: const InputDecoration(
                              hintText: "dd-mm-yyyy",
                              hintStyle: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.zero
                          ),
                        ),
                      ),
                      Image.asset(
                        ImageAssets.calenderPng,
                        fit: BoxFit.cover,
                        height: 18,
                        width: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Time (HH:MM)',
                style: TextStyles.s14_w600_c000000,
              ),
              GestureDetector(
                onTap: () async {
                  final TimeOfDay? timePicker = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now()
                  );
                  if(timePicker != null) {
                    setState(() {
                      time1Controller.text = "${timePicker.hour}:${timePicker.minute}";
                    });
                    widget.dateCallBack(time1Controller.text);
                  }
                },
                child: Container(
                  height: 40,
                  width: 120,
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: cFFFFFF,
                    border: Border.all(
                      color: c000000,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: time1Controller,
                    enabled: false,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: c000000,
                    ),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero
                    ),
                  ),
                ),
              ),
            ],
          ),
          int.parse(widget.index) == int.parse(widget.currentIndex)?GestureDetector(
            onTap: () {
              widget.currentIndexCallBack(int.parse(widget.currentIndex)+1);
              // on click, new row of scheduler ui will pop up
              // _schedulerWidget(1)
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Image.asset(
                ImageAssets.plusSignPng,
                fit: BoxFit.cover,
                height: 30,
                width: 30,
              ),
            ),
          ):Container(
            height: 30,
            width: 30,
          ),
        ],
      ),
    );
  }
}
