import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../constants.dart';
import '../../widgets/kText.dart';

class CaretakerNotificationView extends StatefulWidget {
  const CaretakerNotificationView({super.key});

  @override
  State<CaretakerNotificationView> createState() => _CaretakerNotificationViewState();
}

class _CaretakerNotificationViewState extends State<CaretakerNotificationView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryAppColor,
        centerTitle: true,
        title: KText(
          text: "Notifications",
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
        stream: FirebaseFirestore.instance
            .collection('CareTakers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("Notifications")
            .orderBy("timestamp",descending: true)
            .snapshots(),
        builder: (ctx, snap) {
          if (snap.hasData) {
            return snap.data!.docs.isEmpty ? Center(
              child: Lottie.asset(
                'assets/no_noti.json',
                fit: BoxFit.contain,
                height: size.height * 0.4,
                width: size.width * 0.7,
              ),
            ) : ListView.builder(
              reverse: false,
              itemCount: snap.data!.docs.length,
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VisibilityDetector(
                    key: Key('my-widget-key $i'),
                    onVisibilityChanged: (VisibilityInfo visibilityInfo){
                      var visiblePercentage = visibilityInfo.visibleFraction * 6;
                      //if(visiblePercentage >= 0.2){
                      if(!snap.data!.docs[i]['isViewed']) {
                        updateNottificationStatus(id:snap.data!.docs[i].id);
                      }
                      //}
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: !snap.data!.docs[i]['isViewed'],
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Constants.primaryAppColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                                        child: Text("New"),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: size.height/433),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snap.data!.docs[i]['date'],
                                  style: GoogleFonts.openSans(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  snap.data!.docs[i]['time'],
                                  style: GoogleFonts.openSans(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height/86.6),
                            Text(
                              snap.data!.docs[i]['subject'],
                              style: GoogleFonts.openSans(
                                color: const Color(0xff000850),
                                fontSize: size.width/22.833333333,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              snap.data!.docs[i]['content'],
                              style: GoogleFonts.openSans(
                                color: const Color(0xff454545),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: size.height/86.6),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }else if(snap.hasError){
            return Center(
              child: Lottie.asset(
                'assets/no_noti.json',
                fit: BoxFit.contain,
                height: size.height * 0.4,
                width: size.width * 0.7,
              ),
            );
          }else if(!snap.hasData){
            return Center(
              child: Lottie.asset(
                'assets/no_noti.json',
                fit: BoxFit.contain,
                height: size.height * 0.4,
                width: size.width * 0.7,
              ),
            );
          }
          return Center(
            child: Lottie.asset(
              'assets/no_noti.json',
              fit: BoxFit.contain,
              height: size.height * 0.4,
              width: size.width * 0.7,
            ),
          );
        },
      ),
    );
  }

  updateNottificationStatus({required String id}) async {
    FirebaseFirestore.instance
        .collection('CareTakers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Notifications").doc(id).update({
      "isViewed" : true
    });
    setState(() {});
  }


}
