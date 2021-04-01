import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:final_project/component/color.dart';
import '../../widget/button_reuse_2.dart';
import '../../widget/colum_DropdownButton.dart';
import '../../widget/colum_text_field.dart';

class ShieldsScreen extends StatefulWidget {
  @override
  _FilesScreenState createState() => _FilesScreenState();
}

class _FilesScreenState extends State<ShieldsScreen> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool spinner=false;
  String script,address,models;
  List modelList = ['model 1', 'model 2' , 'model 3'];
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
              'Shield',
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
                        ColumDropDown(
                          headText: 'Print Size :',
                          text: 'Choose',
                          value: models,
                          item: modelList.map((item) {
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
                              models = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 20,),
                        ColumTextField(
                          keyboard: TextInputType.text,
                          headText: 'Enter Script :',
                          hint: '  Enter Your Script',
                          onChange: (val) {
                            script = val;
                          },
                        ),
                        SizedBox(height: 20,),
                        ColumTextField(
                          keyboard: TextInputType.text,
                          headText: 'Your Address :',
                          hint: '  Enter Your Address',
                          onChange: (val) {
                            address = val;
                          },
                        ),
                        SizedBox(height: 20,),
                        ButtonReuse2(
                          text: 'SEND',
                          width: double.infinity,
                          onTap: ()async{
                            setState(() {
                              spinner = true;
                            });
                            if(models!=null){
                              await _fireStore.collection('shields').add({
                                "address":address,
                                'script':script,
                                'model':models,
                                'sender':_auth.currentUser.email
                              });
                              setState(() {
                                spinner = false;
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
                              setState(() {
                                spinner = false;
                              });
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('No Model selected',style: TextStyle(
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
