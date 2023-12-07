// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:happy_caretakers_client/constants.dart';
// import 'package:happy_caretakers_client/models/care_takers_model.dart';
// import 'package:happy_caretakers_client/services/care_takers_firecrud.dart';
// import 'package:happy_caretakers_client/views/user/profile_details_view.dart';
// import 'package:happy_caretakers_client/widgets/caretaker_drawer_widget.dart';
// import 'package:happy_caretakers_client/widgets/custom_profile_card.dart';
// import 'package:lottie/lottie.dart';
// import '../../widgets/appbar_search.dart';
// import '../../widgets/kText.dart';
//
// class CaretakerHomeView extends StatefulWidget {
//   const CaretakerHomeView({super.key});
//
//   @override
//   State<CaretakerHomeView> createState() => _CaretakerHomeViewState();
// }
//
// class _CaretakerHomeViewState extends State<CaretakerHomeView> with SingleTickerProviderStateMixin {
//
//   TextEditingController searchProfessionalsController = TextEditingController();
//   TabController? tabController;
//
//   CareTakersModel? careTaker;
//
//   @override
//   void initState() {
//     getUser();
//     tabController = TabController(length: 4, vsync: this);
//     super.initState();
//   }
//
//   getUser() async {
//     var doc = await FirebaseFirestore.instance.collection('CareTakers').doc(FirebaseAuth.instance.currentUser!.uid).get();
//     setState(() {
//       careTaker = CareTakersModel.fromJson(doc.data() as Map<String, dynamic>);
//     });
//   }
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     double height = size.height;
//     double width = size.width;
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Constants.appBackgroundolor,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Constants.appBackgroundolor,
//         leadingWidth: width/6.792452830188679,
//         leading: Row(
//           children: [
//             SizedBox(width: width/45),
//             careTaker != null ? CircleAvatar(
//               radius: height/34.36363636363636,
//               backgroundImage: NetworkImage(
//                 careTaker!.imgUrl,
//               ),
//             ) : CircleAvatar(),
//           ],
//         ),
//         title: AppBarSearchWidget(
//           controller: searchProfessionalsController,
//           onTap:(){
//             setState(() {});
//           },
//           onChanged: (){
//             setState(() {});
//           },
//           onSubmitted:(){
//             setState(() {});
//           },
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               _scaffoldKey.currentState!.openEndDrawer();
//             },
//             icon: const Icon(
//               Icons.menu,
//               color: Colors.black,
//             ),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.only(top: height/44.47058823529412,left: width/36,right: width/36),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     KText(
//                       text: 'Hello',
//                       style: GoogleFonts.poppins(
//                           fontSize: width/15.65217391304348,
//                           color: Constants.darkGrey,
//                           fontWeight: FontWeight.w600),
//                     ),
//                     KText(
//                       text: careTaker!= null ? "${careTaker!.firstName} ${careTaker!.lastName}" : "Guest",
//                       style: GoogleFonts.poppins(
//                           fontSize: width/20,
//                           color: Constants.darkGrey,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//                 SizedBox(width: width/36),
//                 SizedBox(
//                   height: height/18.9,
//                   width: width/9,
//                   child: Lottie.asset('assets/hii_hand.json'),
//                 )
//               ],
//             ),
//             SizedBox(height: height/75.6),
//           ],
//         ),
//       ),
//       endDrawer: const CaretakerDrawerWidget(),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/models/care_takers_model.dart';
import 'package:happy_caretakers_client/widgets/caretaker_drawer_widget.dart';
import 'package:happy_caretakers_client/widgets/kText.dart';

import '../../constants.dart';

class CareTakerHomeView extends StatefulWidget {
  const CareTakerHomeView({super.key});

  @override
  State<CareTakerHomeView> createState() => _CareTakerHomeViewState();
}

