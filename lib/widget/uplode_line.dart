import 'package:final_project/component/color.dart';
import 'package:flutter/material.dart';

class UploadLine extends StatelessWidget {
  UploadLine({this.onTap,this.text});
  String text;
  Function onTap;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: deepBlue,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 10,),
            CircleAvatar(
              radius: 15,
              child:Icon(Icons.add,color:Colors.white,),
              backgroundColor: deepBlue,
            )
          ],
        ),
      ),
    );
  }
}
