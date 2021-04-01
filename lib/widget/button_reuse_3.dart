import 'package:final_project/component/color.dart';
import 'package:flutter/material.dart';
class ButtonReuse3 extends StatelessWidget {
  ButtonReuse3({
    this.text,this.width,this.onTap,this.height,this.font
  });
  final String text;
  final double width,height,font;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [deepBlue, lightBlue],
                  end: Alignment.centerLeft,
                  begin: Alignment.centerRight),
              borderRadius:
              BorderRadius.all(Radius.circular(100))),
          alignment: Alignment.center,
          child: Text(text,style: TextStyle(
              fontSize:font ,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),),
        ),
      ),
    );
  }
}