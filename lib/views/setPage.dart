import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:happy_caretakers_client/views/user/main_view.dart';

import 'caretaker/caretaker_language_select_view.dart';
import 'caretaker/caretaker_main_view.dart';
import 'caretaker/caretaker_register_view.dart';
import 'choose_role_view.dart';

class SetPage extends StatefulWidget {
  const SetPage({super.key});

  @override
  State<SetPage> createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {

  var doc;
  String result = "Choose";

  isRegistered() async {
    String? devId = await _getId();
    print(devId);
    print("object111");
    doc = await FirebaseFirestore.instance.collection('TempUsers').doc(devId).get();
    if(FirebaseAuth.instance.currentUser!=null){
      var doc1 = await FirebaseFirestore.instance.collection('CareTakers').doc(FirebaseAuth.instance.currentUser!.uid).get();
      if(doc1.exists){
        if(doc1.get("name") == ""){
          changeLocale(context, doc1.get("lanCode"));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> CaretakerRegisterView(id: FirebaseAuth.instance.currentUser!.uid, phone: FirebaseAuth.instance.currentUser!.phoneNumber!, name: '',lanCode: doc1.get("lanCode"))));
        }else{
          changeLocale(context, doc1.get("lanCode"));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> CareTakerMainView()));
        }
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> MainView()));
        result = "User";
      }
    }else if(doc.exists){
      changeLocale(context, doc.get("lanCode"));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> MainView()));
      print("____________________");
      //return "Get started";
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const CareTakerLanguageSelectView()));
      result = "Choose";
    }
    return result;
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  @override
  void initState() {
    isRegistered();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
    // if(result.toLowerCase() == "not register"){
    //             return CaretakerRegisterView(id: FirebaseAuth.instance.currentUser!.uid, phone: FirebaseAuth.instance.currentUser!.phoneNumber!, firstName: '',lastName: '');
    //           }else if(result.toLowerCase() == "caretaker"){
    //             return const CareTakerMainView();
    //           }else if(result.toLowerCase() == "user"){
    //             return const MainView();
    //           }else if(result.toLowerCase() == "get started"){
    //             changeLocale(context, doc.get("lanCode"));
    //             return const MainView();
    //           }else{
    //             return const ChooseRoleView();
    //           }
  }
}
