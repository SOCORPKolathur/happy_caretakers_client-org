import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:happy_caretakers_client/views/caretaker/caretaker_main_view.dart';
import 'package:happy_caretakers_client/views/user/main_view.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key, required this.id});

  final String id;

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {


  Future<bool> getData() async {
    bool isCareTaker = false;
    var doc = await FirebaseFirestore.instance.collection('CareTakers').doc(widget.id).get();

    if(doc.exists){
      isCareTaker = true;
    }

    return isCareTaker;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context,snap) {
          if(snap.hasData){
            if(snap.data!){
              return CareTakerMainView();
            }else{
              return MainView();
            }
          }
          return CircularProgressIndicator();
        }
      ),
    );
  }
}
