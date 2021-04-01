import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:final_project/component/color.dart';
import 'package:final_project/widget/button_reuse_2.dart';
import 'package:final_project/widget/colum_text_field.dart';
import 'package:final_project/widget/deleting_file.dart';
import 'package:final_project/widget/uplode_line.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';

class GiftsScreen extends StatefulWidget {
  @override
  _FilesScreenState createState() => _FilesScreenState();
}

class _FilesScreenState extends State<GiftsScreen> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String imageUrl;
  bool spinner = false;
  String umberOfCopies, address;

  Future uploadPic(BuildContext context) async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      if (image != null) {
        setState(() {
          spinner = true;
        });
        var snapshots = await _storage.ref().child('giftImage').putFile(file);

        var downloadUrl = await snapshots.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
        setState(() {
          spinner = false;
        });
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('please upload photo'),
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
              'Gifts',
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
                        (imageUrl == null)
                            ? Image.asset(
                                'images/addimage.png',
                                height: 100,
                                width: 100,
                                fit: BoxFit.scaleDown,
                              )
                            : Image.network(
                                imageUrl,
                                height: 100,
                                width: 100,
                                fit: BoxFit.scaleDown,
                              ),
                        UploadLine(
                          text: 'Add Image',
                          onTap: () => uploadPic(context),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DeletingFile(
                          text: 'Image Name',
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
                          onTap: () async{
                            setState(() {
                              spinner = true;
                            });
                            if (imageUrl != null) {
                              await _fireStore.collection('gifts').add({
                                "numOfCopies": umberOfCopies,
                                "address": address,
                                'url': imageUrl,
                                'sender': _auth.currentUser.email
                              });
                              setState(() {
                                spinner = false;
                              });
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Your order has been send ! ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            } else {
                              setState(() {
                                spinner = false;
                              });
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'No image selected',
                                    style: TextStyle(color: Colors.white),
                                  ),
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
        ));
  }
}
