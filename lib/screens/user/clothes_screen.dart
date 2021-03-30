import 'package:final_project/component/color.dart';
import 'package:final_project/widget/button_reuse_2.dart';
import 'package:final_project/widget/colum_text_field.dart';
import 'package:final_project/widget/deleting_file.dart';
import 'package:final_project/widget/uplode_line.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class ClothesScreen extends StatefulWidget {
  @override
  _FilesScreenState createState() => _FilesScreenState();
}

class _FilesScreenState extends State<ClothesScreen> {
  bool spinner = false;
  String umberOfCopies,address;
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
              'Clothes',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white.withOpacity(0.9),
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
                          'images/addimage.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.scaleDown,
                        ),
                        UploadLine(
                          text: 'Add Image',
                          onTap: (){},
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
        ));
  }
}
