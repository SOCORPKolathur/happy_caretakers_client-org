import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants{

  static Color primaryAppColor = const Color(0xff2663FF);
  static Color secondaryAppColor = const Color(0xffE0E4E9);
  static Color appBackgroundolor = const Color(0xffD9E8F7);
  static Color darkGrey = const Color(0xff38435D);
  static Color semiGrey = const Color(0xff949BA7);
  static Color lightGrey = const Color(0xff737D8F);
  static Color primaryWhite = const Color(0xffFFFFFF);

  static Widget secondaryButton(String title){
    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        color: secondaryAppColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: darkGrey,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

}