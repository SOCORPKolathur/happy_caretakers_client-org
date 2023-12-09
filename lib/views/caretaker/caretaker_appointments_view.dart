import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../widgets/kText.dart';

class CaretakerAppointmentsView extends StatefulWidget {
  const CaretakerAppointmentsView({super.key, required this.title});

  final String title;

  @override
  State<CaretakerAppointmentsView> createState() => _CaretakerAppointmentsViewState();
}

class _CaretakerAppointmentsViewState extends State<CaretakerAppointmentsView> {

  List<String> names = [
    "Rajesh",
    "Ramesh"
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: Constants.appBackgroundolor,
      appBar: AppBar(
        backgroundColor: Constants.primaryAppColor,
        centerTitle: true,
        title: KText(
          text: widget.title,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back,color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('CareTakers').doc(FirebaseAuth.instance.currentUser!.uid).collection('Connections').orderBy("timestamp", descending: true).snapshots(),
        builder: (context, snap) {
          if(snap.hasData){
            var docss = snap.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: docss.docs.isEmpty
                  ? Container(
                child: Center(
                  child: Lottie.asset("assets/no_noti.json"),
                ),
              )
                  : ListView.builder(
                itemCount: docss.docs.length,
                itemBuilder: (ctx, i){
                  var data = docss.docs[i];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: (){
                        showAppointmentDetailsPopUp(context,data);
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
                                SizedBox(width: 10),
                                Container(
                                  height: 60,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      KText(
                                        text: data.get("firstName") + " "+data.get("lastName"),
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Constants.darkBlack,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      KText(
                                        text: data.get("date"),
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
                  );
                },
              ),
            );
          }return Container();
        }
      ),
    );
  }

  showAppointmentDetailsPopUp(context,DocumentSnapshot data) async {
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
