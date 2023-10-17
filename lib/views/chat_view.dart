import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.appBackgroundolor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height/9.45,
              width: size.width,
              decoration: BoxDecoration(
                  color: Constants.primaryAppColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: size.width/22.5),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Constants.primaryWhite,
                        ),
                      ),
                      SizedBox(
                        width: size.width/45,
                      ),
                      CircleAvatar(
                        radius: size.height/32.8695652173913,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTSAvhi0UxIvUoeY1ZBoYaV4q7adi8eK8Urg&usqp=CAU"),
                      ),
                      SizedBox(
                        width: size.width/20,
                      ),
                      Expanded(
                        child: SizedBox(
                            height: size.height/9.45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: size.width/1.8,
                                  child: Text(
                                    "Dr. Shirley Igimo",
                                    style: GoogleFonts.poppins(
                                        color: Constants.primaryWhite,
                                        fontSize: size.width/20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height/75.6),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width/36),
              child: SizedBox(
                height: size.height/3.28695652173913,
                width: size.width,
                child: Column(
                  children: [
                    Container(
                      height: size.height/15.12,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Constants.primaryAppColor,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          )),
                      child: Center(
                        child: Text(
                          "Contact Details",
                          style: GoogleFonts.poppins(
                            color: Constants.primaryWhite,
                            fontWeight: FontWeight.w600,
                            fontSize: size.width/18.94736842105263,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: size.height/4.2,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Constants.primaryWhite,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )),
                      padding: EdgeInsets.symmetric(vertical: size.height/75.6, horizontal: size.width/18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phone :",
                                    style: GoogleFonts.poppins(
                                      color: Constants.darkGrey,
                                      fontSize: size.width/24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: size.height/378),
                                  Text(
                                    "+91 7639033006",
                                    style: GoogleFonts.poppins(
                                      color: Constants.darkGrey,
                                      fontSize: size.width/27.69230769230769,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.phone,
                                color: Constants.primaryAppColor,
                              )
                            ],
                          ),
                          SizedBox(height: size.height/63),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mail ID :",
                                    style: GoogleFonts.poppins(
                                      color: Constants.darkGrey,
                                      fontSize: size.width/24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: size.height/378),
                                  Text(
                                    "knagaraj942@gmail.com",
                                    style: GoogleFonts.poppins(
                                      color: Constants.darkGrey,
                                      fontSize: size.width/27.69230769230769,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.mail_outline,
                                color: Constants.primaryAppColor,
                              )
                            ],
                          ),
                          SizedBox(height: size.height/63),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Address:",
                                style: GoogleFonts.poppins(
                                  color: Constants.darkGrey,
                                  fontSize: size.width/24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: size.height/378),
                              Text(
                                "38,Madurai,Tamil nadu.",
                                style: GoogleFonts.poppins(
                                  color: Constants.darkGrey,
                                  fontSize: size.width/27.69230769230769,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: size.height / 15,
        width: double.infinity,
        child: SizedBox(
          height: size.height / 18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Constants.primaryWhite,
                ),
                height: size.height/12.6,
                width: size.width * 0.8,
                child: TextField(
                  //controller: chatMessage,
                  //onEditingComplete: onSendMessag,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: size.width/36),
                    hintText: "Type your message",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(width: size.width/72),
              Material(
                elevation: 2,
                color: Constants.primaryWhite,
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: size.height/12.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Icon(
                          Icons.send,
                          color: Constants.primaryAppColor,
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
