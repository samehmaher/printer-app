import 'package:final_project/component/color.dart';
import 'package:final_project/widget/button_reuse_3.dart';
import 'package:flutter/material.dart';

class ReuseCard extends StatelessWidget {
  ReuseCard(
      {this.sender,
      this.address,
      this.numOfCopies,
      this.chat,
      this.download,
      this.url});

  final String sender, address, numOfCopies, url;
  final Function download, chat;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      width: double.infinity,

      decoration: BoxDecoration(
        border: Border.all(color: deepBlue),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Sender : $sender',
                style: TextStyle(fontSize: 14, color: deepBlue),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Address : $address',
                style: TextStyle(fontSize: 14, color: deepBlue),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Number Of Copies : $numOfCopies',
                style: TextStyle(fontSize: 14, color: deepBlue),
              )
            ],
          ),
          Column(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(url),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                // child: Image.network(
                //   url,
                //   height: 100,
                //   width: 100,
                //   fit: BoxFit.scaleDown,
                // ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  ButtonReuse3(
                    font: 14,
                    height: 30,
                    text: 'Download',
                    width: 80,
                    onTap: download,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ButtonReuse3(
                    font: 14,
                    height: 30,
                    text: 'Chat',
                    width: 80,
                    onTap: chat,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
