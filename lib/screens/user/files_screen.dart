import 'package:final_project/component/color.dart';
import 'package:final_project/widget/button_reuse_2.dart';
import 'package:final_project/widget/colum_DropdownButton.dart';
import 'package:final_project/widget/colum_text_field.dart';
import 'package:final_project/widget/deleting_file.dart';
import 'package:final_project/widget/uplode_line.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class FilesScreen extends StatefulWidget {
  @override
  _FilesScreenState createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  bool spinner = false;
  String printSize, umberOfCopies,printType,address;
  List sizeList = ['A4', 'A3'];
  List typeList = ['Black & White','Colors'];

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
            'Files',
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
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/fileicon.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.scaleDown,
                      ),
                      UploadLine(
                        text: 'Add File',
                        onTap: () {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DeletingFile(
                        text: 'File Name',
                        delete: () {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ColumTextField(
                        headText: 'Number Of Copies :',
                        hint: '  Enter Number Of Copy',
                        onChange: (val) {
                          umberOfCopies = val;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ColumDropDown(
                        headText: 'Print Size :',
                        text: 'Choose',
                        value: printSize,
                        item: sizeList.map((item) {
                          return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: deepBlue,
                                ),
                              ));
                        }).toList(),
                        onChange: (newValue) {
                          setState(() {
                            printSize = newValue;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ColumDropDown(
                        headText: 'Print Type :',
                        text: 'Choose',
                        value: printType,
                        item: typeList.map((item) {
                          return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: deepBlue,
                                ),
                              ));
                        }).toList(),
                        onChange: (newValue) {
                          setState(() {
                            printType = newValue;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ColumTextField(
                        headText: 'Your Address :',
                        hint: '  Enter Your Address',
                        onChange: (val) {
                          address = val;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ButtonReuse2(
                        text: 'SEND',
                        width: double.infinity,
                        onTap: (){},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
