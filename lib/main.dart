import 'file:///E:/project/final_project/lib/screens/user/clothes_screen.dart';
import 'file:///E:/project/final_project/lib/screens/user/files_screen.dart';
import 'file:///E:/project/final_project/lib/screens/user/gifts_screen.dart';
import 'package:final_project/screens/login_screen.dart';
import 'package:final_project/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:final_project/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref=await SharedPreferences.getInstance();
  String mail =pref.getString('email');
  runApp(Home(mail: mail,));
}
class Home extends StatelessWidget {
  Home({this.mail});
  final String mail;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen(mail: mail,),
    );
  }
}
