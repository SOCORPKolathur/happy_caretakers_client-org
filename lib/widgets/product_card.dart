import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.title, required this.price, required this.imgUrl});

  final String imgUrl;
  final String title;
  final double price;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: 156,
          child: Stack(
            children: [
              Positioned(
                top: 7,
                right: 0,
                child: Container(
                  height: 190,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Constants.primaryWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 105,left: 10,right: 10,bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 20,
                          width: 120,
                          child: Text(
                            widget.title,
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 60,
                          child: Text(
                            "₹ ${widget.price}",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'See Details',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.green,
                              child: RotatedBox(
                                quarterTurns: 2,
                                  child: Icon(
                                      Icons.arrow_back_ios_outlined,
                                    size: 12,
                                    color: Constants.primaryWhite,
                                  )
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Constants.primaryWhite,
                    border: Border.all(color: Constants.primaryAppColor),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(widget.imgUrl),
                  )
                ),
              )
            ],
          )
        ),
      ],
    );
  }
}
