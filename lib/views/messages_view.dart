import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({super.key});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {

  TextEditingController _searchcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:
      Stack(
        children: [

          Container(
            height: 200,
            width: size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xffBFA0FF),
                      Constants.primaryAppColor,
                    ]
                )
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 115),
                  child: Text(
                    "Messages",
                    style: GoogleFonts.poppins(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                        color: Constants.primaryWhite,
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 55),
                  child: Icon(
                    Icons.more_vert_rounded,
                    color: Constants.primaryWhite,
                  ),
                )
              ],
            ),
          ),

          Padding(
            padding:  EdgeInsets.only(top:160),
            child: Material(
              elevation: 25,
              color: Constants.primaryWhite,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                height: double.infinity,
                width: size.width,
                decoration: BoxDecoration(
                    color: Constants.primaryWhite,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Material(
                      elevation: 25,
                      color: Constants.primaryWhite,
                      borderRadius: BorderRadius.circular(15),
                      shadowColor: Colors.black12,
                      child: Container(
                        height: 50,
                        width: 330,
                        decoration: BoxDecoration(
                            color: Constants.primaryWhite,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Padding(
                              padding:  EdgeInsets.only(left: 20),
                              child: Icon(
                                Icons.search,
                                color: Constants.lightGrey,
                              ),
                            ),
                            SizedBox(width: 10,),
                            SizedBox(
                              width: 260,
                              child: TextField(
                                controller: _searchcontroller,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search messages...",
                                    hintStyle: GoogleFonts.poppins(
                                        color: Constants.lightGrey
                                    )
                                ),
                              ),
                            )


                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),

                    Material(
                      elevation: 25,
                      color: Constants.primaryWhite,
                      borderRadius: BorderRadius.circular(15),
                      shadowColor: Colors.black12,
                      child: Container(
                        height: 80,
                        width: 330,
                        decoration: BoxDecoration(
                            color: Constants.primaryWhite,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:  CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.grey.shade300,
                                child: Icon(Icons.person),
                              ),
                              SizedBox(width: 8,),
                              SizedBox(
                                  width: 260,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width:200,

                                            child: Text("Dr. Shirley Igimo",style: GoogleFonts.poppins(
                                                color: Constants.darkGrey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600
                                            ),),
                                          ),
                                          SizedBox(
                                            width:50,

                                            child: Text("02.16 PM",style: GoogleFonts.poppins(
                                                color: Constants.lightGrey,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600
                                            ),
                                            ),
                                          ),

                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width:200,
                                            child: Text("Don’t forget to take your medicine",style: GoogleFonts.poppins(
                                                color: Constants.lightGrey,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600
                                            ),),
                                          ),
                                          Container(
                                            width:20,
                                            height: 20,
                                            margin: EdgeInsets.only(right: 15),
                                            decoration: BoxDecoration(
                                                color: Constants.lightOrange,
                                                borderRadius: BorderRadius.circular(100)
                                            ),

                                            child: Center(
                                              child: Text("99",style: GoogleFonts.poppins(
                                                  color: Constants.primaryWhite,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600
                                              ),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                              ),



                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}