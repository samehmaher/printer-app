import 'package:final_project/component/color.dart';
import 'package:flutter/material.dart';
class Header extends StatelessWidget {
  Header({this.text }) ;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [deepBlue, lightBlue],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius:
          BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
          children:[
            Positioned(
                bottom: 20,
                right: 20,
                child: Text(text,style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),)),
            Center(
              child: Image.asset(
                "images/logo.png",
                height: 100,
                width: 100,
                fit: BoxFit.fill,
              ),
            ),
          ]
      ),
    );
  }
}