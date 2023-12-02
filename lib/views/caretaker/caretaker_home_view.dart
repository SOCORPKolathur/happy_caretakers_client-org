import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/models/care_takers_model.dart';
import 'package:happy_caretakers_client/services/care_takers_firecrud.dart';
import 'package:happy_caretakers_client/views/user/profile_details_view.dart';
import 'package:happy_caretakers_client/widgets/caretaker_drawer_widget.dart';
import 'package:happy_caretakers_client/widgets/custom_profile_card.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/appbar_search.dart';
import '../../widgets/kText.dart';

class CaretakerHomeView extends StatefulWidget {
  const CaretakerHomeView({super.key});

  @override
  State<CaretakerHomeView> createState() => _CaretakerHomeViewState();
}

class _CaretakerHomeViewState extends State<CaretakerHomeView> with SingleTickerProviderStateMixin {

  TextEditingController searchProfessionalsController = TextEditingController();
  TabController? tabController;

  CareTakersModel? careTaker;

  @override
  void initState() {
    getUser();
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  getUser() async {
    var doc = await FirebaseFirestore.instance.collection('CareTakers').doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      careTaker = CareTakersModel.fromJson(doc.data() as Map<String, dynamic>);
    });
  }

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
            careTaker != null ? CircleAvatar(
              radius: height/34.36363636363636,
              backgroundImage: NetworkImage(
                careTaker!.imgUrl,
              ),
            ) : CircleAvatar(),
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
        padding: EdgeInsets.only(top: height/44.47058823529412,left: width/36,right: width/36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                      text: careTaker!= null ? "${careTaker!.firstName} ${careTaker!.lastName}" : "Guest",
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
            SizedBox(height: height/75.6),
          ],
        ),
      ),
      endDrawer: const CaretakerDrawerWidget(),
    );
  }
}
