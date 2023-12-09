import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/models/care_takers_model.dart';
import 'package:readmore/readmore.dart';
import 'custom_paint_profile_card.dart';
import 'kText.dart';

class CustomProfileCard extends StatefulWidget {
  const CustomProfileCard({super.key, required this.onTap, required this.careTaker,required this.lat,required this.lon});

  final Function onTap;
  final CareTakersModel careTaker;

  final double lat;
  final double lon;

  @override
  State<CustomProfileCard> createState() => _CustomProfileCardState();
}

class _CustomProfileCardState extends State<CustomProfileCard> {

  double km = 0;


  getDistance() {
    print(widget.lon);
    print(widget.lat);

    print(widget.careTaker.location.lat!);
    print(widget.careTaker.location.lng!);

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((widget.careTaker.location.lat! - widget.lat) * p)/2 +
        c(widget.lat * p) * c(widget.careTaker.location.lat! * p) *
            (1 - c((widget.careTaker.location.lng! - widget.lon) * p))/2;
    return ((12742 * asin(sqrt(a)))).toInt();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          getDistance() < 10 ? "---  ${widget.careTaker.category} Near you ---" : "---  ${widget.careTaker.category} under ${getDistance().toString()} KM ---",
          style: GoogleFonts.poppins(
            color: Constants.lightGrey,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 5),
        Stack(
          children: [
            CustomPaint(
              painter: CustomPaintProfileCard(),
              size: Size(size.width, 220),
            ),
            SizedBox(
              height: 220,
              width: size.width,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: size.width * 0.62,
                        decoration: const BoxDecoration(
                          //color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Constants.lightGrey,
                              backgroundImage: NetworkImage(widget.careTaker.imgUrl),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KText(
                                  text: "${widget.careTaker.firstName} ${widget.careTaker.lastName}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w600,
                                    color: Constants.darkGrey,
                                  ),
                                ),
                                KText(
                                  text: widget.careTaker.position,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                    color: Constants.darkGrey,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 10,
                        width: size.width,
                        decoration: BoxDecoration(
                          //color: Constants.primaryWhite,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 30,right: 120),
                        child: Center(
                            child: Divider(
                              color: Constants.darkGrey,
                              thickness: 1.5,
                            )
                        ),
                      ),
                      Container(
                        height: 150,
                        width: size.width,
                        decoration: BoxDecoration(
                            //color: Constants.primaryWhite,
                            borderRadius: const BorderRadius.only(
                              //topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            // boxShadow: const [
                            //   BoxShadow(
                            //       color: Colors.black26,
                            //       offset: Offset(0, 2),
                            //       blurRadius: 2
                            //   )
                            // ]
                        ),
                        child: Column(
                          children: [
                            Expanded(
                                child: Container(
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      //color: Constants.primaryWhite,
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                      )
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: ReadMoreText(
                                    widget.careTaker.about,
                                    style: GoogleFonts.poppins(
                                      color: Constants.semiGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    trimLines: 4,
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Read More',
                                    trimExpandedText: 'Show less',
                                    moreStyle: GoogleFonts.poppins(
                                        decoration: TextDecoration.underline,
                                        color: Constants.primaryAppColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                            ),
                            Container(
                              height: 55,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Constants.primaryAppColor,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Constants.primaryWhite,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.location_on,color: Constants.primaryAppColor,),
                                          SizedBox(width: 5),
                                          KText(
                                            text:widget.careTaker.city,
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: Constants.semiGrey,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Constants.primaryWhite,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.school,color: Constants.primaryAppColor,),
                                          SizedBox(width: 5),
                                          KText(
                                            text: "${widget.careTaker.yearsOfExperience} years",
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: Constants.semiGrey,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Constants.primaryWhite,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.person,color: Constants.primaryAppColor,),
                                          SizedBox(width: 5),
                                          KText(
                                            text: widget.careTaker.age.toString() +" years old",
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: Constants.semiGrey,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 15,
                    right: -1,
                    child: InkWell(
                      onTap: (){
                        widget.onTap();
                      },
                      child: Container(
                        height: 38,
                        width: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xff2B2B2B),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            KText(
                              text: 'View',
                              style: GoogleFonts.poppins(
                                color: Constants.primaryWhite,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              CupertinoIcons.arrow_up_right_circle,
                              color: Constants.primaryWhite,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
