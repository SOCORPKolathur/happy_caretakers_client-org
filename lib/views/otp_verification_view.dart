import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/views/caretaker/caretaker_main_view.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import '../constants.dart';
import '../widgets/kText.dart';
import 'caretaker/caretaker_register_view.dart';
import 'user/main_view.dart';

class OtpVerificationView extends StatefulWidget {
  String phone;
  String firstName;
  String lastName;
  final bool isCareTaker;

  OtpVerificationView({required this.firstName, required this.lastName, required this.phone, required this.isCareTaker});

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  TextEditingController otp = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _verifyphone();
  }

  var _verificationCode;

  _verifyphone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verificationid, int? resendtoken) {
          setState(() {
            _verificationCode = verificationid;
          });
        },
        codeAutoRetrievalTimeout: (String verificationid) {
          setState(() {
            _verificationCode = verificationid;
          });
        },
        timeout: Duration(seconds: 120));
  }

  bool ison = false;
  String userId = "";
  var first;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Constants.primaryWhite, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Color(0xffEDF8FF),
        border: Border.all(color: Color(0xffC8E3FF)),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: Constants.primaryAppColor,
      border: Border.all(color: Color(0xffC8E3FF)),
      borderRadius: BorderRadius.circular(10),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      textStyle: TextStyle(fontSize: 20, color: Constants.primaryAppColor, fontWeight: FontWeight.w600),
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: Color(0xffC8E3FF)),
        borderRadius: BorderRadius.circular(10),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Container(
            //   height: size.height,
            //   width: size.width,
            //   decoration: const BoxDecoration(
            //       image: DecorationImage(
            //         fit: BoxFit.fill,
            //         image: AssetImage("assets/dolomite-alps-peaks-italy 1.png"),
            //       )),
            // ),
            Container(
              height: size.height,
              width: size.width,
              color: Colors.white70,
            ),
            SizedBox(
              height: size.height,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: size.height * 0.05),
                      Column(
                        children: [
                          Container(
                            height: 200,
                            child: Lottie.asset(
                              "assets/otp_verify.json",
        
                            ),
                          ),
                          SizedBox(height: size.height * 0.07),
                          KText(
                            text: "Verify",
                            style: GoogleFonts.poppins(
                              fontSize: size.width/11.416666667,
                              color: Constants.darkBlack,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: size.height/173.2),
                          Text(
                            "An 6- Digit OTP has been sent your \n Phone no: +91 ${widget.phone}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Constants.newGrey,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: size.height * 0.05),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: "Enter code here",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Constants.newGrey,
                              ),
                            ),
                            SizedBox(height: 10),
                            Pinput(
                              controller: otp,
                              length: 6,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: submittedPinTheme,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              keyboardType: TextInputType.number,
                              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                              showCursor: true,
                              onCompleted: (pin) => print(pin),
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       vertical: size.height / 37.8,
                          //       horizontal: size.width / 18),
                          //   child: Container(
                          //     width: size.width / 1.028,
                          //     height: size.height / 12.6,
                          //     decoration: BoxDecoration(
                          //         color: const Color(0xff757879).withOpacity(0.3),
                          //         borderRadius: BorderRadius.circular(15)),
                          //     child: Center(
                          //         child: TextFormField(
                          //           maxLength: 6,
                          //           inputFormatters: [
                          //             FilteringTextInputFormatter.allow(
                          //                 RegExp(r'[0-9]')),
                          //           ],
                          //           controller: otp,
                          //           keyboardType: TextInputType.phone,
                          //           decoration: InputDecoration(
                          //             hintText: "OTP",
                          //             counterText: "",
                          //             prefixIcon: const Icon(Icons.password),
                          //             labelText: "Code",
                          //             labelStyle: GoogleFonts.poppins(
                          //               fontWeight: FontWeight.w600,
                          //               fontSize: size.width / 26.84,
                          //             ),
                          //             hintStyle: GoogleFonts.poppins(
                          //               fontWeight: FontWeight.w600,
                          //               fontSize: size.width / 26.84,
                          //             ),
                          //             border: InputBorder.none,
                          //           ),
                          //           style: GoogleFonts.poppins(
                          //             fontWeight: FontWeight.w600,
                          //             fontSize: size.width / 22.84,
                          //           ),
                          //         )),
                          //   ),
                          // ),
                          SizedBox(height: size.height/43.3),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(
                                  verificationId: _verificationCode,
                                  smsCode: otp.text,
                                )).then((value) async {
                                  if (value.user != null) {
                                    String? fcmToken = await FirebaseMessaging.instance.getToken();
                                    if(widget.isCareTaker){
                                      var document = await FirebaseFirestore.instance.collection('CareTakers').doc(value.user!.uid).get();
                                      if(document.exists){
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (ctx)=> CareTakerMainView()
                                          ),
                                        );
                                      }else{
                                        FirebaseFirestore.instance.collection('CareTakers').doc(value.user!.uid).set(
                                            {
                                              "id": value.user!.uid,
                                              "firstName" : "",
                                            }
                                        );
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (ctx)=> CaretakerRegisterView(
                                            id: value.user!.uid,
                                            phone: widget.phone,
                                            firstName: widget.firstName,
                                            lastName: widget.lastName,
                                          ),
                                          ),
                                        );
                                      }
                                    }else{
                                      var userDoc = await FirebaseFirestore.instance.collection('Users').get();
                                      var document = await FirebaseFirestore.instance.collection('Users').doc(value.user!.uid).get();
                                      if(!document.exists){
                                        FirebaseFirestore.instance.collection('Users').doc(value.user!.uid).set(
                                            {
                                              "id": value.user!.uid,
                                              "phone" : widget.phone,
                                              "fcmToken" : fcmToken,
                                              "subscriptionCount": 0,
                                              "address" : "",
                                              "firstName" : widget.firstName,
                                              "lastName" : widget.lastName,
                                            }
                                        );
                                      }
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> MainView()));
                                    }
                                  }
                                });
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.height / 37.8,
                                  horizontal: size.width / 18),
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Constants.primaryAppColor,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff7BBCFC),
                                        blurRadius: 5,
                                        offset: Offset(-2, 4),
                                      )
                                    ]
                                ),
                                child: Center(
                                  child: Text(
                                    "Verify OTP",
                                    style: GoogleFonts.openSans(
                                        fontSize: 17,
                                        color: const Color(0xffFFFFFF),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "",
                            style: GoogleFonts.openSans(
                                fontSize: 14, color: const Color(0xff757879)),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Edit Phone Number',
                                style: GoogleFonts.openSans(
                                  color: Constants.primaryAppColor,
                                  fontSize: size.width/29.357142857,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height/173.2)
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                alignment: AlignmentDirectional.center,
                decoration: const BoxDecoration(
                  color: Colors.white70,
                ),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  width: size.width/1.37,
                  height: size.height/4.33,
                  alignment: AlignmentDirectional.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                          height: size.height/17.32,
                          width: size.height/17.32,
                          child: CircularProgressIndicator(
                            color: Constants.primaryAppColor,
                            value: null,
                            strokeWidth: 7.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 25.0),
                        child: Center(
                          child: Text(
                            "loading..Please wait...",
                            style: TextStyle(
                              color: Constants.primaryAppColor,
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
      ),
    );
  }

  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Constants.primaryAppColor, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              spreadRadius: 2.0,
              blurRadius: 8.0,
              offset: Offset(2, 4),
            )
          ],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.info_outline, color: Constants.primaryAppColor),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Invalid credentials",
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
            ),
          ],
        )),
  );

}
