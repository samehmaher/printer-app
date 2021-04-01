import 'package:final_project/component/color.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class FileAdmin extends StatefulWidget {
  @override
  _FileAdminState createState() => _FileAdminState();
}

class _FileAdminState extends State<FileAdmin> {
  bool spinner = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: spinner,
      child: Scaffold(
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
            'Files Admin',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ),
      ),
    );
  }
}
