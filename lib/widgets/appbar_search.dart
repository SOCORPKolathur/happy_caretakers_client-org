import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class AppBarSearchWidget extends StatefulWidget {
  const AppBarSearchWidget({super.key});

  @override
  State<AppBarSearchWidget> createState() => _AppBarSearchWidgetState();
}

class _AppBarSearchWidgetState extends State<AppBarSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Constants.primaryWhite,
      ),
      child: Center(
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal: 5),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(
                  Icons.search,
                  color: Constants.lightGrey,
              ),
              onPressed: () {},
            ),
            hintText: 'Search any type professionals',
            hintStyle: GoogleFonts.poppins(
              color: Constants.lightGrey,
              fontSize: 14,
            ),
            labelStyle: GoogleFonts.poppins(
              color: Constants.lightGrey,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
