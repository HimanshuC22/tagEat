import 'package:flutter/material.dart';
import 'package:tagEat/routes/base.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => BasePage())));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 102, 181, 196),
                Color.fromARGB(255, 39, 91, 105)
              ]),
        ),
        child: Center(
          child: Container(child: Image.asset("assets/images/splash.png",), margin: EdgeInsets.symmetric(horizontal: 30),),
        ),
      ),
    );
  }
}
