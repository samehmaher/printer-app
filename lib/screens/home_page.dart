import 'package:final_project/component/color.dart';
import 'package:final_project/screens/login_screen.dart';
import 'package:final_project/widget/button_reuse.dart';
import 'package:final_project/widget/drawer_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_project/widget/home_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user/files_screen.dart';
import 'user/shield_screen.dart';
import 'user/gifts_screen.dart';
import 'user/clothes_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: deepBlue,
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
        child: Drawer(
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(12),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 35,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                        child: Text(
                      'Print Shop',
                      style: TextStyle(fontSize: 50, color: Colors.black),
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DrawerList(
                    text: 'Sign Out',
                    onTap: () async{
                      _auth.signOut();
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      pref.remove('email');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    icon: Icons.login_outlined,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Copyright © 2021 Print Shop \nAll Rights Reserved \nVersion 1.0',
                    ),
                  ),
                ],
              ),

            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(40)),
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.all(20),
                    icon: Icon(
                      Icons.menu,
                      color: deepBlue,
                      size: 35,
                    ),
                    onPressed: () => scaffoldKey.currentState.openDrawer(),
                  ),
                ],
              ),
              Text(
                'Services',
                style: TextStyle(fontSize: 50, color: deepBlue),
              ),
              Row(
                children: [
                  HomeCard(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FilesScreen()));
                    },
                    image: 'file.json',
                    text: 'Files',
                  ),
                  HomeCard(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClothesScreen()));
                    },
                    image: 'clothes.json',
                    text: 'Clothes',
                  ),
                ],
              ),
              Row(
                children: [
                  HomeCard(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShieldsScreen()));
                    },
                    image: 'cup.json',
                    text: 'Shields',
                  ),
                  HomeCard(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GiftsScreen()));
                    },
                    image: 'gift.json',
                    text: 'Gifts',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
