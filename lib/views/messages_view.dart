import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/views/chat_view.dart';

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
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body:
      Stack(
        children: [
          Container(
            height: height/3.78,
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
                  padding: EdgeInsets.only(left: width/3.130434782608696),
                  child: Text(
                    "Connections",
                    style: GoogleFonts.poppins(
                      fontSize: width/15.65217391304348,
                      fontWeight: FontWeight.w600,
                        color: Constants.primaryWhite,
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: width/6.545454545454545),
                  child: Icon(
                    Icons.more_vert_rounded,
                    color: Constants.primaryWhite,
                  ),
                )
              ],
            ),
          ),

          Padding(
            padding:  EdgeInsets.only(top: height/4.725),
            child: Material(
              elevation: 25,
              color: Constants.primaryWhite,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Expanded(
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Constants.appBackgroundolor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  child: Column(
                    children: [
                      SizedBox(height: height/37.8),
                      Material(
                        elevation: 25,
                        color: Constants.primaryWhite,
                        borderRadius: BorderRadius.circular(15),
                        shadowColor: Colors.black12,
                        child: Container(
                          height: height/15.12,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Constants.primaryWhite,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(left: width/18),
                                child: Icon(
                                  Icons.search,
                                  color: Constants.lightGrey,
                                ),
                              ),
                              SizedBox(width: width/36),
                              SizedBox(
                                width: width/1.384615384615385,
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
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: 3,
                            itemBuilder: (ctx,i){
                              return Padding(
                                padding: EdgeInsets.only(bottom: height/75.6),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> ChatView()));
                                  },
                                  child: Material(
                                    elevation: 25,
                                    color: Constants.primaryWhite,
                                    borderRadius: BorderRadius.circular(15),
                                    shadowColor: Colors.black12,
                                    child: Container(
                                      height: height/10.8,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          color: Constants.primaryWhite,
                                          borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:  CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(width: width/45),
                                          CircleAvatar(
                                            radius: 23,
                                            backgroundColor: Colors.grey.shade300,
                                            child: Icon(Icons.person),
                                          ),
                                          SizedBox(width: width/45),
                                          Expanded(
                                            child: SizedBox(
                                              height: height/9.45,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width:width/1.8,
                                                      child: Text("Dr. Shirley Igimo",style: GoogleFonts.poppins(
                                                          color: Constants.darkGrey,
                                                          fontSize: width/25.71428571428571,
                                                          fontWeight: FontWeight.w600
                                                      ),),
                                                    ),
                                                    SizedBox(height: height/378),
                                                    Container(
                                                      height: height/37.8,
                                                      width:width/1.8,
                                                      child: Text(
                                                        "Don’t forget to take your medicine",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: GoogleFonts.poppins(
                                                          color: Constants.lightGrey,
                                                          fontSize: width/32.72727272727273,
                                                          fontWeight: FontWeight.w600
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            ),
                                          ),
                                          SizedBox(width: width/45),
                                          Container(
                                              width: width/6,
                                              height: height/9.45,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "02.16 PM",
                                                    style: GoogleFonts.poppins(
                                                      color: Constants.lightGrey,
                                                      fontSize: width/32.72727272727273,
                                                      fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                  SizedBox(height: height/378),
                                                  Container(
                                                    width:width/18,
                                                    height: height/37.8,
                                                    decoration: BoxDecoration(
                                                        color: Constants.lightOrange,
                                                        borderRadius: BorderRadius.circular(100)
                                                    ),
                                                    child: Center(
                                                      child: Text("99",style: GoogleFonts.poppins(
                                                          color: Constants.primaryWhite,
                                                          fontSize: width/32.72727272727273,
                                                          fontWeight: FontWeight.w600
                                                      ),),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ),
                                          SizedBox(width: width/45),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}