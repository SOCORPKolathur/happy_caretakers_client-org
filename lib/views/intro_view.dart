import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/views/login_view.dart';
import 'package:happy_caretakers_client/views/main_view.dart';
import 'package:happy_caretakers_client/widgets/primary_button.dart';
import 'package:happy_caretakers_client/widgets/secondary_button.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: Constants.primaryWhite,
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                "assets/hct_logo.png",
                height: height/9.45,
                width: width/4.5,
              ),
            ),
            Text(
              'Happy CareTakers',
              style: GoogleFonts.poppins(
                  fontSize: width/15.65217391304348,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            Center(
              child: Image.asset(
                "assets/intro_img.png",
                height: size.height * 0.5,
                width: size.width,
              ),
            ),
            Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Healthy  ',
                    style: GoogleFonts.poppins(
                      fontSize: width/20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'gets easier',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: width/20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Now on your hand',
                  style: GoogleFonts.poppins(
                    fontSize: width/20,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(height: height/18.9),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SecondaryButton(
                  title: 'Sign IN',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> const LoginView()));
                  },
                ),
                PrimaryButton(
                  title: 'Get Started',
                  onTap: () {
                    Navigator.pushReplacement(context,_createRoute());
                  },
                )
              ],
            ),
            SizedBox(height: height/37.8),
            InkWell(
              onTap: () {

              },
              child: RichText(
                text: TextSpan(
                  text: 'Don\'t have an account?',
                  style: GoogleFonts.poppins(
                    fontSize: size.width / 29.357142857,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Register Now',
                      style: GoogleFonts.openSans(
                        color: Color(0xff67D9A2),
                        fontSize: size.width / 29.357142857,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const MainView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

}
