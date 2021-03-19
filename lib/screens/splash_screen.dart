import 'dart:async';
import 'package:final_project/component/color.dart';
import 'package:final_project/screens/login_screen.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 5000), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [deepBlue,lightBlue],
                end: Alignment.bottomCenter,
            begin: Alignment.topCenter
          ),

        ),
        child: Center(
          child: Image.asset("images/logo.png",height: 100,width: 100,fit: BoxFit.fill,),
        ),
      ),
    );
  }
}
