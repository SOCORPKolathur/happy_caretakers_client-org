import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/views/user/profile_details_view.dart';
import 'package:lottie/lottie.dart';

import '../../models/care_takers_model.dart';
import '../../widgets/custom_profile_card.dart';
import '../../widgets/kText.dart';

class WishListView extends StatefulWidget {
  const WishListView({super.key});

  @override
  State<WishListView> createState() => _WishListViewState();
}

class _WishListViewState extends State<WishListView> {

  double lat = 0.0;
  double lon = 0.0;

  @override
  void initState() {
    getLatLng();
    super.initState();
  }

  getLatLng() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = position.latitude!;
      lon = position.longitude!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: Constants.appBackgroundolor,
      appBar: AppBar(
        backgroundColor: Constants.primaryAppColor,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Constants.primaryWhite,
            ),
        ),
        title: KText(
          text: "Your Wishlist",
          style: GoogleFonts.montserrat(
            color: Constants.primaryWhite,
            fontWeight: FontWeight.w500,
            fontSize: width / 18.947368421,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FirebaseAuth.instance.currentUser != null ? StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Wishlist').snapshots(),
          builder: (ctx, snap){
            if(snap.hasData){
              return snap.data!.docs.isEmpty
                  ? Container(
                child: Center(
                  child: Lottie.asset("assets/no_noti.json"),
                ),
              )
                  : ListView.builder(
                itemCount: snap.data!.docs.length,
                itemBuilder: (ctx, i) {
                  var data = CareTakersModel.fromJson(snap.data!.docs[i].data());
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: height/50.4),
                    child: CustomProfileCard(
                      lat: lat,
                      lon: lon,
                      careTaker: data,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => ProfileDetailsView(id: data.id)
                            ),
                        );
                      },
                    ),
                  );
                },
              );
            }return Container();
          },
        ) : Container(),
      ),
    );
  }
}
