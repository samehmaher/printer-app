import 'package:flutter/material.dart';
// ignore: must_be_immutable
class SocialIcons extends StatelessWidget {
  SocialIcons({this.icon,this.bg,this.ic});
  IconData icon;
  Color bg,ic;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: bg,
        child: Icon(
          icon,
          color: ic,
          size: 30,
        ),
      ),
    );
  }
}