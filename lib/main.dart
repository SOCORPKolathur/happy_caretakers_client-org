import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happy_caretakers_client/views/caretaker/caretaker_appointments_view.dart';
import 'package:happy_caretakers_client/views/caretaker/caretaker_main_view.dart';
import 'package:happy_caretakers_client/views/caretaker/caretaker_notifications_view.dart';
import 'package:happy_caretakers_client/views/caretaker/caretaker_register_form_view.dart';
import 'package:happy_caretakers_client/views/caretaker/caretaker_register_view.dart';
import 'package:happy_caretakers_client/views/choose_role_view.dart';
import 'package:happy_caretakers_client/views/setPage.dart';
import 'package:happy_caretakers_client/views/user/main_view.dart';
import 'firebase_api.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  await FirebaseApi().initNotifications();
  var delegate = await LocalizationDelegate.create(
      basePath: 'assets/i18n/',
      fallbackLocale: 'en_US',
      supportedLocales: ['ta','te','ml','kn','en_US','bn','hi','es','pt','fr','nl','de','it','sv']);
  runApp(LocalizedApp(delegate, MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        title: 'Happy Caretakers',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: FutureBuilder(
        //     future: isRegistered(),
        //     builder: (ctx, snap){
        //       if(snap.hasData){
        //         if(snap.data!.toLowerCase() == "not register"){
        //           return CaretakerRegisterView(id: FirebaseAuth.instance.currentUser!.uid, phone: FirebaseAuth.instance.currentUser!.phoneNumber!, firstName: '',lastName: '');
        //         }else if(snap.data!.toLowerCase() == "caretaker"){
        //           return const CareTakerMainView();
        //         }else if(snap.data!.toLowerCase() == "user"){
        //           return const MainView();
        //         }else if(snap.data!.toLowerCase() == "get started"){
        //           changeLocale(context, doc.get("lanCode"));
        //           return const MainView();
        //         }else{
        //           return const ChooseRoleView();
        //         }
        //       }
        //       return const Scaffold(body: Center(child: CircularProgressIndicator()));
        //     },
        // ),
        home: SetPage(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
      ),
    );
  }
}
