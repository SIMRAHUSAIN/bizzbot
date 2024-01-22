import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/login/bloc/bloc.dart';
import 'package:mim_whatsup/features/login/bloc/event.dart';
import 'package:mim_whatsup/features/report/bloc/report_bloc.dart';
import 'package:mim_whatsup/features/report/bloc/report_event.dart';
import 'package:mim_whatsup/features/report/bloc/report_state.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/global_variables.dart';
import 'package:mim_whatsup/widgets/app_bar.dart';

class ReportMainScreen extends StatefulWidget {
  const ReportMainScreen({Key? key}) : super(key: key);

  @override
  State<ReportMainScreen> createState() => _ReportMainScreenState();
}

class _ReportMainScreenState extends State<ReportMainScreen> {

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  Widget customText(String title, double size){
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          size == 14?Container():Container(
            height: 1,
            color: Colors.grey.withOpacity(0.2),
          ),
          const SizedBox(height: 10),
          Text(title, style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.normal,
              color: Color(0xff374A5E)
          )),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedFromDate) {
      setState(() {
        selectedFromDate = picked;
        fromDateController.text = '${selectedFromDate.year}-${selectedFromDate.month.toString().padLeft(2, '0')}-${selectedFromDate.day.toString().padLeft(2, '0')}';
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedToDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedToDate) {
      setState(() {
        selectedToDate = picked;
        toDateController.text = '${selectedToDate.year}-${selectedToDate.month.toString().padLeft(2, '0')}-${selectedToDate.day.toString().padLeft(2, '0')}';
      });
    }
  }

  late DateTime selectedFromDate, selectedToDate;

  @override
  void initState() {
    super.initState();
    // Initialize with today's date
    selectedFromDate = DateTime.now();
    selectedToDate = DateTime.now();
    fromDateController.text = '${selectedFromDate.year}-${selectedFromDate.month.toString().padLeft(2, '0')}-${selectedFromDate.day.toString().padLeft(2, '0')}';
    toDateController.text = '${selectedToDate.year}-${selectedToDate.month.toString().padLeft(2, '0')}-${selectedToDate.day.toString().padLeft(2, '0')}';
    BlocProvider.of<ReportBloc>(context).add(GetReportEvent(toDate: toDateController.text, fromDate: fromDateController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarWithBackButton(
          title: 'Report',
          onLeadingPressed: () {},
          onSuffixPressed: () {},
          isleadingIcon: false,
        ),
      ),
      backgroundColor: cFFFFFF,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: const Text("Summary Report", style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xff374A5E)
            )),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Expanded(
              child: TextFormField(
                style: TextStyle(
                  color: Color(0xff969696)
                ),
                controller: fromDateController,
                readOnly: true,
                onTap: () => _selectFromDate(context),
                decoration: InputDecoration(
                  labelText: 'Date From',
                  labelStyle: TextStyle(color: Color(0xff969696)),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff969696)), // Set border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff969696)), // Set focused border color
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff969696),
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today, color: Color(0xff969696)),
                    onPressed: () => _selectFromDate(context),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Expanded(
              child: TextFormField(
                style: TextStyle(
                  color: Color(0xff969696)
                ),
                controller: toDateController,
                readOnly: true,
                onTap: () => _selectToDate(context),
                decoration: InputDecoration(
                  labelText: 'Date To',
                  labelStyle: TextStyle(color: Color(0xff969696)),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff969696)), // Set border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff969696)), // Set focused border color
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff969696),
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today, color: Color(0xff969696)),
                    onPressed: () => _selectToDate(context),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: (){
              BlocProvider.of<ReportBloc>(context).add(GetReportEvent(toDate: toDateController.text, fromDate: fromDateController.text));
            },
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.065,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xff0D8478),
              ),
              child: const Center(
                child: Text("Search", style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700
                )),
              ),
            ),
          ),
          BlocConsumer<ReportBloc, ReportState>(
            listener: (context, state){
              if(state is ReportFailedState){
                if(state.message!.contains("Token Expire")){
                  GlobalVar.recentEvent = [];
                  GlobalVar.recentEvent.add(state);
                  BlocProvider.of<LoginBloc>(context).add(
                      GetAuthTokenEvent(
                          userName: 'MIM2200038',
                          passWord: 'FE1F\$FD9_738'
                        // userName: _userNameController.text,
                        // passWord: _passwordController.text,
                      )
                  );
                }
              } else if(state is ReportSuccessState){
                GlobalVar.fromDate = fromDateController.text;
                GlobalVar.toDate = toDateController.text;
              }
            },
            builder: (context, state){
              if(state is ReportInitialState || state is ReportLoadingState){
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Center(
                    child: CircularProgressIndicator()
                  ),
                );
              }
              else if(state is ReportSuccessState){
                return Expanded(
                  child: Card(
                    elevation: 200,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              customText("Date", 14),
                              customText("MSG Sent", 14),
                              customText("Delivered", 14),
                              customText("Failed", 14),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: state.reportModel.data!.length,
                                itemBuilder: (BuildContext context, int index){
                                  return Row(
                                    children: [
                                      customText(state.reportModel.data![index].createdDate.toString(), 12),
                                      customText(state.reportModel.data![index].sUBMITTED.toString(), 12),
                                      customText(state.reportModel.data![index].dELIVERED.toString(), 12),
                                      customText(state.reportModel.data![index].fAILED.toString(), 12),
                                    ],
                                  );
                                }
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
              else if(state is ReportFailedState){
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Center(child: Text(state.message.toString())),
                );
              } return Container();
            }
          ),
        ],
      ),
    );
  }
}