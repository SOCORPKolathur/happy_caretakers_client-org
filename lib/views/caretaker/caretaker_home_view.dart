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
import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/models/care_takers_model.dart';
import 'package:happy_caretakers_client/views/caretaker/caretaker_appointments_view.dart';
import 'package:happy_caretakers_client/widgets/caretaker_drawer_widget.dart';
import 'package:happy_caretakers_client/widgets/kText.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';
import 'caretaker_edit_profile_view.dart';
import 'caretaker_notifications_view.dart';

class CareTakerHomeView extends StatefulWidget {
  const CareTakerHomeView({super.key, required this.caretaker});

  final CareTakersModel caretaker;

  @override
  State<CareTakerHomeView> createState() => _CareTakerHomeViewState();
}

class _CareTakerHomeViewState extends State<CareTakerHomeView> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int count = 0;
  bool isNotificationEnable = true;

  @override
  void initState() {
    getNotification();
    super.initState();
  }

  getNotification() async {
    var notificationDoc = await FirebaseFirestore.instance.collection('CareTakers').doc(FirebaseAuth.instance.currentUser!.uid).collection("Notifications").get();
    notificationDoc.docs.forEach((element) {
      if (element.get("isViewed") == false) {
        count++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Constants.primaryWhite,
      drawer: CaretakerDrawerWidget(caretaker: widget.caretaker),
      body: Container(
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
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CaretakerNotificationView()));
                        },
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
                            child: Center(
                              child: count == 0
                                  ? const Icon(
                                CupertinoIcons.bell_solid,
                                size: 28,
                                color: Colors.white,
                              )
                                  : Badge(
                                  label: Text(count.toString()),
                                  child: ShakeAnimatedWidget(
                                      enabled: isNotificationEnable,
                                      duration:
                                      const Duration(milliseconds: 900),
                                      shakeAngle: Rotation.deg(z: 40),
                                      curve: Curves.linear,
                                      child: const Icon(
                                        CupertinoIcons.bell_solid,
                                        size: 28,
                                        color: Colors.white,
                                      ))),
                            ),
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
                            color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Constants.primaryWhite,width: 4),
                              image: widget.caretaker.imgUrl != "" ? DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(widget.caretaker.imgUrl),
                              ) : null
                          ),
                          child: Visibility(
                            visible: widget.caretaker.imgUrl == "",
                            child: Lottie.asset(
                              "assets/profile.json",
                              height: 200,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome ${widget.caretaker.name}",
                              style: GoogleFonts.poppins(
                                color: Constants.primaryWhite,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
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
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CaretakerAppointmentsView(title: "Check Appointments")));
                        },
                        child: Column(
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
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CaretakerEditProfileView(careTaker: widget.caretaker)));
                        },
                        child: Column(
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
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CaretakerAppointmentsView(title: "Appointments History")));
                        },
                        child: Column(
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
                        ),
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
                child: FutureBuilder(
                    future: FirebaseFirestore.instance.collection('CareTakers').doc(FirebaseAuth.instance.currentUser!.uid).collection('Connections').get(),
                    builder: (context, snap) {
                      if(snap.hasData){
                        var docs = snap.data!.docs;
                        return Container(
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
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CaretakerAppointmentsView(title: "Current Appointments")));
                                      },
                                      child: KText(
                                        text: "View All",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Constants.primaryAppColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                InkWell(
                                  onTap: (){
                                    //showAppointmentDetailsPopUp(context, docs.last);
                                  },
                                  child: Container(
                                    height: 150,
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Constants.primaryWhite,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black26,width: 0.2),
                                    ),
                                    child: docs.isNotEmpty ?  Padding(
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
                                                    Image.asset(
                                                      "assets/conn.png",
                                                      height: 40,
                                                    ),
                                                    SizedBox(width: 20),
                                                    Container(
                                                      height: 60,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          SizedBox(height: 5),
                                                          KText(
                                                            text: docs.last.get("firstName")+" "+docs.last.get("lastName"),
                                                            style: GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                              color: Constants.darkBlack,
                                                            ),
                                                          ),
                                                          SizedBox(height: 5),
                                                          KText(
                                                            text: docs.last.get("date"),
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
                                                            text: docs.last.get("location"),
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
                                                  text: docs.last.get("time"),
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
                                    ) : Center(
                                      child: Text(
                                          "You are not having any recent Appointments"
                                      ),
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
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CaretakerAppointmentsView(title: "Recent Connections")));
                                      },
                                      child: KText(
                                        text: "View All",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Constants.primaryAppColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),

                                for(int k = 0; k < docs.length; k++)
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          //showAppointmentDetailsPopUp(context,docs[k]);
                                        },
                                        child: Container(
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
                                                  Image.asset(
                                                    "assets/conn.png",
                                                    height: 40,
                                                  ),
                                                  SizedBox(width: 20),
                                                  Container(
                                                    height: 60,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        KText(
                                                          text: docs.last.get("firstName")+" "+docs.last.get("lastName"),
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            color: Constants.darkBlack,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        KText(
                                                          text: docs.last.get("date"),
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
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        );
                      }return Container(
                        height: height * 0.68,
                        width: width,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  showAppointmentDetailsPopUp1(context,DocumentSnapshot data) async {
    Size size = MediaQuery.of(context).size;
    await showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: size.height * 0.5,
            width: size.width,
            decoration: BoxDecoration(
              color: Constants.primaryAppColor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1, 2),
                  blurRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: size.height * 0.07,
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Connection Details',
                          style: GoogleFonts.poppins(
                            color: Constants.primaryWhite,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.cancel_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xffF7FAFC),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.person,
                            color: Constants.primaryAppColor,
                          ),
                          title: Text(
                            data.get("firstName") + " "+data.get("lastName"),
                            style: GoogleFonts.poppins(
                              color: Constants.lightGrey,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            final Uri emailLaunchUri = Uri(
                              scheme: 'tel',
                              path: data.get("phone"),
                            );
                            launchUrl(emailLaunchUri);
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Constants.primaryAppColor,
                            ),
                            title: Text(
                              data.get("phone"),
                              style: GoogleFonts.poppins(
                                color: Constants.lightGrey,
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.calendar_month,
                            color: Constants.primaryAppColor,
                          ),
                          title: Text(
                            data.get("date"),
                            style: GoogleFonts.poppins(
                              color: Constants.lightGrey,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.timelapse,
                            color: Constants.primaryAppColor,
                          ),
                          title: Text(
                            data.get("time"),
                            style: GoogleFonts.poppins(
                              color: Constants.lightGrey,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: Constants.primaryAppColor,
                          ),
                          title: Text(
                            data.get("location"),
                            style: GoogleFonts.poppins(
                              color: Constants.lightGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