class _CareTakerHomeViewState extends State<CareTakerHomeView> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Constants.primaryWhite,
      drawer: const CaretakerDrawerWidget(),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('CareTakers').doc(FirebaseAuth.instance.currentUser!.uid).get(),
          builder: (ctx, snap){
            if(snap.hasData){
              CareTakersModel careTaker = CareTakersModel.fromJson(snap.data!.data() as Map<String,dynamic>);
              return Container(
                height: height,
                width: width,
                child: Stack(
                  children: [
                    Container(
                      height: height/2.88,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Constants.darkBlue,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: (){
                                  _scaffoldKey.currentState!.openDrawer();
                                },
                                icon: Icon(Icons.menu,color: Constants.primaryWhite),
                              ),
                              IconButton(
                                onPressed: (){},
                                icon: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Constants.primaryWhite,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Icon(Icons.notifications_active,color: Constants.primaryWhite)),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Constants.primaryWhite,width: 4),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(careTaker.imgUrl),
                                    )
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome Nagaraj K",
                                      style: GoogleFonts.poppins(
                                        color: Constants.primaryWhite,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Dcotor @ socorp",
                                      style: GoogleFonts.poppins(
                                        color: Constants.primaryWhite,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 210,
                      left: 10,
                      right: 10,
                      child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 90,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/money.svg"),
                                  SizedBox(height: 10),
                                  KText(
                                    text: "Check Appointments",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Constants.darkBlack,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/edit_profile.svg"),
                                  SizedBox(height: 10),
                                  KText(
                                    text: "Edit Profile",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Constants.darkBlack,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/appoint_history.svg"),
                                  SizedBox(height: 10),
                                  KText(
                                    text: "Appoinments History",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Constants.darkBlack,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 10,
                      right: 10,
                      top: 330,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: height * 0.68,
                          width: width,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: "Your Current Appointments",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Constants.darkBlack,
                                      ),
                                    ),
                                    KText(
                                      text: "View All",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Constants.primaryAppColor,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Container(
                                  height: 150,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: Constants.primaryWhite,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black26,width: 0.2),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 60,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    "assets/connection.svg",
                                                    height: 36,
                                                  ),
                                                  SizedBox(width: 20),
                                                  Container(
                                                    height: 60,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: 5),
                                                        KText(
                                                          text: "Rajesh",
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            color: Constants.darkBlack,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        KText(
                                                          text: "Tuesday 24 June",
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.w500,
                                                            color: Constants.lightGrey,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Icon(
                                                Icons.chevron_right_rounded,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(width: 0),
                                                  Container(
                                                    height: 60,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: 5),
                                                        KText(
                                                          text: "From",
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w500,
                                                            color: Constants.primaryAppColor,
                                                          ),
                                                        ),
                                                        SizedBox(height: 2),
                                                        KText(
                                                          text: "Delhi,India",
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            color: Constants.darkBlack,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              KText(
                                                text: "12:10 AM",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Constants.darkBlack,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: "Recent Connections",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Constants.darkBlack,
                                      ),
                                    ),
                                    KText(
                                      text: "View All",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Constants.primaryAppColor,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Container(
                                  height: 60,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: Constants.primaryWhite,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black26,width: 0.2),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/connection.svg",
                                            height: 36,
                                          ),
                                          SizedBox(width: 20),
                                          Container(
                                            height: 60,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 5),
                                                KText(
                                                  text: "Rajesh",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Constants.darkBlack,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                KText(
                                                  text: "Tuesday 24 June",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Constants.lightGrey,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 60,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: Constants.primaryWhite,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black26,width: 0.2),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/connection.svg",
                                            height: 36,
                                          ),
                                          SizedBox(width: 20),
                                          Container(
                                            height: 60,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 5),
                                                KText(
                                                  text: "Rajesh",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Constants.darkBlack,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                KText(
                                                  text: "Tuesday 24 June",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Constants.lightGrey,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 60,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: Constants.primaryWhite,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black26,width: 0.2),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/connection.svg",
                                            height: 36,
                                          ),
                                          SizedBox(width: 20),
                                          Container(
                                            height: 60,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 5),
                                                KText(
                                                  text: "Rajesh",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Constants.darkBlack,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                KText(
                                                  text: "Tuesday 24 June",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Constants.lightGrey,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }return Container();
          },
      )
    );
  }
}
