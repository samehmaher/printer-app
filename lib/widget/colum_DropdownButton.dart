import 'package:final_project/component/color.dart';
import 'package:flutter/material.dart';
class ColumDropDown extends StatelessWidget {
  ColumDropDown({
    this.headText,this.onChange,this.value,this.text,this.item
});
  final String headText,value,text;
  final Function onChange;
  final List<DropdownMenuItem> item;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headText,
          style: TextStyle(color: deepBlue, fontSize: 16),
        ),
        DropdownButton(
          focusColor: Colors.white,
          isExpanded: true,
          hint: Text(
            text,
            style: TextStyle(color: deepBlue, fontSize: 16),
          ),
          value: value,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: deepBlue,
          ),
          elevation: 10,
          items: item,
          onChanged: onChange,
        )
      ],
    );
  }
}
