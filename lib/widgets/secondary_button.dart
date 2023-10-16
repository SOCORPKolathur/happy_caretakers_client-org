import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';

class SecondaryButton extends StatefulWidget {
  const SecondaryButton({super.key, required this.title, required this.onTap});

  final String title;
  final Function onTap;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        widget.onTap();
      },
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: Constants.secondaryAppColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: GoogleFonts.poppins(
              color: Constants.darkGrey,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
