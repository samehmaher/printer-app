import 'package:final_project/component/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class HomeCard extends StatelessWidget {
  HomeCard({this.image,this.onPressed,this.text }) ;
  final Function onPressed;
  final String image ;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          height: 215,
          width: 160,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [deepBlue, lightBlue],
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter),
              color: lightBlue,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              Lottie.asset('images/$image',fit: BoxFit.fill,),
              Text(text,style: TextStyle(fontSize: 30,color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }
}