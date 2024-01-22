import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/views/caretaker/caretaker_language_select_view.dart';
import 'package:happy_caretakers_client/views/user/intro_view.dart';
import 'package:happy_caretakers_client/widgets/kText.dart';
import 'package:lottie/lottie.dart';

import 'caretaker/caretaker_login_view.dart';
import 'login_view.dart';

class ChooseRoleView extends StatefulWidget {
  const ChooseRoleView({super.key});

  @override
  State<ChooseRoleView> createState() => _ChooseRoleViewState();
}

class _ChooseRoleViewState extends State<ChooseRoleView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Constants.appBackgroundolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText(
                  text: "Choose your role",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Constants.primaryAppColor,
                  ),
              ),
              SizedBox(height: 30),
              Center(
                child: GestureDetector(
                  onTap: (){
                   // Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const LoginView(isCareTaker: true)));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> CaretakerLoginView(isCareTaker: true, lanCode: "")));
                  },
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: height * 0.36,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                        color: Constants.primaryWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            //width: width/9,
                            child: Lottie.asset('assets/anim11.json'),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: KText(
                              text: "I am Looking for Job",
                              style: GoogleFonts.poppins(
                                color: Constants.primaryAppColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: KText(
                    text: """------ OR ------""",
                    style: GoogleFonts.poppins(
                      color: Constants.lightGrey,
                    ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const IntroView()));
                  },
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: height * 0.36,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                        color: Constants.primaryWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            //width: width/9,
                            child: Lottie.asset('assets/anim11.json'),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: KText(
                              text: "I am Looking for Person",
                              style: GoogleFonts.poppins(
                                color: Constants.primaryAppColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
