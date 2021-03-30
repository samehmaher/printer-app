import 'package:final_project/component/color.dart';
import 'package:flutter/material.dart';
class ColumTextField extends StatelessWidget {
  const ColumTextField({
    this.headText,this.hint,this.onChange
  }) ;
  final String headText;
  final String hint;
  final Function onChange;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headText,
          style: TextStyle(color: deepBlue, fontSize: 16),
        ),
        TextField(
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            hintText: hint,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: deepBlue)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: deepBlue)),
          ),
          onChanged: onChange,
        )
      ],
    );
  }
}