import 'package:agent_league/helper/shared_preferences.dart';
import 'package:agent_league/provider/firestore_data_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Services/auth_methods.dart';
import '../theme/colors.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  bool loading = false;
  late String currentPlot;
  late String plotStoragePath;
  List res = [];

  final String images = "IMAGES";
  final String videos = "VIDEOS";
  final String documents = "DOCUMENTS";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.dark,
          leading: IconButton(
            padding: const EdgeInsets.only(left: 16),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 24),
                child:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.share)))
          ],
        ),
        body: FutureBuilder(
            future: FirestoreDataProvider().getFirestoreFiles(images),
            builder: (context, snapshot) {
              if(snapshot.connectionState != ConnectionState.done){
                return const SpinKitThreeBounce(
                  size: 30,
                  color: Colors.white,
                );
              }
              if (snapshot.hasData) {
                res = snapshot.data as List;
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      for (var i = 0; i < res.length; i += 1)
                        Container(
                          height: 200,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image.network(res[i], fit: BoxFit.fill,),
                        ),
                    ],
                  ),
                ),
              );
            }));
  }
}
