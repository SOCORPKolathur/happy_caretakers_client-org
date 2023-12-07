import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Constants{

  //static Color primaryAppColor = const Color(0xff2663FF);
  static Color primaryAppColor = const Color(0xff2A72FF);
  static Color secondaryAppColor = const Color(0xffE0E4E9);
  static Color appBackgroundolor = const Color(0xffD9E8F7);
  static Color darkGrey = const Color(0xff38435D);
  static Color semiGrey = const Color(0xff949BA7);
  static Color lightGrey = const Color(0xff737D8F);
  static Color primaryWhite = const Color(0xffFFFFFF);
  static Color lightOrange = const Color(0xffFF7070);
  static Color darkBlue = const Color(0xff316BFF);
  static Color darkBlack = const Color(0xff000000);

  static Color newGrey = const Color(0xff747474);

  static String apiKeyForNotification = 'AAAAuXtlnh0:APA91bGeXqTlXet8ggWrElYWaUa4XAXG_n3g3pj9G956YLRHAOVsr_oqVElTeWzGZVWgCGdYgKRX-LQTh2noK_FJ0-oG6b9TB0E5nNoph0K44h67C8d9xEHxJuXHfe30IpXH9FHjsa9w';


  static checkUserLoginStatus(){
    bool status = false;
    if(FirebaseAuth.instance.currentUser!=null){
      status = true;
    }
    return status;
  }

}