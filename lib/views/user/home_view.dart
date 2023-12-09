import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/models/care_takers_model.dart';
import 'package:happy_caretakers_client/services/care_takers_firecrud.dart';
import 'package:happy_caretakers_client/views/login_view.dart';
import 'package:happy_caretakers_client/views/user/profile_details_view.dart';
import 'package:happy_caretakers_client/widgets/custom_profile_card.dart';
import 'package:happy_caretakers_client/widgets/drawer_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import '../../widgets/appbar_search.dart';
import '../../widgets/kText.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {

  TextEditingController searchProfessionalsController = TextEditingController();
  TabController? tabController;
  String name = "";
  double lat = 0.0;
  double lon = 0.0;

  @override
  void initState() {
    getUser();
    getLatLng();
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  getUser() async {
    String? docId = await _getId();
    if(FirebaseAuth.instance.currentUser != null){
      var userDoc = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      if(userDoc.exists){
        setState(() {
          name = userDoc.get("firstName")+" "+userDoc.get("lastName");
        });
      }
    } else{
      var tempUserDoc = await FirebaseFirestore.instance.collection('TempUsers').doc(docId).get();
      setState(() {
        name = tempUserDoc.get("name");
      });
    }
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

  getLatLng() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = position.latitude!;
      lon = position.longitude!;
    });
  }

  List<String> tabs = [
    'Doctors',
    'Nurses',
    'Caretakers',
    'Physiotherapist',
  ];

  String searchQuery = "doctor";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Constants.appBackgroundolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constants.appBackgroundolor,
        leadingWidth: width/6.792452830188679,
        leading: Row(
          children: [
            SizedBox(width: width/45),
            CircleAvatar(
              radius: height/34.36363636363636,
              backgroundImage: NetworkImage("https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png"),
            ),
          ],
        ),
        title: AppBarSearchWidget(
          controller: searchProfessionalsController,
          onTap:(){
            setState(() {});
          },
          onChanged: (){
            setState(() {});
          },
          onSubmitted:(){
            setState(() {});
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: height/44.47058823529412),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: width/36,right: width/36),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Hello',
                        style: GoogleFonts.poppins(
                            fontSize: width/15.65217391304348,
                            color: Constants.darkGrey,
                            fontWeight: FontWeight.w600),
                      ),
                      KText(
                        text: name,
                        style: GoogleFonts.poppins(
                            fontSize: width/20,
                            color: Constants.darkGrey,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(width: width/36),
                  SizedBox(
                    height: height/18.9,
                    width: width/9,
                    child: Lottie.asset('assets/hii_hand.json'),
                  )
                ],
              ),
            ),
            SizedBox(height: height/75.6),
            Center(
              child: KText(
                text: 'Professionals near you',
                style: GoogleFonts.poppins(
                    fontSize: width/20,
                    color: Constants.darkGrey,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: height/75.6),
            Container(
              height: 50,
              width: width,
              decoration: BoxDecoration(
                color: Constants.primaryWhite,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
              child: TabBar(
                tabAlignment: TabAlignment.start,
                splashFactory: null,
                isScrollable: true,
                controller: tabController,
                onTap: (index){},
                unselectedLabelColor: Constants.lightGrey,
                labelColor: Constants.primaryAppColor,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                tabs: tabs.map((e) => Tab(text: e)).toList(),
              ),
            ),
            //padding: EdgeInsets.only(left: width/36,right: width/36),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: width/36,right: width/36),
                child: SizedBox(
                  width: size.width,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      buildDoctorsTab(),
                      buildNursesTab(),
                      buildCartakersTab(),
                      buildPhysiotherapistTab(),
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      ),
      endDrawer: const DrawerWidget(),
    );
  }

  buildDoctorsTab(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('CareTakers').where("category", isEqualTo: 'Doctor').snapshots(),
        builder: (ctx, snap){
          if(snap.hasData){
            print("object");
            List<DocumentSnapshot> careTakers1 = snap.data!.docs;
            List<CareTakersModel> careTakers = [];
              careTakers1.forEach((element) {
                  careTakers.add(CareTakersModel.fromJson(element.data() as Map<String,dynamic>));
              });
            return ListView.builder(
              itemCount: careTakers.length,
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: height/50.4),
                  child: CustomProfileCard(
                    lat: lat,
                    lon: lon,
                    careTaker: careTakers[i],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => ProfileDetailsView(id: careTakers[i].id)
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }return Container();
        },
    );
  }

  buildNursesTab(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('CareTakers').where("category", isEqualTo: 'Nurse').snapshots(),
      builder: (ctx, snap){
        if(snap.hasData){
          print("object");
          List<DocumentSnapshot> careTakers1 = snap.data!.docs;
          List<CareTakersModel> careTakers = [];
          careTakers1.forEach((element) {
            careTakers.add(CareTakersModel.fromJson(element.data() as Map<String,dynamic>));
          });
          return ListView.builder(
            itemCount: careTakers.length,
            itemBuilder: (ctx, i) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: height/50.4),
                child: CustomProfileCard(
                  lat: lat,
                  lon: lon,
                  careTaker: careTakers[i],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => ProfileDetailsView(id: careTakers[i].id)
                      ),
                    );
                  },
                ),
              );
            },
          );
        }return Container();
      },
    );
  }

  buildCartakersTab(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('CareTakers').where("category", isEqualTo: 'Caretaker').snapshots(),
      builder: (ctx, snap){
        if(snap.hasData){
          print("object");
          List<DocumentSnapshot> careTakers1 = snap.data!.docs;
          List<CareTakersModel> careTakers = [];
          careTakers1.forEach((element) {
            careTakers.add(CareTakersModel.fromJson(element.data() as Map<String,dynamic>));
          });
          return ListView.builder(
            itemCount: careTakers.length,
            itemBuilder: (ctx, i) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: height/50.4),
                child: CustomProfileCard(
                  lat: lat,
                  lon: lon,
                  careTaker: careTakers[i],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => ProfileDetailsView(id: careTakers[i].id)
                      ),
                    );
                  },
                ),
              );
            },
          );
        }return Container();
      },
    );
  }

  buildPhysiotherapistTab(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('CareTakers').where("category", isEqualTo: 'Physiotherapist').snapshots(),
      builder: (ctx, snap){
        if(snap.hasData){
          print("object");
          List<DocumentSnapshot> careTakers1 = snap.data!.docs;
          List<CareTakersModel> careTakers = [];
          careTakers1.forEach((element) {
            careTakers.add(CareTakersModel.fromJson(element.data() as Map<String,dynamic>));
          });
          return ListView.builder(
            itemCount: careTakers.length,
            itemBuilder: (ctx, i) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: height/50.4),
                child: CustomProfileCard(
                  lat: lat,
                  lon: lon,
                  careTaker: careTakers[i],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => ProfileDetailsView(id: careTakers[i].id)
                      ),
                    );
                  },
                ),
              );
            },
          );
        }return Container();
      },
    );
  }

  showLoginPopUp(){
    Dialogs.materialDialog(
        color: Colors.white,
        msg: 'You are not Logged In.Kindly log in to continue',
        title: 'Log In',
        lottieBuilder: Lottie.asset(
          'assets/logout.json',
          fit: BoxFit.contain,
        ),
        context: context,
        actions: [
          IconsButton(
            onPressed: () async {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> const LoginView(isCareTaker: false)));
            },
            text: 'Log In',
            color: Colors.blue,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: 'Cancel',
            color: Colors.grey,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]
    );
  }

}
