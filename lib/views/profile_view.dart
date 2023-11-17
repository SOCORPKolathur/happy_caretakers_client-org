import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/views/chat_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  TextEditingController _searchcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: Constants.appBackgroundolor,
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            Container(
              height: height/2.78,
              width: size.width,
              decoration: BoxDecoration(
                color: Constants.darkBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Constants.primaryWhite,
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToih1Zk-973AZLNE6aDwDo2IX49B0Ix_j4pw&usqp=CAU",
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Veronica John',
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        color: Constants.primaryWhite,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '+91 7639033006',
                    style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: Constants.primaryWhite,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              top:  290,
              child: Container(
                height: height * 0.65,
                width: width,
                child: Column(
                  children: [
                    CardWidget('Edit Profile',Icons.person,Colors.red),
                    SizedBox(height: 15),
                    CardWidget('App Languages',Icons.translate,Colors.green),
                    SizedBox(height: 15),
                    CardWidget('Your Orders',Icons.shopping_basket,Colors.pink),
                    SizedBox(height: 15),
                    CardWidget('Contact Support',Icons.headphones,Colors.lightBlue),
                    SizedBox(height: 15),
                    CardWidget('About Happy Caretakers',Icons.info,Colors.blueGrey),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  CardWidget(String title, IconData icon,Color color){
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 80,
        width: width*0.9,
        decoration: BoxDecoration(
          color: Constants.primaryWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 250,
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 19
                ),
              ),
            ),
            Icon(
              icon,
              color: color,
              size: 35,
            )
          ],
        ),
      ),
    );
  }
}