import 'package:flutter/material.dart';
import 'package:tagEat/constants.dart';
import 'package:tagEat/routes/device.dart';
import 'package:tagEat/routes/home.dart';
import 'package:tagEat/routes/loginpage.dart';
import 'package:tagEat/routes/profile.dart';
import 'package:tagEat/routes/settings.dart';
import 'package:tagEat/routes/splash.dart';
import 'routes/base.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    return MaterialApp(
      title: 'Scont',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'muli',
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => SplashScreen(),
        '/devices': (context) => DeviceListPage(),
      },
      initialRoute: '/',
    );
  }
}