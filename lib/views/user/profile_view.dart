// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:happy_caretakers_client/constants.dart';
// import 'package:happy_caretakers_client/views/about_app_view.dart';
// import 'package:happy_caretakers_client/views/choose_role_view.dart';
// import 'package:happy_caretakers_client/views/languages_view.dart';
// import 'package:happy_caretakers_client/views/user/carts_view.dart';
// import 'package:happy_caretakers_client/views/user/orders_view.dart';
// import 'package:happy_caretakers_client/views/user/wish_list_view.dart';
// import 'package:lottie/lottie.dart';
// import 'package:material_dialogs/dialogs.dart';
// import 'package:material_dialogs/widgets/buttons/icon_button.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../models/care_takers_model.dart';
// import '../../widgets/kText.dart';
//
//
// class ProfileView extends StatefulWidget {
//   const ProfileView({super.key});
//
//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }
//
// class _ProfileViewState extends State<ProfileView> {
//
//   TextEditingController _searchcontroller=TextEditingController();
//   DocumentSnapshot? user;
//
//   @override
//   void initState() {
//     getUser();
//     super.initState();
//   }
//
//   getUser() async {
//     var doc = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get();
//     setState(() {
//       user = doc;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     double height = size.height;
//     double width = size.width;
//     return Scaffold(
//       backgroundColor: Constants.appBackgroundolor,
//       body: Container(
//         height: height,
//         width: width,
//         child: Stack(
//           children: [
//             Container(
//               height: height/2.78,
//               width: size.width,
//               decoration: BoxDecoration(
//                 color: Constants.darkBlue,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(height/18.9),
//                   bottomRight: Radius.circular(height/18.9),
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: height/10.8,
//                     backgroundColor: Constants.primaryWhite,
//                     backgroundImage: NetworkImage(
//                       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToih1Zk-973AZLNE6aDwDo2IX49B0Ix_j4pw&usqp=CAU",
//                     ),
//                   ),
//                   SizedBox(height: height/75.6),
//                   KText(
//                     text: user != null ? user!.get("firstName")+" "+user!.get("lastName") : 'User',
//                     style: GoogleFonts.poppins(
//                         fontSize: width/16.363636364,
//                         color: Constants.primaryWhite,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     user != null ? user!.get("phone") : '',
//                     style: GoogleFonts.poppins(
//                         fontSize: width/21.176470588,
//                         color: Constants.primaryWhite,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               top:  height/2.606896552,
//               child: Container(
//                 height: height * 0.65,
//                 width: width,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       CardWidget('Edit Profile',Icons.person,Colors.red),
//                       SizedBox(height: height/50.4),
//                       InkWell(
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (ctx)=> LanguagesView()));
//                         },
//                         child: CardWidget(
//                           'App Languages',
//                           Icons.translate,
//                           Colors.green,
//                         ),
//                       ),
//                       SizedBox(height: height/50.4),
//                       InkWell(
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const WishListView()));
//                         },
//                         child: CardWidget('Your Wishlist',Icons.bookmark,Colors.deepPurple),
//                       ),
//                       SizedBox(height: height/50.4),
//                       InkWell(
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CartView()));
//                         },
//                         child: CardWidget('Your Cart',Icons.shopping_cart,Colors.amber),
//                       ),
//                       SizedBox(height: height/50.4),
//                       InkWell(
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (ctx)=> OrdersView(userDocId: FirebaseAuth.instance.currentUser!.uid)));
//                         },
//                         child: CardWidget('Your Orders',Icons.shopping_basket,Colors.pink),
//                       ),
//                       SizedBox(height: height/50.4),
//                       InkWell(
//                         onTap: (){
//                           showContactSupportPopUp(context);
//                         },
//                         child: CardWidget('Contact Support',Icons.headphones,Colors.lightBlue),
//                       ),
//                       SizedBox(height: height/50.4),
//                       InkWell(
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const AboutAppView()));
//                         },
//                         child: CardWidget('About Happy Caretakers',Icons.info,Colors.blueGrey),
//                       ),
//                       SizedBox(height: height/50.4),
//                       InkWell(
//                         onTap: () async {
//                           Dialogs.materialDialog(
//                               color: Colors.white,
//                               msg: 'Are you want to log out',
//                               title: 'Log Out',
//                               lottieBuilder: Lottie.asset(
//                                 'assets/logout.json',
//                                 fit: BoxFit.contain,
//                               ),
//                               context: context,
//                               actions: [
//                                 IconsButton(
//                                   onPressed: () async {
//                                     await FirebaseAuth.instance.signOut();
//                                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> const ChooseRoleView()));
//                                   },
//                                   text: 'Log Out',
//                                   color: Colors.blue,
//                                   textStyle: TextStyle(color: Colors.white),
//                                   iconColor: Colors.white,
//                                 ),
//                                 IconsButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   text: 'Cancel',
//                                   color: Colors.grey,
//                                   textStyle: TextStyle(color: Colors.white),
//                                   iconColor: Colors.white,
//                                 ),
//                               ]
//                           );
//                         },
//                         child: CardWidget('Log Out',Icons.logout,Colors.red),
//                       ),
//                       SizedBox(height: height/50.4),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   CardWidget(String title, IconData icon,Color color){
//     Size size = MediaQuery.of(context).size;
//     double height = size.height;
//     double width = size.width;
//     return Material(
//       elevation: 2,
//       borderRadius: BorderRadius.circular(10),
//       child: Container(
//         height: height/9.45,
//         width: width*0.9,
//         decoration: BoxDecoration(
//           color: Constants.primaryWhite,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             SizedBox(
//               width: width/1.44,
//               child: KText(
//                 text: title,
//                 style: GoogleFonts.montserrat(
//                     fontWeight: FontWeight.w500,
//                     fontSize: width/18.947368421
//                 ),
//               ),
//             ),
//             Icon(
//               icon,
//               color: color,
//               size: width/10.285714286,
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   showContactSupportPopUp(context) async {
//     Size size = MediaQuery.of(context).size;
//     await showDialog(
//       context: context,
//       builder: (ctx) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Container(
//             height: size.height * 0.4,
//             width: size.width,
//             decoration: BoxDecoration(
//               color: Constants.primaryAppColor,
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black26,
//                   offset: Offset(1, 2),
//                   blurRadius: 3,
//                 ),
//               ],
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(
//                   height: size.height * 0.07,
//                   child: Padding(
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         KText(
//                           text: 'Contact & Support',
//                           style: GoogleFonts.openSans(
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             setState(() {});
//                             Navigator.pop(context);
//                           },
//                           child: const Icon(
//                             Icons.cancel_outlined,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     width: double.infinity,
//                     decoration: const BoxDecoration(
//                       color: Color(0xffF7FAFC),
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(10),
//                         bottomRight: Radius.circular(10),
//                       ),
//                     ),
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         InkWell(
//                           onTap: (){
//                             final Uri emailLaunchUri = Uri(
//                               scheme: 'tel',
//                               path: '+917639033006',
//                             );
//                             launchUrl(emailLaunchUri);
//                           },
//                           child: ListTile(
//                             leading: Icon(
//                               Icons.phone,
//                               color: Constants.primaryAppColor,
//                             ),
//                             title: Text(
//                               "+917639033006",
//                               style: GoogleFonts.poppins(
//                                 color: Constants.lightGrey,
//
//                               ),
//                             ),
//                           ),
//                         ),
//                         InkWell(
//                           onTap: (){
//                             final Uri emailLaunchUri = Uri(
//                               scheme: 'mailto',
//                               path: 'happycaretakers@gmail.com',
//                             );
//                             launchUrl(emailLaunchUri);
//                           },
//                           child: ListTile(
//                             leading: Icon(
//                               Icons.alternate_email,
//                               color: Constants.primaryAppColor,
//                             ),
//                             title: Text(
//                               "happycaretakers@gmail.com",
//                               style: GoogleFonts.poppins(
//                                 color: Constants.lightGrey,
//
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/views/user/history_view.dart';
import 'package:happy_caretakers_client/views/user/wish_list_view.dart';
import 'package:happy_caretakers_client/widgets/kText.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';
import '../about_app_view.dart';
import '../choose_role_view.dart';
import '../languages_view.dart';
import '../login_view.dart';
import 'carts_view.dart';
import 'orders_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  
  int connectionsMade = 0;
  int connectionsLeft = 0;
  String name = "";
  String image = "";
  String phone = "";
  
  @override
  void initState() {
    getUser();
    super.initState();
  }
  
  // getUser() async {
  //   var userDoc = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get();
  //   setState(() {
  //     name = userDoc.get("firstName")+" "+userDoc.get("lastName");
  //   });
  // }

  getUser() async {
    String? docId = await _getId();
    if(FirebaseAuth.instance.currentUser != null){
      var userDoc = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      var userDoc1 = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).collection('Connections').get();
      if(userDoc.exists){
        setState(() {
          name = userDoc.get("firstName")+" "+userDoc.get("lastName");
          phone = userDoc.get("phone");
          connectionsMade = userDoc1.docs.length;
          connectionsLeft = userDoc.get("subscriptionCount");
        });
      }
    } else{
      var tempUserDoc = await FirebaseFirestore.instance.collection('TempUsers').doc(docId).get();
      setState(() {
        name = tempUserDoc.get("name");
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: Container(
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: width,
                child: Stack(
                  children: [
                    Container(
                      height: 140,
                      width: width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage(
                            "assets/back_imgs.png"
                          )
                        )
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // image: DecorationImage(
                          //   fit: BoxFit.fill,
                          //   image: image != "" ? NetworkImage(image) : NetworkImage("https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png")
                          // )
                        ),
                        child: Lottie.asset(
                          "assets/profile.json",
                          height: 180,
                          width: 180,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                name,
                style: GoogleFonts.poppins(
                  color: Constants.darkBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 6),
              phone != "" ? Text(
                phone,
                style: GoogleFonts.poppins(
                  color: Constants.primaryAppColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ) : InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> const LoginView(isCareTaker: false)));
                },
                child: Text(
                  "Log In",
                  style: GoogleFonts.poppins(
                    color: Constants.primaryAppColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          connectionsMade.toString(),
                          style: GoogleFonts.poppins(
                            color: Constants.primaryAppColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          "Connections Made",
                          style: GoogleFonts.poppins(
                            color: Constants.darkBlack,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          connectionsLeft.toString(),
                          style: GoogleFonts.poppins(
                            color: Constants.primaryAppColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          "Connections Left",
                          style: GoogleFonts.poppins(
                            color: Constants.darkBlack,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const HistoryView()));
                      },
                      child: Container(
                        height: 45,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Constants.primaryAppColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff7BBCFC),
                              blurRadius: 5,
                              offset: Offset(-2, 4),
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "History",
                            style: GoogleFonts.openSans(
                                fontSize: size.width/24.176470588,
                                color: const Color(0xffFFFFFF),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {

                      },
                      child: Container(
                        height: 45,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Constants.primaryAppColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff7BBCFC),
                              blurRadius: 5,
                              offset: Offset(-2, 4),
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Upgrade Plan",
                            style: GoogleFonts.openSans(
                                fontSize: size.width/24.176470588,
                                color: const Color(0xffFFFFFF),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              CardWidget('Edit Profile',Icons.person,Colors.red),
                      SizedBox(height: height/50.4),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> LanguagesView()));
                        },
                        child: CardWidget(
                          'App Languages',
                          Icons.translate,
                          Colors.green,
                        ),
                      ),
                      SizedBox(height: height/50.4),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const WishListView()));
                        },
                        child: CardWidget('Your Wishlist',Icons.bookmark,Colors.deepPurple),
                      ),
                      SizedBox(height: height/50.4),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CartView()));
                        },
                        child: CardWidget('Your Cart',Icons.shopping_cart,Colors.amber),
                      ),
                      SizedBox(height: height/50.4),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> OrdersView()));
                        },
                        child: CardWidget('Your Orders',Icons.shopping_basket,Colors.pink),
                      ),
                      SizedBox(height: height/50.4),
                      InkWell(
                        onTap: (){
                          showContactSupportPopUp(context);
                        },
                        child: CardWidget('Contact Support',Icons.headphones,Colors.lightBlue),
                      ),
                      SizedBox(height: height/50.4),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const AboutAppView()));
                        },
                        child: CardWidget('About Happy Caretakers',Icons.info,Colors.blueGrey),
                      ),
                      SizedBox(height: height/50.4),
                      InkWell(
                        onTap: () async {
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
                                    String? devId = await _getId();
                                    await FirebaseFirestore.instance.collection('TempUsers').doc(devId).delete();
                                    await setLanguage();
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
                        child: CardWidget('Log Out',Icons.logout,Colors.red),
                      ),
                      SizedBox(height: height/50.4),
            ],
          ),
        ),
      ),
    );
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

  setLanguage(){
    changeLocale(context, 'en_Us');
  }


  CardWidget(String title, IconData icon,Color color){
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: height/9.45,
        width: width*0.9,
        decoration: BoxDecoration(
          color: Constants.primaryWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: width/1.44,
              child: KText(
                text: title,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: width/18.947368421
                ),
              ),
            ),
            Icon(
              icon,
              color: color,
              size: width/10.285714286,
            )
          ],
        ),
      ),
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
