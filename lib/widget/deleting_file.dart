import 'package:final_project/component/color.dart';
import 'package:flutter/material.dart';
class DeletingFile extends StatelessWidget {
  const DeletingFile({
    this.text,this.delete
  }) ;
  final String text;
  final Function delete;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.image_outlined,
        ),
        SizedBox(width: 10,),
        Text(
          text,
          style: TextStyle(color: deepBlue, fontSize: 16),
        ),
        SizedBox(width: 10,),
        InkWell(
          onTap: delete,
          child: Icon(
            Icons.delete_outline,
          ),
        ),
      ],
    );
  }
}