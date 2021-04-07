import 'package:final_project/component/color.dart';
import 'package:final_project/widget/reuse_card.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
class ClothesAdmin extends StatefulWidget {
  @override
  _ClothesAdminState createState() => _ClothesAdminState();
}

class _ClothesAdminState extends State<ClothesAdmin> {
  bool spinner = false;
  var _fireStore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: spinner,
      child: Scaffold(
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
            'Clothes Admin',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _fireStore.collection('clothes').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var snap = snapshot.data.docs;
            List<ReuseCard> cardList = [];
            for (var item in snap) {
              String address = item.data()['address'];
              String numOfCopies = item.data()['numOfCopies'];
              String sender = item.data()['sender'];
              String url = item.data()['url'];
              String fileName = item.data()['fileName'];


              var itemCard = ReuseCard(
                sender: sender,
                address: address ,
                numOfCopies: numOfCopies ,
                url: url,
                fileName: fileName,
                chat:(){} ,
                download: ()async{  await Permission.storage.request();
                var permissionStatus = await Permission.storage.status;
                if (permissionStatus.isGranted) {
                  final externalDir = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
                  await FlutterDownloader.enqueue(
                    url: url,
                    savedDir: externalDir,
                    fileName: fileName,
                    showNotification: true,
                    openFileFromNotification: true,
                  );
                }},

              );
              cardList.add(itemCard);
            }

            return ListView(
              padding: EdgeInsets.all(5),
              children: cardList,
            );
          },
        ),
      ),
    );
  }
}
