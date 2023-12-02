import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:happy_caretakers_client/views/caretaker/caretaker_main_view.dart';
import 'package:happy_caretakers_client/views/caretaker/caretaker_register_view.dart';
import 'package:happy_caretakers_client/views/choose_role_view.dart';
import 'package:happy_caretakers_client/views/user/main_view.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

  Future<String> isRegistered() async {
    String result = "";
    if(FirebaseAuth.instance.currentUser!=null){
      var doc = await FirebaseFirestore.instance.collection('CareTakers').doc(FirebaseAuth.instance.currentUser!.uid).get();
      if(doc.exists){
        if(doc.get("firstName") == ""){
          result = "Not Register";
        }else{
          result = "Caretaker";
        }
      }else{
        result = "User";
      }
    }else{
      result = "Choose";
    }
    return result;
  }

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
        home: FutureBuilder(
            future: isRegistered(),
            builder: (ctx, snap){
              if(snap.hasData){
                if(snap.data!.toLowerCase() == "not register"){
                  return CaretakerRegisterView(id: FirebaseAuth.instance.currentUser!.uid, phone: FirebaseAuth.instance.currentUser!.phoneNumber!);
                }else if(snap.data!.toLowerCase() == "caretaker"){
                  return const CareTakerMainView();
                }else if(snap.data!.toLowerCase() == "user"){
                  return const MainView();
                }return const ChooseRoleView();
              }
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            },
        ),
        //FirebaseAuth.instance.currentUser != null ? isRegistered() ? RootApp(id: FirebaseAuth.instance.currentUser!.uid) : RootApp(id: FirebaseAuth.instance.currentUser!.uid) : const ChooseRoleView(),
        //home: CaretakerRegisterView(fcmToken: '',id: "",phone: ""),
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
