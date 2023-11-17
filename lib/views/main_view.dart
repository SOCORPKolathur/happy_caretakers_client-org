import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/views/home_view.dart';
import 'package:happy_caretakers_client/views/messages_view.dart';
import 'package:happy_caretakers_client/views/products_view.dart';
import 'package:happy_caretakers_client/views/profile_view.dart';
import 'package:inkblob_navigation_bar/inkblob_navigation_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int _selectedIndex = 0;

  List<Widget> pages = [
    HomeView(),
    MessagesView(),
    ProductsView(),
    ProfileView(),
  ];


  int animatesetvalue = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: pages[_selectedIndex],
        bottomNavigationBar: Container(
          color: Constants.appBackgroundolor,
          child: Material(
            color: const Color(0xffFFFFFF),
            shadowColor: Colors.black38,
            elevation: 0,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            child: AnimatedContainer(
              height: height / 14.82,
              duration: const Duration(seconds: 1),
              decoration: const BoxDecoration(
                //color: Color(0xffFFFFFF),
                  borderRadius:
                  BorderRadius.vertical(bottom: Radius.elliptical(150, 60))
                // borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height / 94.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 0;
                              animatesetvalue = 0;
                            });
                            setState(() {});
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/home_icon.png", height: height / 30.24,
                                width: width / 14.4,
                               color: animatesetvalue == 0
                                  ? Constants.primaryAppColor
                                  : Constants.lightGrey,
                                // color: animatesetvalue==0?Color(0xff00194A):
                                // Color(0xffA0A0A0)
                              ),
                              Text(
                                "Home",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: width / 30,
                                  color: animatesetvalue == 0
                                      ? Constants.primaryAppColor
                                      : Constants.lightGrey,
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 1;
                              animatesetvalue = 1;
                            });
                            setState(() {});
                          },
                          child: Column(
                            children: [
                              Image.asset("assets/message_icon.png",
                                  height: height / 30.24, width: width / 14.4,
                                color: animatesetvalue == 1
                                    ? Constants.primaryAppColor
                                    : Constants.lightGrey,
                              ),
                              Text("Messages",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: width / 30,
                                    color: animatesetvalue == 1
                                        ? Constants.primaryAppColor
                                        : Constants.lightGrey,
                                  ))
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 2;
                              animatesetvalue = 2;
                            });
                            setState(() {});
                          },
                          child: Column(
                            children: [
                              Image.asset("assets/cart_icon.png",
                                  height: height / 30.24, width: width / 14.4,
                                color: animatesetvalue == 2
                                    ? Constants.primaryAppColor
                                    : Constants.lightGrey,
                              ),
                              Text("Products",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: width / 30,
                                    color: animatesetvalue == 2
                                        ? Constants.primaryAppColor
                                        : Constants.lightGrey,
                                  ))
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 3;
                              animatesetvalue = 3;
                            });
                            setState(() {});
                          },
                          child: Column(
                            children: [
                              Image.asset("assets/profile_icon.png",
                                  height: height / 30.24, width: width / 14.4,
                                color: animatesetvalue == 3
                                    ? Constants.primaryAppColor
                                    : Constants.lightGrey,
                              ),
                              Text("Profile",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: width / 30,
                                    color: animatesetvalue == 3
                                        ? Constants.primaryAppColor
                                        : Constants.lightGrey,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // AnimatedContainer(
                  //   duration: const Duration(milliseconds: 600),
                  //   curve: Curves.fastEaseInToSlowEaseOut,
                  //   height: height / 252,
                  //   width: width / 8,
                  //   margin: EdgeInsets.only(
                  //       left: animatesetvalue == 0
                  //           ? width / 18
                  //           : animatesetvalue == 1
                  //           ? width / 3.272
                  //           : animatesetvalue == 2
                  //           ? width / 1.756
                  //           : animatesetvalue == 3
                  //           ? width / 1.241
                  //           : 0),
                  //   color: const Color(0xff245BCA),
                  // )
                ],
              ),
            ),
          ),
        )
    );
  }
}
