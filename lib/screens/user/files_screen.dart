import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:final_project/component/color.dart';
import 'package:final_project/widget/button_reuse_2.dart';
import 'package:final_project/widget/colum_DropdownButton.dart';
import 'package:final_project/widget/colum_text_field.dart';
import 'package:final_project/widget/deleting_file.dart';
import 'package:final_project/widget/uplode_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:permission_handler/permission_handler.dart';


class FilesScreen extends StatefulWidget {
  @override
  _FilesScreenState createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool spinner = false;
  String fileUrl;
  String printSize, umberOfCopies,printType,address;
  List sizeList = ['A4', 'A3'];
  List typeList = ['Black & White','Colorful'];


  Future uploadFile(BuildContext context) async {
    final _storage = FirebaseStorage.instance;
    final _picker =FilePicker.platform;
    var image;
    await Permission.storage.request();
    var permissionStatus = await Permission.storage.status;
    if (permissionStatus.isGranted) {
      image = await _picker.pickFiles(type: FileType.any);
      var file = File(image.path);
      if (image != null) {
        setState(() {
          spinner = true;
        });
        var snapshots =
        await _storage.ref().child('file').putFile(file);

        var downloadUrl = await snapshots.ref.getDownloadURL();
        setState(() {
          fileUrl = downloadUrl;
        });
        setState(() {
          spinner = false;
        });
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('please upload File'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('No Permission accepting'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }


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
                      (fileUrl==null)?Image.asset(
                        'images/fileicon.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.scaleDown,
                      ):Image.network(
                        fileUrl,
                        height: 100,
                        width: 100,
                        fit: BoxFit.scaleDown,
                      ),
                      UploadLine(
                        text: 'Add File',
                        onTap: () =>uploadFile(context),
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
                        keyboard: TextInputType.number,
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
                        keyboard: TextInputType.text,
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
                        onTap: (){
                          if(fileUrl!=null){
                            _fireStore.collection('file').add({
                              "numOfCopies": umberOfCopies,
                              "address":address,
                              'printSize':printSize,
                              'printType':printType,
                              'url':fileUrl,
                              'sender':_auth.currentUser.email
                            });
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Your order has been send ! ',style: TextStyle(
                                    color: Colors.white
                                ),),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }else{
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('No file selected',style: TextStyle(
                                    color: Colors.white
                                ),),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }

                        },
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
