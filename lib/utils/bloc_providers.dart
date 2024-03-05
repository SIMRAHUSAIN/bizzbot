import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/dashboard/bloc/bloc.dart';
import 'package:mim_whatsup/features/dashboard/repo/repo.dart';
import 'package:mim_whatsup/features/individual_chat/bloc/bloc.dart';
import 'package:mim_whatsup/features/individual_chat/repo/repo.dart';
import 'package:mim_whatsup/features/login/bloc/bloc.dart';
import 'package:mim_whatsup/features/login/repo/repo.dart';
import 'package:mim_whatsup/features/report/bloc/report_bloc.dart';
import 'package:mim_whatsup/features/report/repository/report_repository.dart';
import 'package:mim_whatsup/features/send_msg/bloc/bloc.dart';
import 'package:mim_whatsup/features/send_msg/repo/repo.dart';
import 'package:mim_whatsup/features/user_chat/bloc/bloc.dart';
import 'package:mim_whatsup/features/user_chat/repo/repo.dart';
import 'package:mim_whatsup/features/user_chat_filter/bloc/bloc.dart';
import 'package:mim_whatsup/features/user_chat_filter/repo/repo.dart';

import '../features/send_msg/unique_count/bloc/unique_bloc.dart';
import '../features/send_msg/unique_count/repo/unique_repo.dart';

class ParentBlocProviders extends StatelessWidget {

  final Widget child;

  const ParentBlocProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(
            repo: LoginRepoImpl()
          )
        ),
        BlocProvider<ChatBloc>(
          create: (BuildContext context) => ChatBloc(repo: ChatRepoImpl())
        ),
        BlocProvider<DashboardBloc>(
          create: (BuildContext context) => DashboardBloc(
            repo: DashboardRepoImpl()
          )
        ),
        BlocProvider<ChatFilterBloc>(
          create: (BuildContext context) => ChatFilterBloc(repo: ChatFilterRepoImpl())
        ),
        BlocProvider<IndividualChatBloc>(
          create: (BuildContext context) => IndividualChatBloc(
            repo: IndividualChatRepoImpl()
          )
        ),
        BlocProvider<ReportBloc>(
          create: (BuildContext context) => ReportBloc(
            repo: ReportRepoImpl()
          )
        ),
        BlocProvider<SendMessageBloc>(
          create: (BuildContext context) => SendMessageBloc(
            repo: SendMsgRepoImpl()
          )
        ),
        BlocProvider<UniqueBloc>(
            create: (BuildContext context) => UniqueBloc(
                repo: UniqueRepoImpl()
            )
        ),
      ],
      child: child,
    );
  }
}