import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';

class ProfileDetailsView extends StatefulWidget {
  const ProfileDetailsView({super.key});

  @override
  State<ProfileDetailsView> createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends State<ProfileDetailsView> {

  double pi = 3.14;
  bool slidefinish = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.appBackgroundolor,
      appBar: AppBar(
        backgroundColor: Constants.appBackgroundolor,
        title: Text(
          "Profie Details",
          style: GoogleFonts.poppins(
            color: Constants.darkGrey,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Constants.primaryAppColor,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTSAvhi0UxIvUoeY1ZBoYaV4q7adi8eK8Urg&usqp=CAU"
                          )
                        ),
                        borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Shirley Igimo",
                        style: GoogleFonts.poppins(
                            color: Constants.darkGrey,
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Assistant Nurse at Lux Hospital",
                        style: GoogleFonts.poppins(
                            color: Constants.darkGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
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
                      width: 270,
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
                                  "4.8",
                                  style: GoogleFonts.poppins(
                                      color: Constants.darkGrey,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700),
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
                                "8 yrs+",
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
                                  "120+",
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
                        )
                    ),
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
                  "Work experience looks good in your application for Medicine because it demonstrates that you have explored what a medical career is really like.",
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
                    fontWeight: FontWeight.w600
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
              SizedBox(height: 20),
              // ActionSlider.dual(
              //   backgroundBorderRadius: BorderRadius.circular(100),
              //   foregroundBorderRadius: BorderRadius.circular(100),
              //   width: 330.0,
              //   backgroundColor: const Color(0xff2663FF),
              //   toggleColor: Colors.white,
              //   startChild: const Text('Start'),
              //   onTap: (ActionSlidercontroller, value) {
              //
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
              //   startAction: (controller) async {
              //     controller.loading(); //starts loading animation
              //     await Future.delayed(const Duration(seconds: 3));
              //     controller.success(); //starts success animation
              //     await Future.delayed(const Duration(seconds: 1));
              //     controller.reset(); //resets the slider
              //   },
              //   endAction: (controller) async {
              //     //controller.loading(); //starts loading animation
              //     await Future.delayed(const Duration(seconds: 3));
              //     controller.success(); //starts success animation
              //     await Future.delayed(const Duration(seconds: 1));
              //     setState(() {
              //       slidefinish=true;
              //     });
              //     controller.reset(); //resets the slider
              //   },
              // ),
            ],
          ),
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          setState(() {
            slidefinish = false;
          });
        },
        child: Material(
          elevation: 25,
          shadowColor: Colors.black12,
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: slidefinish == true ? 600 : 0,
            width: 360,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
          ),
        ),
      ),
    );
  }
}
