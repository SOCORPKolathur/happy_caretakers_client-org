// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:happy_caretakers_client/constants.dart';
// import 'package:happy_caretakers_client/views/about_app_view.dart';
// import 'package:happy_caretakers_client/views/caretaker/caretaker_carts_view.dart';
// import 'package:happy_caretakers_client/views/caretaker/caretaker_edit_profile_view.dart';
// import 'package:happy_caretakers_client/views/caretaker/caretaker_orders_view.dart';
// import 'package:happy_caretakers_client/views/choose_role_view.dart';
// import 'package:happy_caretakers_client/views/languages_view.dart';
// import 'package:lottie/lottie.dart';
// import 'package:material_dialogs/dialogs.dart';
// import 'package:material_dialogs/widgets/buttons/icon_button.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../models/care_takers_model.dart';
// import '../../widgets/kText.dart';
//
//
// class CareTakerProfileView extends StatefulWidget {
//   const CareTakerProfileView({super.key});
//
//   @override
//   State<CareTakerProfileView> createState() => _CareTakerProfileViewState();
// }
//
// class _CareTakerProfileViewState extends State<CareTakerProfileView> {
//
//   TextEditingController _searchcontroller=TextEditingController();
//
//   CareTakersModel? careTaker;
//
//   @override
//   void initState() {
//     getUser();
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
//                   careTaker != null ? CircleAvatar(
//                     radius: height/10.8,
//                     backgroundColor: Constants.primaryWhite,
//                     backgroundImage: NetworkImage(careTaker!.imgUrl),
//                   ) : CircleAvatar(radius: height/10.8),
//                   SizedBox(height: height/75.6),
//                   KText(
//                     text: careTaker!=null? "${careTaker!.firstName} ${careTaker!.lastName}" : "Guest",
//                     style: GoogleFonts.poppins(
//                         fontSize: width/16.363636364,
//                         color: Constants.primaryWhite,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     careTaker!=null? careTaker!.phone : "",
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
//                       InkWell(
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CaretakerEditProfileView(careTaker: careTaker!)));
//                         },
//                         child: CardWidget('Edit Profile',Icons.person,Colors.red),
//                       ),
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
//                           Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const CaretakerCartView()));
//                         },
//                         child: CardWidget('Your Cart',Icons.shopping_cart,Colors.amber),
//                       ),
//                       SizedBox(height: height/50.4),
//                       InkWell(
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CaretakerOrdersView(userDocId: FirebaseAuth.instance.currentUser!.uid)));
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
//                           Navigator.push(context, MaterialPageRoute(builder: (ctx)=> AboutAppView()));
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
//
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/views/user/wish_list_view.dart';
import 'package:happy_caretakers_client/widgets/kText.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';
import '../../models/care_takers_model.dart';
import '../about_app_view.dart';
import '../choose_role_view.dart';
import '../languages_view.dart';
import 'caretaker_appointments_view.dart';
import 'caretaker_carts_view.dart';
import 'caretaker_edit_profile_view.dart';
import 'caretaker_orders_view.dart';

class CareTakerProfileView extends StatefulWidget {
  const CareTakerProfileView({super.key, required this.caretaker});

  final CareTakersModel caretaker;

  @override
  State<CareTakerProfileView> createState() => _CareTakerProfileViewState();
}

class _CareTakerProfileViewState extends State<CareTakerProfileView> {

  //CareTakersModel? careTaker;
  int connectionMadeCount = 0;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    //var doc = await FirebaseFirestore.instance.collection('CareTakers').doc(FirebaseAuth.instance.currentUser!.uid).get();
    var doc1 = await FirebaseFirestore.instance.collection('CareTakers').doc(FirebaseAuth.instance.currentUser!.uid).collection('Connections').get();
    setState(() {
      //careTaker = CareTakersModel.fromJson(doc.data() as Map<String, dynamic>);
      connectionMadeCount = doc1.docs.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: Constants.primaryWhite,
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
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(widget.caretaker.imgUrl),
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.caretaker.firstName +" "+widget.caretaker.lastName,
                style: GoogleFonts.poppins(
                  color: Constants.darkBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "+91 "+widget.caretaker.phone,
                style: GoogleFonts.poppins(
                  color: Constants.primaryAppColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.4,
                      child: Column(
                        children: [
                          Text(
                            connectionMadeCount.toString(),
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
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.4,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              widget.caretaker.rating.length.toDouble().toString(),
                              style: GoogleFonts.poppins(
                                color: Constants.primaryAppColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "Rating",
                              style: GoogleFonts.poppins(
                                color: Constants.darkBlack,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CaretakerAppointmentsView(title: "History")));
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
                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CaretakerEditProfileView(careTaker: widget.caretaker)));
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
                            "Edit Profile",
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
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const CaretakerCartView()));
                        },
                        child: CardWidget('Your Cart',Icons.shopping_cart,Colors.amber),
                      ),
                      SizedBox(height: height/50.4),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CaretakerOrdersView(userDocId: FirebaseAuth.instance.currentUser!.uid)));
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
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> AboutAppView()));
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
