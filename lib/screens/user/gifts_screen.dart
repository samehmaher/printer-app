import 'package:final_project/component/color.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class GiftsScreen extends StatefulWidget {
  @override
  _FilesScreenState createState() => _FilesScreenState();
}

class _FilesScreenState extends State<GiftsScreen> {
  bool spinner=false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: spinner,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [deepBlue, lightBlue],
                    end: Alignment.centerLeft,
                    begin: Alignment.centerRight),
              ),
            ),
            title: Text(
              'Gifts',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          body: Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(

              ),
            ),
          ),
        ));
  }
}
