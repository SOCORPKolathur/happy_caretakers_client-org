import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/widgets/kText.dart';
import 'package:lottie/lottie.dart';
import '../constants.dart';
import '../widgets/custom_textfiled.dart';
import 'otp_verification_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key,required this.isCareTaker});

  final bool isCareTaker;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lasNameController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  final _keyPhone = GlobalKey<FormFieldState>();
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            // decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       fit: BoxFit.fill,
            //       image: AssetImage("assets/dolomite-alps-peaks-italy 1.png"),
            //     ),
            // ),
          ),
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
                    SizedBox(height: size.height * 0.12),
                    Center(
                      child: Image.asset(
                        "assets/hct_logo.png",
                        height: height/9.45,
                        width: width/4.5,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "Welcome",
                          style: GoogleFonts.poppins(
                            //fontSize: size.width/11.416666667,
                            fontSize: 32,
                            color: Constants.darkBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: size.height/173.2),
                        Text(
                          "Kindly enter your details",
                          style: GoogleFonts.openSans(
                            fontSize: size.width/29.357142857,
                            color: const Color(0xff757879),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.06),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: "Firstname",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Constants.newGrey,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffEAF1FF),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xffC8E3FF),
                                  ),
                                ),
                                child: TextFormField(
                                  controller: firstNameController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                  ],
                                  maxLength: 45,
                                  onChanged: (val){

                                  },
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 20,top: 10),
                                    counterText: "",
                                    border: InputBorder.none,
                                    suffixIcon: const Icon(Icons.person_outline_rounded,color: Color(0xffC8E3FF)),
                                    hintText: "Enter your firstname",
                                    hintStyle: GoogleFonts.poppins(
                                      color: Constants.lightGrey,
                                      fontSize: 18,
                                    ),
                                    labelStyle: GoogleFonts.poppins(
                                      color: Constants.lightGrey,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: "Lastname",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Constants.newGrey,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffEAF1FF),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xffC8E3FF),
                                  ),
                                ),
                                child: TextFormField(
                                  controller: lasNameController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                  ],
                                  maxLength: 45,
                                  onChanged: (val){

                                  },
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 20,top: 10),
                                    counterText: "",
                                    border: InputBorder.none,
                                    suffixIcon: const Icon(Icons.person_outline_rounded,color: Color(0xffC8E3FF)),
                                    hintText: "Enter your lastname",
                                    hintStyle: GoogleFonts.poppins(
                                      color: Constants.lightGrey,
                                      fontSize: 18,
                                    ),
                                    labelStyle: GoogleFonts.poppins(
                                      color: Constants.lightGrey,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: "Phone Number*",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Constants.newGrey,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffEAF1FF),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xffC8E3FF),
                                  ),
                                ),
                                child: TextFormField(
                                  key: _keyPhone,
                                  controller: phoneController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  maxLength: 10,
                                  validator: (val){
                                    setState(() {
                                      if(val!.isEmpty) {
                                        errorText = 'Field is required';
                                        //return 'Field is required';
                                      } else if(val.length != 10){
                                        errorText = 'number must be 10 digits';
                                        //return 'number must be 10 digits';
                                      }else{
                                        errorText = '';
                                        //return '';
                                      }
                                    });
                                  },
                                  onChanged: (val){
                                    _keyPhone.currentState!.validate();
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 20,top: 10),
                                    counterText: "",
                                    border: InputBorder.none,
                                    suffixIcon: Icon(Icons.phone,color: const Color(0xffC8E3FF)),
                                    hintText: "123456789",
                                    hintStyle: GoogleFonts.poppins(
                                      color: Constants.lightGrey,
                                      fontSize: 18,
                                    ),
                                    labelStyle: GoogleFonts.poppins(
                                      color: Constants.lightGrey,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text(
                                  errorText,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height/43.3),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: size.width,
                      child: Row(
                        children: [
                          Expanded(child: Container(height: 2,color: const Color(0xffC8E3FF))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Or",
                              style: GoogleFonts.poppins(
                                color: Color(0xffC8E3FF),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Expanded(child: Container(height: 2,color: const Color(0xffC8E3FF))),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xffEAF1FF),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xffC8E3FF),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.g_mobiledata,
                              color: Constants.primaryAppColor,
                              size: 45,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xffEAF1FF),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xffC8E3FF),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.facebook,
                              color: Constants.primaryAppColor,
                              size: 35,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xffEAF1FF),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xffC8E3FF),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.mail,
                              color: Constants.primaryAppColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    InkWell(
                      onTap: () async {
                        _keyPhone.currentState!.validate();
                        if(phoneController.text.length == 10){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      OtpVerificationView(firstName: firstNameController.text,lastName: lasNameController.text, phone: phoneController.text,isCareTaker: widget.isCareTaker)));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: size.height/14.433333333,
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
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: GoogleFonts.openSans(
                                  fontSize: size.width/24.176470588,
                                  color: const Color(0xffFFFFFF),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height/173.2)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // authenticate() async {
  //   bool isRegistered = false;
  //   var document = await FirebaseFirestore.instance.collection("Users").get();
  //   for (int i = 0; i < document.docs.length; i++) {
  //     if (document.docs[i]['phone'] == emailController.text) {
  //       isRegistered = true;
  //     }
  //   }
  //   if(isRegistered){
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (ctx) =>
  //                 OtpVerificationView(phone: emailController.text)));
  //   }else{
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }

  showNewRegisterPopUp(context) async {
    Size size = MediaQuery.of(context).size;
    await showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: size.height * 0.5,
            width: size.width,
            decoration: BoxDecoration(
              color: Constants.primaryAppColor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1, 2),
                  blurRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: size.height * 0.3,
                  child: Lottie.asset("assets/thinking.json"),
                ),
                Text(
                  "You are new us. \n Resgiter with church",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigator.pop(context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (ctx) => const RegisterView()));
                  },
                  child: Container(
                    height: 40,
                    width: size.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(1, 2),
                        )
                      ],
                      border: Border.all(color: Constants.primaryAppColor),
                    ),
                    child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Constants.primaryAppColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
                "Your Registeration not completed.",
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
            ),
          ],
        )),
  );
}
