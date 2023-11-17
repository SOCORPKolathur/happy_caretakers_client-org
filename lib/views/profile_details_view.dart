import 'package:action_slider/action_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/models/care_takers_model.dart';

import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';

class ProfileDetailsView extends StatefulWidget {
  const ProfileDetailsView({super.key, required this.id});

  final String id;

  @override
  State<ProfileDetailsView> createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends State<ProfileDetailsView> with SingleTickerProviderStateMixin{
  double pi = 3.14;
  bool slidefinish = false;

  late AnimationController? animationController;
  Animation<double>? opacityAnimation;

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
        title: Text(
          "Profile Details",
          style: GoogleFonts.poppins(
            color: Constants.darkGrey,
          ),
        ),
      ),
      body: Padding(
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
                            Text(
                              "${careTaker.firstName} ${careTaker.lastName}",
                              style: GoogleFonts.poppins(
                                  color: Constants.darkGrey,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "${careTaker.position} at ${careTaker.workingAt}",
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
                                      Text(
                                        "Rating",
                                        style: GoogleFonts.poppins(
                                            color: Constants.semiGrey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        (rating/careTaker.rating.length).toString(),
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
                                    Text(
                                      "Experience",
                                      style: GoogleFonts.poppins(
                                          color: Constants.semiGrey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${careTaker.yearsOfExperience} yrs+",
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
                                      Text(
                                        "Work on",
                                        style: GoogleFonts.poppins(
                                            color: Constants.semiGrey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "${careTaker.totalWorks}+",
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
                        Material(
                          elevation: 10,
                          color: Constants.primaryWhite,
                          borderRadius: BorderRadius.circular(15),
                          shadowColor: Colors.black12,
                          child: Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                  color: Constants.primaryWhite,
                                  borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.all(16),
                              child: Icon(
                                Icons.bookmark_border,
                                color: Constants.primaryAppColor,
                                size: 40,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Experience",
                      style: GoogleFonts.poppins(
                          color: Constants.darkGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: size.width,
                      child: Text(
                        careTaker.workExperience,
                        style: GoogleFonts.poppins(
                          color: Constants.lightGrey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(thickness: 2),
                    SizedBox(height: 20),
                    Text(
                      "Contact Details",
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
                                  Text(
                                    "+91 82XXX XXXX",
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
                                  Text(
                                    "shirXXXX@XXX.com",
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
                                  Text(
                                    "Connect to View location",
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
                                        child: Text(
                                          "Contact Details",
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
                                        Text(
                                          "Name :",
                                          style: GoogleFonts.poppins(
                                            color: Constants.darkGrey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "${careTaker.firstName} ${careTaker.lastName}",
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
                                        Text(
                                          "Phone No :",
                                          style: GoogleFonts.poppins(
                                            color: Constants.darkGrey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          careTaker.phone,
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
                                        Text(
                                          "Location :",
                                          style: GoogleFonts.poppins(
                                            color: Constants.darkGrey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          careTaker.address,
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
                                        Text(
                                          "Mail ID :",
                                          style: GoogleFonts.poppins(
                                            color: Constants.darkGrey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          careTaker.email,
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
                      },
                      child: Container(
                        height: 60,
                        width: size.width*0.9,
                        decoration: BoxDecoration(
                          color: Constants.primaryAppColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CircleAvatar(
                              child: Center(
                                child: Transform.rotate(
                                  angle: -0.05,
                                  child: Image.asset(
                                    "assets/fast-forward.png",
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'Connect Now',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  fontSize: 20
                                ),
                              ),
                          ),
                          ],
                        ),
                      ),
                    )

                    // ActionSlider.dual(
                    //   backgroundBorderRadius: BorderRadius.circular(100),
                    //   foregroundBorderRadius: BorderRadius.circular(100),
                    //   width: 330.0,
                    //   backgroundColor: const Color(0xff2663FF),
                    //   toggleColor: Colors.white,
                    //   onTap: (ActionSlidercontroller, value) {
                    //     showModalBottomSheet(
                    //         context: context,
                    //         isScrollControlled: true,
                    //         transitionAnimationController: animationController,
                    //         builder: (builder) {
                    //           return Container(
                    //             height: 490,
                    //             decoration: BoxDecoration(
                    //                 color: Constants.primaryWhite,
                    //                 borderRadius: const BorderRadius.only(
                    //                   topRight: Radius.circular(20),
                    //                   topLeft: Radius.circular(20),
                    //                 )
                    //             ),
                    //             padding: const EdgeInsets.symmetric(horizontal: 15),
                    //             child: Column(
                    //               children: [
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(top: 10),
                    //                   child: Center(
                    //                     child: Text(
                    //                       "Contact Details",
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 20,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 const SizedBox(height: 10),
                    //                 Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       "Name :",
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 18,
                    //                       ),
                    //                     ),
                    //                     const SizedBox(height: 10),
                    //                     Text(
                    //                       "${careTaker.firstName} ${careTaker.lastName}",
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 14,
                    //                       ),
                    //                     ),
                    //                     Divider(thickness: 1,)
                    //                   ],
                    //                 ),
                    //                 const SizedBox(height: 10),
                    //                 Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       "Phone No :",
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 18,
                    //                       ),
                    //                     ),
                    //                     const SizedBox(height: 10),
                    //                     Text(
                    //                       careTaker.phone,
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 14,
                    //                       ),
                    //                     ),
                    //                     Divider(thickness: 1,)
                    //                   ],
                    //                 ),
                    //                 const SizedBox(height: 10),
                    //                 Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       "Location :",
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 18,
                    //                       ),
                    //                     ),
                    //                     const SizedBox(height: 10),
                    //                     Text(
                    //                       careTaker.address,
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 14,
                    //                       ),
                    //                     ),
                    //                     Divider(thickness: 1,)
                    //                   ],
                    //                 ),
                    //                 const SizedBox(height: 10),
                    //                 Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       "Mail ID :",
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 18,
                    //                       ),
                    //                     ),
                    //                     const SizedBox(height: 10),
                    //                     Text(
                    //                       careTaker.email,
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 14,
                    //                       ),
                    //                     ),
                    //                     Divider(thickness: 1,)
                    //                   ],
                    //                 ),
                    //                 const SizedBox(height: 20),
                    //                 Row(
                    //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //                   children: [
                    //                     SecondaryButton(
                    //                         title: 'Cancel',
                    //                         onTap: (){
                    //                           Navigator.pop(context);
                    //                         }
                    //                     ),
                    //                     PrimaryButton(
                    //                         title: 'Call Now',
                    //                         onTap: (){
                    //                           Navigator.pop(context);
                    //                         }
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 const SizedBox(height: 10),
                    //               ],
                    //             ),
                    //           );
                    //         });
                    //   },
                    //   endChild: Text(
                    //     'Connect Now',
                    //     style: GoogleFonts.poppins(
                    //         color: Colors.white, fontWeight: FontWeight.w600),
                    //   ),
                    //   icon: Padding(
                    //     padding: const EdgeInsets.only(right: 2.0),
                    //     child: Transform.rotate(
                    //         angle: -0.05,
                    //         child: Image.asset(
                    //           "assets/fast-forward.png",
                    //           height: 18,
                    //           width: 18,
                    //         )),
                    //   ),
                    //   // startAction: (controller) async {
                    //   //   controller.loading(); //starts loading animation
                    //   //   await Future.delayed(const Duration(seconds: 3));
                    //   //   controller.success(); //starts success animation
                    //   //   await Future.delayed(const Duration(seconds: 1));
                    //   //   controller.reset(); //resets the slider
                    //   // },
                    //   endAction: (controller) async {
                    //     //controller.loading(); //starts loading animation
                    //     // await Future.delayed(const Duration(seconds: 3));
                    //     // controller.success(); //starts success animation
                    //     // await Future.delayed(const Duration(seconds: 1));
                    //
                    //     setState(() {
                    //       slidefinish=true;
                    //     });
                    //     controller.reset(); //resets the slider
                    //   },
                    // ),

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
      ),
    );
  }
}
