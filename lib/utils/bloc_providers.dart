import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mim_whatsup/features/dashboard/bloc/bloc.dart';
import 'package:mim_whatsup/features/dashboard/repo/repo.dart';
import 'package:mim_whatsup/features/login/bloc/bloc.dart';
import 'package:mim_whatsup/features/login/repo/repo.dart';
import 'package:mim_whatsup/features/user_chat/bloc/bloc.dart';
import 'package:mim_whatsup/features/user_chat/repo/repo.dart';

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
        BlocProvider<DashboardBloc>(
          create: (BuildContext context) => DashboardBloc(
            repo: DashboardRepoImpl()
          )
        ),
        BlocProvider<ChatBloc>(
          create: (BuildContext context) => ChatBloc(repo: ChatRepoImpl())
        )
      ],
      child: child,
    );
  }
}