import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forked_slider_button/forked_slider_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/models/care_takers_model.dart';
import 'package:happy_caretakers_client/views/login_view.dart';
import 'package:happy_caretakers_client/views/user/chat_view.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../../widgets/kText.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';

class ProfileDetailsView extends StatefulWidget {
  const ProfileDetailsView({super.key, required this.id});

  final String id;

  @override
  State<ProfileDetailsView> createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends State<ProfileDetailsView> with TickerProviderStateMixin{
  double pi = 3.14;
  bool slidefinish = false;

  late AnimationController? animationController;
  Animation<double>? opacityAnimation;

  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 300), vsync: this, value: 1.0);


  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1),reverseDuration: const Duration(seconds: 1),animationBehavior: AnimationBehavior.preserve);
    opacityAnimation = CurvedAnimation(
        parent: Tween<double>(begin: 1, end: 0).animate(animationController!),
        curve: Curves.easeInOutExpo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.appBackgroundolor,
      appBar: AppBar(
        backgroundColor: Constants.appBackgroundolor,
        title: KText(
          text: "Profile Details",
          style: GoogleFonts.poppins(
            color: Constants.darkGrey,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (ctx, userSnap){
          if(userSnap.hasData){
            return Padding(
              padding: const EdgeInsets.all(13.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: FutureBuilder(
                  future: FirebaseFirestore.instance.collection('CareTakers').doc(widget.id).get(),
                  builder: (ctx,snap){
                    if(snap.hasData){
                      CareTakersModel careTaker = CareTakersModel.fromJson(snap.data!.data() as Map<String,dynamic>);
                      double rating = 0.0;
                      careTaker.rating.forEach((element) {
                        rating += element.rating!;
                      });
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Constants.primaryAppColor,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          careTaker.imgUrl
                                      )
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: "${careTaker.firstName} ${careTaker.lastName}",
                                    style: GoogleFonts.poppins(
                                        color: Constants.darkGrey,
                                        fontSize: 23,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  KText(
                                    text: "${careTaker.position} at ${careTaker.workingAt}",
                                    style: GoogleFonts.poppins(
                                        color: Constants.darkGrey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Material(
                                elevation: 10,
                                color: Constants.primaryWhite,
                                borderRadius: BorderRadius.circular(15),
                                shadowColor: Colors.black12,
                                child: Container(
                                  height: 65,
                                  width: 260,
                                  decoration: BoxDecoration(
                                      color: Constants.primaryWhite,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            KText(
                                              text: "Rating",
                                              style: GoogleFonts.poppins(
                                                  color: Constants.semiGrey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            KText(
                                              text: (rating/careTaker.rating.length).toString(),
                                              style: GoogleFonts.poppins(
                                                color: Constants.darkGrey,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 12, bottom: 12),
                                        child: VerticalDivider(thickness: 1),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          KText(
                                            text: "Experience",
                                            style: GoogleFonts.poppins(
                                                color: Constants.semiGrey,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          KText(
                                            text: "${careTaker.yearsOfExperience} yrs+",
                                            style: GoogleFonts.poppins(
                                                color: Constants.darkGrey,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 12, bottom: 12),
                                        child: VerticalDivider(thickness: 1),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            KText(
                                              text: "Work on",
                                              style: GoogleFonts.poppins(
                                                  color: Constants.semiGrey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            KText(
                                              text: "${careTaker.totalWorks}+",
                                              style: GoogleFonts.poppins(
                                                  color: Constants.darkGrey,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              StreamBuilder(
                                stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Wishlist').doc(widget.id).snapshots(),
                                builder: (context, wishSnap) {
                                  if(wishSnap.hasData){
                                    bool isWishListed = wishSnap.data!.exists;
                                    return InkWell(
                                      onTap: (){
                                        updateWishList(careTaker,isWishListed);
                                        _controller
                                            .reverse()
                                            .then((value) => _controller.forward());
                                      },
                                      child: Material(
                                        elevation: 10,
                                        color: Constants.primaryWhite,
                                        borderRadius: BorderRadius.circular(15),
                                        shadowColor: Colors.black12,
                                        child: Container(
                                          height: 65,
                                          width: 65,
                                          decoration: BoxDecoration(
                                            color: Constants.primaryWhite,
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Center(
                                            child: ScaleTransition(
                                              scale: Tween(begin: 0.2, end: 1.0).animate(
                                                  CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
                                              child: Icon(
                                                isWishListed ? Icons.bookmark : Icons.bookmark_border,
                                                color: Constants.primaryAppColor,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                }
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          KText(
                            text: "Experience",
                            style: GoogleFonts.poppins(
                                color: Constants.darkGrey,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: size.width,
                            child: KText(
                              text: careTaker.workExperience,
                              style: GoogleFonts.poppins(
                                color: Constants.lightGrey,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Divider(thickness: 2),
                          SizedBox(height: 20),
                          KText(
                            text: "Contact Details",
                            style: GoogleFonts.poppins(
                              color: Constants.darkGrey,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Material(
                                  elevation: 10,
                                  color: Constants.primaryWhite,
                                  borderRadius: BorderRadius.circular(15),
                                  shadowColor: Colors.black12,
                                  child: Container(
                                    height: 50,
                                    width: size.width * 0.9,
                                    decoration: BoxDecoration(
                                        color: Constants.primaryWhite,
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Icon(
                                            Icons.phone,
                                            color: Constants.primaryAppColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        KText(
                                          text: "+91 ${maskPhone(careTaker.phone)}",
                                          style: GoogleFonts.poppins(
                                              color: Constants.lightGrey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Material(
                                  elevation: 10,
                                  color: Constants.primaryWhite,
                                  borderRadius: BorderRadius.circular(15),
                                  shadowColor: Colors.black12,
                                  child: Container(
                                    height: 50,
                                    width: size.width * 0.9,
                                    decoration: BoxDecoration(
                                        color: Constants.primaryWhite,
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Icon(
                                            Icons.email_outlined,
                                            color: Constants.primaryAppColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        KText(
                                          text: maskEmail(careTaker.email),
                                          style: GoogleFonts.poppins(
                                              color: Constants.lightGrey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Material(
                                  elevation: 10,
                                  color: Constants.primaryWhite,
                                  borderRadius: BorderRadius.circular(15),
                                  shadowColor: Colors.black12,
                                  child: Container(
                                    height: 50,
                                    width: size.width * 0.9,
                                    decoration: BoxDecoration(
                                        color: Constants.primaryWhite,
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Icon(
                                            Icons.location_pin,
                                            color: Constants.primaryAppColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        KText(
                                          text: "Connect to View location",
                                          style: GoogleFonts.poppins(
                                              color: Constants.lightGrey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: (){
                              if(Constants.checkUserLoginStatus()){
                                if(userSnap.data!.get("subscriptionCount") > 0){
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      transitionAnimationController: animationController,
                                      builder: (builder) {
                                        return Container(
                                          height: 490,
                                          decoration: BoxDecoration(
                                              color: Constants.primaryWhite,
                                              borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20),
                                              )
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 10),
                                                child: Center(
                                                  child: KText(
                                                    text: "Contact Details",
                                                    style: GoogleFonts.poppins(
                                                      color: Constants.darkGrey,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  KText(
                                                    text: "Name :",
                                                    style: GoogleFonts.poppins(
                                                      color: Constants.darkGrey,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  KText(
                                                    text: "${careTaker.firstName} ${careTaker.lastName}",
                                                    style: GoogleFonts.poppins(
                                                      color: Constants.darkGrey,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Divider(thickness: 1,)
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  KText(
                                                    text: "Phone No :",
                                                    style: GoogleFonts.poppins(
                                                      color: Constants.darkGrey,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  KText(
                                                    text: careTaker.phone,
                                                    style: GoogleFonts.poppins(
                                                      color: Constants.darkGrey,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Divider(thickness: 1,)
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  KText(
                                                    text: "Location :",
                                                    style: GoogleFonts.poppins(
                                                      color: Constants.darkGrey,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  KText(
                                                    text: careTaker.address,
                                                    style: GoogleFonts.poppins(
                                                      color: Constants.darkGrey,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Divider(thickness: 1,)
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  KText(
                                                    text: "Mail ID :",
                                                    style: GoogleFonts.poppins(
                                                      color: Constants.darkGrey,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  KText(
                                                    text: careTaker.email,
                                                    style: GoogleFonts.poppins(
                                                      color: Constants.darkGrey,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Divider(thickness: 1,)
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  SecondaryButton(
                                                      title: 'Cancel',
                                                      onTap: (){
                                                        Navigator.pop(context);
                                                      }
                                                  ),
                                                  PrimaryButton(
                                                      title: 'Call Now',
                                                      onTap: (){
                                                        FirebaseFirestore.instance.collection('Users').doc(userSnap.data!.id).update({
                                                          "subscriptionCount" : FieldValue.increment(-1),
                                                        });
                                                        Navigator.pop(context);
                                                      }
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        );
                                      });
                                }else{
                                  showSubscribePopUp();
                                }
                              }else{
                                showLoginPopUp();
                              }
                            },
                            child: SliderButton(
                              action: () async {
                                if(Constants.checkUserLoginStatus()){
                                  if(userSnap.data!.get("subscriptionCount") > 0){
                                    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Chats').doc(careTaker.id).set({
                                      "timestamp": FieldValue.serverTimestamp(),
                                      "sender": "${careTaker.firstName} ${careTaker.lastName}",
                                      "senderPhone": "${careTaker.phone}",
                                      "senderImage": careTaker.imgUrl,
                                      "senderMail": careTaker.email,
                                      "senderAddress": careTaker.address,
                                      "senderId" : userSnap.data!.id,
                                      "senderToken" : careTaker.fcmToken,
                                    });
                                    var msgDoc = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Chats').doc(careTaker.id).collection('Messages').get();
                                    if(msgDoc.docs.isEmpty){
                                      FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Chats').doc(careTaker.id).collection('Messages').doc().set(
                                          {
                                            "message": "Welcome",
                                            "type": "text",
                                            "time": FieldValue.serverTimestamp(),
                                            "timestamp" : DateTime.now().millisecondsSinceEpoch,
                                            "submittime":"${DateFormat('hh:mm a').format(DateTime.now())}",
                                            "sender": "Happy Caretakers",
                                            "submitdate":"${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                                          }
                                      );
                                    }

                                    // FirebaseFirestore.instance.collection('CareTakers').doc(careTaker.id).collection('Chats').doc(FirebaseAuth.instance.currentUser!.uid).set({
                                    //   "timestamp": FieldValue.serverTimestamp(),
                                    //   "sender": "${userSnap.data!.get("firstName")} ${userSnap.data!.get("lastName")}",
                                    //   "senderPhone": "${userSnap.data!.get("phone")}",
                                    //   "senderImage": "",
                                    //   "senderId" : userSnap.data!.id,
                                    // });
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        transitionAnimationController: animationController,
                                        builder: (builder) {
                                          return Container(
                                            height: 490,
                                            decoration: BoxDecoration(
                                                color: Constants.primaryWhite,
                                                borderRadius: const BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  topLeft: Radius.circular(20),
                                                )
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 10),
                                                  child: Center(
                                                    child: KText(
                                                      text: "Contact Details",
                                                      style: GoogleFonts.poppins(
                                                        color: Constants.darkGrey,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    KText(
                                                      text: "Name :",
                                                      style: GoogleFonts.poppins(
                                                        color: Constants.darkGrey,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    KText(
                                                      text: "${careTaker.firstName} ${careTaker.lastName}",
                                                      style: GoogleFonts.poppins(
                                                        color: Constants.darkGrey,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Divider(thickness: 1,)
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    KText(
                                                      text: "Phone No :",
                                                      style: GoogleFonts.poppins(
                                                        color: Constants.darkGrey,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    KText(
                                                      text: careTaker.phone,
                                                      style: GoogleFonts.poppins(
                                                        color: Constants.darkGrey,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Divider(thickness: 1,)
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    KText(
                                                      text: "Location :",
                                                      style: GoogleFonts.poppins(
                                                        color: Constants.darkGrey,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    KText(
                                                      text: careTaker.address,
                                                      style: GoogleFonts.poppins(
                                                        color: Constants.darkGrey,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Divider(thickness: 1,)
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    KText(
                                                      text: "Mail ID :",
                                                      style: GoogleFonts.poppins(
                                                        color: Constants.darkGrey,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    KText(
                                                      text: careTaker.email,
                                                      style: GoogleFonts.poppins(
                                                        color: Constants.darkGrey,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Divider(thickness: 1,)
                                                  ],
                                                ),
                                                const SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    SecondaryButton(
                                                        title: 'Call Now',
                                                        onTap: (){
                                                          FirebaseFirestore.instance.collection('Users').doc(userSnap.data!.id).update({
                                                            "subscriptionCount" : FieldValue.increment(-1),
                                                          });
                                                          Navigator.pop(context);
                                                          final Uri emailLaunchUri = Uri(
                                                            scheme: 'tel',
                                                            path: careTaker.phone,
                                                          );
                                                          launchUrl(emailLaunchUri);
                                                        }
                                                    ),
                                                    PrimaryButton(
                                                        title: 'Message',
                                                        onTap: () async{
                                                          var data = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Chats').doc(careTaker.id).get();
                                                          FirebaseFirestore.instance.collection('Users').doc(userSnap.data!.id).update({
                                                            "subscriptionCount" : FieldValue.increment(-1),
                                                          });
                                                          Navigator.pop(context);
                                                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> ChatView(data: data)));
                                                        }
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                              ],
                                            ),
                                          );
                                        });
                                  }else{
                                    showSubscribePopUp();
                                  }
                                }else{
                                  showLoginPopUp();
                                }
                              },
                              label: Text(
                                'Connect Now',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20
                                ),
                              ),
                              dismissible: false,
                              icon: Center(
                                child: Transform.rotate(
                                  angle: -0.05,
                                  child: Image.asset(
                                    "assets/fast-forward.png",
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                              ),
                              height: 50,
                              width: size.width*0.9,
                              radius: 30,
                              buttonSize: 40,
                              buttonColor: Constants.primaryWhite,
                              backgroundColor: Constants.primaryAppColor,
                              highlightedColor: Colors.white,
                              baseColor: Constants.primaryAppColor,
                            ),
                          ),
                        ],
                      );
                    }return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }

  updateWishList(CareTakersModel careTaker, bool isWishListed){
    setState(() {
      if(isWishListed){
        FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Wishlist').doc(widget.id).delete();
      }else{
        var json = careTaker.toJson();
        FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Wishlist').doc(widget.id).set(
            json
        );
      }
    });
  }

  maskPhone(String phone){
    String maskPhone = "";
    if(phone != ""){
      for(int i = 0; i < 10; i++){
        if(i < 2){
          maskPhone += phone[i];
        }else{
          maskPhone += "X";
        }
      }
    }
    return maskPhone;
  }

  maskEmail(String email){
    String maskedEmail = "";
    if(email != ""){
      for(int i = 0; i < 10; i++){
        if(i < 2){
          maskedEmail += email[i];
        }else if(i == 5){
          maskedEmail += "@";
        }else if(i > 8){
          maskedEmail += ".com";
        } else{
          maskedEmail += "X";
        }
      }
    }
    return maskedEmail;
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

  showSubscribePopUp(){
    return Dialogs.materialDialog(
        color: Colors.white,
        msg: 'You are not having active subscriptions.Kindly subscribe to continue',
        msgStyle: GoogleFonts.poppins(

        ),
        msgAlign: TextAlign.center,
        title: 'Subscribe Now',
        lottieBuilder: Lottie.asset(
          'assets/logout.json',
          fit: BoxFit.contain,
        ),
        context: context,
        actions: [
          IconsButton(
            onPressed: () async {
              FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).update({
                "subscriptionCount" : 2,
              });
              Navigator.pop(context);
            },
            text: 'Subscribe Now',
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
