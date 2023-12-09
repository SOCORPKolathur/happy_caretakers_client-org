import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/widgets/kText.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/care_takers_model.dart';
import '../views/about_app_view.dart';
import '../views/caretaker/caretaker_edit_profile_view.dart';
import '../views/choose_role_view.dart';
import '../views/languages_view.dart';

class CaretakerDrawerWidget extends StatefulWidget {
  const CaretakerDrawerWidget({super.key, required this.caretaker});

  final CareTakersModel caretaker;

  @override
  State<CaretakerDrawerWidget> createState() => _CaretakerDrawerWidgetState();
}

class _CaretakerDrawerWidgetState extends State<CaretakerDrawerWidget> {

  CareTakersModel? careTaker;
  DocumentSnapshot? data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Constants.primaryAppColor,
            ), //BoxDecoration
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                data != null ? CircleAvatar(
                  radius: 40,
                  backgroundColor: Constants.primaryWhite,
                  backgroundImage: NetworkImage(widget.caretaker.imgUrl),
                ) : CircleAvatar(radius: 40),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: KText(
                    text: widget.caretaker.firstName + " "+ widget.caretaker.lastName,
                    style: GoogleFonts.poppins(
                      color: Constants.primaryWhite,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ), //UserAccountDrawerHeader
          ), //DrawerHeader
          buildMenuTile(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CaretakerEditProfileView(careTaker: careTaker!)));
            },
            title: "Edit Profile",
            leading: Icons.person,
          ),
          buildMenuTile(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=> LanguagesView()));
            },
            title: "App Languages",
            leading: Icons.translate,
          ),
          buildMenuTile(
            onPressed: (){},
            title: "Your Cart",
            leading: Icons.shopping_cart,
          ),
          buildMenuTile(
            onPressed: (){},
            title: "Your Orders",
            leading: Icons.shopping_basket,
          ),
          buildMenuTile(
            onPressed: (){
              showContactSupportPopUp(context);
            },
            title: "Contact Support",
            leading: Icons.headphones,
          ),
          buildMenuTile(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=> AboutAppView()));
            },
            title: "About Happy Caretakers",
            leading: Icons.info,
          ),
          buildMenuTile(
            onPressed: (){
              Dialogs.materialDialog(
                  color: Colors.white,
                  msg: 'Are you want to log out',
                  title: 'Log Out',
                  lottieBuilder: Lottie.asset(
                    'assets/logout.json',
                    fit: BoxFit.contain,
                  ),
                  context: context,
                  actions: [
                    IconsButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> const ChooseRoleView()));
                      },
                      text: 'Log Out',
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
            },
            title: "Log Out",
            leading: Icons.logout,
          ),
        ],
      ),
    );
  }

  Widget buildMenuTile({required String title,required IconData leading,required Function onPressed}) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Icon(
            leading,
            color: Constants.primaryAppColor,
          ),
          onTap: () {
            onPressed();
          },
        ),
      ],
    );
  }


  showContactSupportPopUp(context) async {
    Size size = MediaQuery.of(context).size;
    await showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: size.height * 0.4,
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
                          text: 'Contact & Support',
                          style: GoogleFonts.openSans(
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
                        InkWell(
                          onTap: (){
                            final Uri emailLaunchUri = Uri(
                              scheme: 'tel',
                              path: '+917639033006',
                            );
                            launchUrl(emailLaunchUri);
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Constants.primaryAppColor,
                            ),
                            title: Text(
                              "+917639033006",
                              style: GoogleFonts.poppins(
                                color: Constants.lightGrey,

                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: 'happycaretakers@gmail.com',
                            );
                            launchUrl(emailLaunchUri);
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.alternate_email,
                              color: Constants.primaryAppColor,
                            ),
                            title: Text(
                              "happycaretakers@gmail.com",
                              style: GoogleFonts.poppins(
                                color: Constants.lightGrey,

                              ),
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
