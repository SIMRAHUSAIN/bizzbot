import 'package:flutter/material.dart';
import 'package:mim_whatsup/features/splash_screen/screen/splash_screen.dart';
import 'package:mim_whatsup/utils/bloc_providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ParentBlocProviders(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AppSplashScreen(),
      ),
    );
  }
}

