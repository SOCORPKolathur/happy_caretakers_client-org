import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';

class CustomProfileCard extends StatefulWidget {
  const CustomProfileCard({super.key});

  @override
  State<CustomProfileCard> createState() => _CustomProfileCardState();
}

class _CustomProfileCardState extends State<CustomProfileCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 180,
      width: size.width,
      child: Stack(
        children: [
          Container(
             height: 180,
             width: size.width,
             decoration: BoxDecoration(
               color: Constants.appBackgroundolor,
               borderRadius: BorderRadius.circular(20),
             ),
           ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: size.width * 0.565,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Constants.lightGrey,
                      backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTSAvhi0UxIvUoeY1ZBoYaV4q7adi8eK8Urg&usqp=CAU"),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sherley Igimo',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Constants.darkGrey,
                          ),
                        ),
                        Text(
                          'Assistant Nurse',
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
              //no use
              Container(
                  height: 10,
                width: size.width * 0.6,
                color: Constants.primaryWhite,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: const Center(child: Divider(color: Colors.black)),
              ),
              Container(
                height: 110,
                width: size.width,
                decoration: BoxDecoration(
                    color: Constants.primaryWhite,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                    ),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 2
                      )
                    ]
                ),
                child: Column(
                  children: [

                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 67,
              width: 138,
              decoration: BoxDecoration(
                color: Constants.appBackgroundolor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(17)
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 8,
            child: Container(
              height: 48,
              width: 120,
              decoration: BoxDecoration(
                color: const Color(0xff2B2B2B),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View',
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
        ],
      ),
    );
  }
}
