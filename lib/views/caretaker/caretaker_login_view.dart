import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../widgets/kText.dart';
import '../otp_verification_view.dart';

class CaretakerLoginView extends StatefulWidget {
  const CaretakerLoginView({super.key,required this.isCareTaker, required this.lanCode});

  final bool isCareTaker;
  final String lanCode;

  @override
  State<CaretakerLoginView> createState() => _CaretakerLoginViewState();
}

class _CaretakerLoginViewState extends State<CaretakerLoginView> {

  TextEditingController aadhaarController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lasNameController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  final _keyPhone = GlobalKey<FormFieldState>();
    final _keyAadhaar = GlobalKey<FormFieldState>();
  String errorText = "";
  String errorText1 = "";

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
                                text: "Name",
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
                          // SizedBox(height: 20),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     KText(
                          //       text: "Lastname",
                          //       style: GoogleFonts.poppins(
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: 16,
                          //         color: Constants.newGrey,
                          //       ),
                          //     ),
                          //     Container(
                          //       decoration: BoxDecoration(
                          //         color: const Color(0xffEAF1FF),
                          //         borderRadius: BorderRadius.circular(10),
                          //         border: Border.all(
                          //           color: const Color(0xffC8E3FF),
                          //         ),
                          //       ),
                          //       child: TextFormField(
                          //         controller: lasNameController,
                          //         inputFormatters: [
                          //           FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                          //         ],
                          //         maxLength: 45,
                          //         onChanged: (val){
                          //
                          //         },
                          //         keyboardType: TextInputType.name,
                          //         decoration: InputDecoration(
                          //           contentPadding: EdgeInsets.only(left: 20,top: 10),
                          //           counterText: "",
                          //           border: InputBorder.none,
                          //           suffixIcon: const Icon(Icons.person_outline_rounded,color: Color(0xffC8E3FF)),
                          //           hintText: "Enter your lastname",
                          //           hintStyle: GoogleFonts.poppins(
                          //             color: Constants.lightGrey,
                          //             fontSize: 18,
                          //           ),
                          //           labelStyle: GoogleFonts.poppins(
                          //             color: Constants.lightGrey,
                          //             fontSize: 18,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: "Aadhaar Number*",
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
                                  key: _keyAadhaar,
                                  controller: aadhaarController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  maxLength: 12,
                                  validator: (val){
                                    setState(() {
                                      if(val!.isEmpty) {
                                        errorText1 = 'Field is required';
                                        //return 'Field is required';
                                      } else if(val.length != 12){
                                        errorText1 = 'number must be 12 digits';
                                        //return 'number must be 10 digits';
                                      }else{
                                        errorText1 = '';
                                        //return '';
                                      }
                                    });
                                  },
                                  onChanged: (val){
                                    _keyAadhaar.currentState!.validate();
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
                                  errorText1,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height/43.3),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    InkWell(
                      onTap: () async {
                        _keyPhone.currentState!.validate();
                        _keyAadhaar.currentState!.validate();
                        if(phoneController.text.length == 10 && aadhaarController.text.length == 12){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      OtpVerificationView(firstName: firstNameController.text,lastName: aadhaarController.text, phone: phoneController.text,isCareTaker: widget.isCareTaker,lanCode: widget.lanCode)));
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


}
