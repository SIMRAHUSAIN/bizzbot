import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mim_whatsup/features/splash_screen/screen/splash_screen.dart';
import 'package:mim_whatsup/utils/bloc_providers.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ParentBlocProviders(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MIM WhatsUp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AppSplashScreen(),
      ),
    );
  }
}

