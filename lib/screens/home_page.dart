import 'package:final_project/component/color.dart';
import 'package:flutter/material.dart';
import 'package:final_project/widget/home_card.dart';
import 'files_screen.dart';
import 'shield_screen.dart';
import 'gifts_screen.dart';
import 'clothes_screen.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlue,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(60)
          ),
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  HomeCard(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => FilesScreen()));
                    },
                    image: 'file.json',
                    text: 'Files',
                  ),
                  HomeCard(
                    onPressed: (){
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
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => ShieldsScreen()));
                    },
                    image: 'cup.json',
                    text: 'Shields',
                  ),
                  HomeCard(
                    onPressed: (){
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


