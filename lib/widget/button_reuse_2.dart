import 'package:final_project/component/color.dart';
import 'package:flutter/material.dart';
class ButtonReuse2 extends StatelessWidget {
  ButtonReuse2({
    this.text,this.width,this.onTap
  });
  final String text;
  final double width;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          height: 50,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [deepBlue, lightBlue],
                  end: Alignment.centerLeft,
                  begin: Alignment.centerRight),
              borderRadius:
              BorderRadius.all(Radius.circular(100))),
          alignment: Alignment.center,
          child: Text(text,style: TextStyle(
              fontSize:16 ,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),),
        ),
      ),
    );
  }
}