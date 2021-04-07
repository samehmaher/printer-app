import 'package:final_project/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(
      debug: true
  );
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
