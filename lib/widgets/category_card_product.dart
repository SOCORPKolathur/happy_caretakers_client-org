import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';

import 'kText.dart';

class CategoryCardProduct extends StatefulWidget {
  const CategoryCardProduct({super.key, required this.name, required this.icon});

  final String name;
  final IconData icon;

  @override
  State<CategoryCardProduct> createState() => _CategoryCardProductState();
}

class _CategoryCardProductState extends State<CategoryCardProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 60,
              decoration: BoxDecoration(
                color: Constants.primaryAppColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  widget.icon,
                  color: Constants.primaryWhite,
                  size: 40,
                ),
              ),
            ),
          ),
          KText(
            text: widget.name,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
