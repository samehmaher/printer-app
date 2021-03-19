import 'package:flutter/material.dart';
Widget customTextField({String hint, controller,FormFieldValidator validator, icon,obscureText,keyboardType,onChanged}) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    padding: EdgeInsets.only(left: 20),
    child: TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        prefixIcon: Icon(icon),

      ),
    ),
  );
}
