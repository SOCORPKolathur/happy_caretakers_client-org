// import 'dart:io';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:happy_caretakers_client/constants.dart';
// import 'package:happy_caretakers_client/models/care_takers_model.dart';
// import 'package:happy_caretakers_client/models/response.dart';
// import 'package:happy_caretakers_client/services/care_takers_firecrud.dart';
// import 'package:happy_caretakers_client/views/caretaker/caretaker_main_view.dart';
// import 'package:happy_caretakers_client/views/root_app.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../widgets/kText.dart';
//
// class CaretakerRegisterView extends StatefulWidget {
//   const CaretakerRegisterView({super.key,required this.id, required this.phone, required this.firstName, required this.lastName});
//
//   final String id;
//   final String phone;
//   final String firstName;
//   final String lastName;
//
//   @override
//   State<CaretakerRegisterView> createState() => _CaretakerRegisterViewState();
// }
//
// class _CaretakerRegisterViewState extends State<CaretakerRegisterView> {
//
//   double latitude = 0.0;
//   double longitude = 0.0;
//
//   File? profileImage;
//   XFile? imageForShow;
//
//   // File? aadharImage;
//   // XFile? aadharImageForShow;
//
//
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//   TextEditingController aadhaarNumberController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController workExperienceController = TextEditingController();
//   TextEditingController totalWorksController = TextEditingController();
//   TextEditingController positionController = TextEditingController();
//   TextEditingController workingAtController = TextEditingController();
//   TextEditingController workPreparenceController = TextEditingController();
//   TextEditingController aboutController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController yearOfExperienceController = TextEditingController();
//
//   ImagePicker picker = ImagePicker();
//
//   bool isLoading = false;
//
//   clearAllControllers(){
//     setState(() {
//         firstNameController.clear();
//         lastNameController.clear();
//         phoneController.clear();
//         emailController.clear();
//         ageController.clear();
//         cityController.clear();
//         workExperienceController.clear();
//         totalWorksController.clear();
//         positionController.clear();
//         workingAtController.clear();
//         workPreparenceController.clear();
//         aboutController.clear();
//         aadhaarNumberController.clear();
//         addressController.clear();
//     });
//   }
//
//
//   @override
//   void initState() {
//     getLocation();
//     setData();
//     super.initState();
//   }
//
//   setData(){
//     setState(() {
//       phoneController.text = widget.phone;
//     });
//   }
//   getLocation() async {
//     await Geolocator.requestPermission();
//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       latitude = position.latitude!;
//       longitude = position.longitude!;
//     });
//     print(latitude);
//     print(longitude);
//   }
//
//   pickImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         profileImage = File(pickedFile.path);
//         imageForShow = pickedFile;
//       });
//     } else {
//       print('No image selected.');
//       return;
//     }
//   }
//
//   // pickAadharImage() async {
//   //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//   //
//   //   if (pickedFile != null) {
//   //     setState(() {
//   //       aadharImage = File(pickedFile.path);
//   //       aadharImageForShow = pickedFile;
//   //     });
//   //   } else {
//   //     print('No image selected.');
//   //     return;
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     double height = size.height;
//     double width = size.width;
//     return Scaffold(
//       backgroundColor: Constants.appBackgroundolor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Image.asset(
//                     "assets/hct_logo.png",
//                     height: height/9.45,
//                     width: width/4.5,
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     KText(
//                       text: "Register as a Caretaker in",
//                       style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: Constants.lightGrey,
//                       ),
//                     ),
//                     KText(
//                       text: "Happy Caretakers",
//                       style: GoogleFonts.poppins(
//                         fontSize: 26,
//                         fontWeight: FontWeight.w700,
//                         color: Constants.primaryAppColor,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 30),
//                 Center(
//                     child: Container(
//                       height: 150,
//                       width: 150,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Constants.primaryAppColor,
//                         image: imageForShow != null
//                             ? DecorationImage(
//                             fit: BoxFit.fill,
//                             image: FileImage(profileImage!)
//                         ) :null,
//                         //     : DecorationImage(
//                         //     fit: BoxFit.fill,
//                         //     image: NetworkImage(oldImgUrl)
//                         // ),
//                         border: Border.all(color: Constants.primaryAppColor,width: 3),
//                       ),
//                       child: imageForShow == null ? Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.add_a_photo,
//                               color: Constants.primaryWhite,
//                               size: 40,
//                             ),
//                             KText(
//                               text: "Profile Photo",
//                               style: GoogleFonts.poppins(
//                                 color: Constants.primaryWhite,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 15,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ):null,
//                     )
//                 ),
//                 const SizedBox(height: 10),
//                 Center(
//                   child: InkWell(
//                     onTap: (){
//                       pickImage();
//                     },
//                     child: Container(
//                       height: 40,
//                       width: size.width * 0.5,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: Constants.primaryAppColor,
//                           width: 3,
//                         ),
//                       ),
//                       child: Center(
//                         child: KText(
//                             text: "Change Profile Picture",
//                             style: TextStyle(
//                               color: Constants.primaryAppColor,
//                               fontWeight: FontWeight.w600,
//                             )
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: firstNameController,
//                     decoration: InputDecoration(
//                         suffixIcon: Icon(Icons.person, color: Constants.primaryAppColor),
//                         border: InputBorder.none,
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         hintText: 'First Name',
//                         hintStyle: TextStyle(
//                           color: Constants.lightGrey,
//                         )),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: lastNameController,
//                     decoration: InputDecoration(
//                         suffixIcon: Icon(Icons.person, color: Constants.primaryAppColor),
//                         border: InputBorder.none,
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         hintText: 'Last Name',
//                         hintStyle: TextStyle(
//                           color: Constants.lightGrey,
//                         )),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(
//                           RegExp(r'[0-9]')),
//                     ],
//                     maxLength: 10,
//                     controller: phoneController,
//                     decoration: InputDecoration(
//                         counterText: "",
//                         suffixIcon: Icon(Icons.phone, color: Constants.primaryAppColor),
//                         border: InputBorder.none,
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         hintText: 'Phone',
//                         hintStyle: TextStyle(
//                           color: Constants.lightGrey,
//                         )),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     keyboardType: TextInputType.emailAddress,
//                     controller: emailController,
//                     decoration: InputDecoration(
//                         suffixIcon: Icon(Icons.alternate_email, color: Constants.primaryAppColor),
//                         border: InputBorder.none,
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         hintText: 'Email',
//                         hintStyle: TextStyle(
//                           color: Constants.lightGrey,
//                         )),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: cityController,
//                     decoration: InputDecoration(
//                         suffixIcon: Icon(Icons.location_city, color: Constants.primaryAppColor),
//                         border: InputBorder.none,
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         hintText: 'City',
//                         hintStyle: TextStyle(
//                           color: Constants.lightGrey,
//                         ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     controller: ageController,
//                     decoration: InputDecoration(
//                         suffixIcon: Icon(Icons.person_pin_sharp, color: Constants.primaryAppColor),
//                         border: InputBorder.none,
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         hintText: 'Age',
//                         hintStyle: TextStyle(
//                           color: Constants.lightGrey,
//                         )),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     controller: yearOfExperienceController,
//                     decoration: InputDecoration(
//                         suffixIcon: Icon(Icons.work_history, color: Constants.primaryAppColor),
//                         border: InputBorder.none,
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         hintText: 'Years of Experience',
//                         hintStyle: TextStyle(
//                           color: Constants.lightGrey,
//                         )),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     controller: totalWorksController,
//                     decoration: InputDecoration(
//                         suffixIcon: Icon(Icons.work, color: Constants.primaryAppColor),
//                         border: InputBorder.none,
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         hintText: 'Total Works',
//                         hintStyle: TextStyle(
//                           color: Constants.lightGrey,
//                         )),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: positionController,
//                     decoration: InputDecoration(
//                         suffixIcon: Icon(Icons.workspace_premium, color: Constants.primaryAppColor),
//                         border: InputBorder.none,
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         hintText: 'Position',
//                         hintStyle: TextStyle(
//                           color: Constants.lightGrey,
//                         ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: workingAtController,
//                     decoration: InputDecoration(
//                         suffixIcon: Icon(Icons.location_on_outlined, color: Constants.primaryAppColor),
//                         border: InputBorder.none,
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         hintText: 'Working At',
//                         hintStyle: TextStyle(
//                           color: Constants.lightGrey,
//                         )),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: workPreparenceController,
//                     decoration: InputDecoration(
//                         suffixIcon: Icon(Icons.room_preferences, color: Constants.primaryAppColor),
//                         border: InputBorder.none,
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         hintText: 'Work Preference',
//                         hintStyle: TextStyle(
//                           color: Constants.lightGrey,
//                         )),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 100,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: workExperienceController,
//                     maxLines: null,
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         hintText: 'Work Experience',
//                         hintStyle: TextStyle(
//                           color: Constants.lightGrey,
//                         )),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 100,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: aboutController,
//                     maxLines: null,
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         hintText: 'About',
//                         hintStyle: TextStyle(
//                           color: Constants.lightGrey,
//                         )),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 100,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: addressController,
//                     maxLines: null,
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         hintText: 'Address',
//                         hintStyle: TextStyle(
//                           color: Constants.lightGrey,
//                         )),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 50,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: TextField(
//                     controller: aadhaarNumberController,
//                     maxLength: 12,
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(
//                           RegExp(r'[0-9]')),
//                     ],
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                         counterText: "",
//                         suffixIcon: Icon(Icons.person_outline_sharp, color: Constants.primaryAppColor),
//                         border: InputBorder.none,
//                         contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         hintText: 'Aadhaar Number',
//                         hintStyle: TextStyle(
//                           color: Constants.lightGrey,
//                         ),
//                     ),
//                   ),
//                 ),
//                 // Center(
//                 //     child: InkWell(
//                 //       onTap: (){
//                 //         pickAadharImage();
//                 //       },
//                 //       child: Container(
//                 //         height: 150,
//                 //         width: 150,
//                 //         decoration: BoxDecoration(
//                 //           borderRadius: BorderRadius.circular(10),
//                 //           color: Constants.primaryAppColor,
//                 //           image: aadharImageForShow != null
//                 //               ? DecorationImage(
//                 //               fit: BoxFit.fill,
//                 //               image: FileImage(aadharImage!)
//                 //           ) : null,
//                 //           //     : DecorationImage(
//                 //           //     fit: BoxFit.fill,
//                 //           //     image: NetworkImage(oldImgUrl)
//                 //           // ),
//                 //         ),
//                 //         child: aadharImageForShow == null ? Center(
//                 //           child: Column(
//                 //             mainAxisAlignment: MainAxisAlignment.center,
//                 //             children: [
//                 //               Icon(
//                 //                 Icons.add_a_photo,
//                 //                 color: Constants.primaryWhite,
//                 //                 size: 40,
//                 //               ),
//                 //               KText(
//                 //                 text: "Aadhaar Photo",
//                 //                 style: GoogleFonts.poppins(
//                 //                   color: Constants.primaryWhite,
//                 //                   fontWeight: FontWeight.w700,
//                 //                   fontSize: 15,
//                 //                 ),
//                 //               ),
//                 //             ],
//                 //           ),
//                 //         ):null,
//                 //       ),
//                 //     )
//                 // ),
//                 SizedBox(height: 20),
//                 InkWell(
//                   onTap: () async {
//                     if(!isLoading){
//                       setState(() {
//                         isLoading = true;
//                       });
//                       if(
//                        firstNameController.text != "" &&
//                         lastNameController.text != "" &&
//                         phoneController.text != "" &&
//                         emailController.text != "" &&
//                         ageController.text != "" &&
//                         cityController.text != "" &&
//                         workExperienceController.text != "" &&
//                         totalWorksController.text != "" &&
//                          positionController.text != "" &&
//                         workingAtController.text != "" &&
//                         workPreparenceController.text != "" &&
//                         aboutController.text != "" &&
//                          addressController.text != ""
//                       ){
//                         String downloadUrl = "";
//                         String? fcmToken = await FirebaseMessaging.instance.getToken();
//                         if(profileImage != null){
//                           downloadUrl =  await uploadImageToStorage(profileImage!);
//                         }
//                         //downloadUrl1 =  await uploadImageToStorage(aadharImage!);
//                         Response response = await CareTakersFireCrud.addCareTaker(
//                             CareTakersModel(
//                               firstName: firstNameController.text,
//                               id: widget.id,
//                               fcmToken: fcmToken!,
//                               lastName: lastNameController.text,
//                               age: int.parse(ageController.text.toString()),
//                               phone: phoneController.text,
//                               rating: [],
//                               workExperience: workExperienceController.text,
//                               totalWorks: int.parse(totalWorksController.text.toString()),
//                               email: emailController.text,
//                               location: Location(
//                                 lat: latitude,
//                                 lng: longitude,
//                               ),
//                               address: addressController.text,
//                               about: aboutController.text,
//                               city: cityController.text,
//                               yearsOfExperience: int.parse(yearOfExperienceController.text.toString()),
//                               position: positionController.text,
//                               workingAt: workingAtController.text,
//                               imgUrl: downloadUrl,
//                               aadharNumber: aadhaarNumberController.text,
//                               timestamp: DateTime.now().millisecondsSinceEpoch,
//                               workPreparence: workPreparenceController.text,
//                             )
//                         );
//                         if(response.code == 200){
//                           setState(() {
//                             isLoading = false;
//                           });
//                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> CareTakerMainView()));
//                         }else{
//                           print("Failed");
//                           setState(() {
//                             isLoading = false;
//                           });
//                         }
//                       }else{
//                         setState(() {
//                           isLoading = false;
//                         });
//                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                       }
//                     }
//                   },
//                   child: Container(
//                     height: 50,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Constants.primaryAppColor,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(
//                       child: isLoading
//                           ? CircularProgressIndicator(
//                         color: Constants.primaryWhite,
//                       )
//                           : KText(
//                         text: "Register",
//                         style: GoogleFonts.poppins(
//                           color: Constants.primaryWhite,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     )
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static Future<String> uploadImageToStorage(File file) async {
//     var snapshot = await  FirebaseStorage.instance
//         .ref()
//         .child('dailyupdates')
//         .child("${file.path}")
//         .putFile(file);
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }
//
//   final snackBar = SnackBar(
//     backgroundColor: Colors.transparent,
//     elevation: 0,
//     content: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Constants.primaryAppColor, width: 3),
//           boxShadow: const [
//             BoxShadow(
//               color: Color(0x19000000),
//               spreadRadius: 2.0,
//               blurRadius: 8.0,
//               offset: Offset(2, 4),
//             )
//           ],
//           borderRadius: BorderRadius.circular(4),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Icon(Icons.info_outline, color: Constants.primaryAppColor),
//             Padding(
//               padding: EdgeInsets.only(left: 8.0),
//               child: Text(
//                 "Please fill all fields",
//                 style: TextStyle(color: Colors.black, fontSize: 10),
//               ),
//             ),
//           ],
//         )),
//   );
//
// }


import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/views/caretaker/caretaker_register_form_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../constants.dart';
import '../../models/care_takers_model.dart';
import '../../models/response.dart';
import '../../services/care_takers_firecrud.dart';
import '../../widgets/kText.dart';
import 'caretaker_main_view.dart';

enum genderEnum { Male, Female, Others  }

class CaretakerRegisterView extends StatefulWidget {
  const CaretakerRegisterView({super.key,required this.id, required this.phone, required this.firstName, required this.lastName,required this.lanCode});

  final String phone;
  final String firstName;
  final String lastName;
  final String lanCode;
  final String id;
  @override
  State<CaretakerRegisterView> createState() => _CaretakerRegisterViewState();
}

class _CaretakerRegisterViewState extends State<CaretakerRegisterView> {

  double latitude = 0.0;
  double longitude = 0.0;

  File? profileImage;
  XFile? imageForShow;

  // File? aadharImage;
  // XFile? aadharImageForShow;


  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController aadhaarNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController workExperienceController = TextEditingController();
  TextEditingController totalWorksController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController workingAtController = TextEditingController();
  TextEditingController workPreparenceController = TextEditingController();
  TextEditingController subCategoryController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController yearOfExperienceController = TextEditingController();
  TextEditingController orgNameController = TextEditingController();
  TextEditingController categoryController = TextEditingController(text: "Select Category");
  bool isCurrentlyWorking = false;
  ImagePicker picker = ImagePicker();

  bool isLoading = false;

  clearAllControllers(){
    setState(() {
        firstNameController.clear();
        lastNameController.clear();
        phoneController.clear();
        emailController.clear();
        ageController.clear();
        cityController.clear();
        workExperienceController.clear();
        totalWorksController.clear();
        positionController.clear();
        workingAtController.clear();
        workPreparenceController.clear();
        subCategoryController.clear();
        aadhaarNumberController.clear();
        orgNameController.clear();
        addressController.clear();
        categoryController.text = "Select Category";
        isCurrentlyWorking = false;
    });
  }

  genderEnum genderController = genderEnum.Male;

  @override
  void initState() {
    getLocation();
    setData();
    super.initState();
  }

  setData(){
    setState(() {
      phoneController.text = widget.phone;
    });
  }
  getLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude!;
      longitude = position.longitude!;
    });
    print(latitude);
    print(longitude);
  }

  pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
        imageForShow = pickedFile;
      });
    } else {
      print('No image selected.');
      return;
    }
  }

  bool isEmail(String input) => EmailValidator.validate(input);

  final _keyFirstName = GlobalKey<FormFieldState>();
  final _keyLastName = GlobalKey<FormFieldState>();
  final _keyPhone = GlobalKey<FormFieldState>();
  final _keyEmail = GlobalKey<FormFieldState>();
  final _keyAge = GlobalKey<FormFieldState>();
  final _keyCity = GlobalKey<FormFieldState>();
  final _keyAadhar = GlobalKey<FormFieldState>();
  final _keyAddress = GlobalKey<FormFieldState>();
  final _keyCategory = GlobalKey<FormFieldState>();
  final _keyYearOfExp = GlobalKey<FormFieldState>();
  final _keyPosition = GlobalKey<FormFieldState>();
  final _keyOrgName = GlobalKey<FormFieldState>();
  final _keyAbout = GlobalKey<FormFieldState>();
  final _keyWorking = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: Constants.primaryWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height/2.88,
              width: size.width,
              decoration: BoxDecoration(
                color: Constants.darkBlue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  KText(
                      text: "Setup Profile",
                      style: TextStyle(
                        color: Constants.primaryWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      )
                  ),
                  SizedBox(height: 10),
                  Center(
                      child: InkWell(
                        onTap: (){
                          pickImage();
                        },
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Constants.primaryAppColor,
                            image: imageForShow != null
                                ? DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(profileImage!)
                            ) :null,
                            //     : DecorationImage(
                            //     fit: BoxFit.fill,
                            //     image: NetworkImage(oldImgUrl)
                            // ),
                            border: Border.all(color: Constants.primaryAppColor,width: 3),
                          ),
                          child: imageForShow == null ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  color: Constants.primaryWhite,
                                  size: 40,
                                ),
                              ],
                            ),
                          ):null,
                        ),
                      )
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: InkWell(
                      onTap: (){
                        pickImage();
                      },
                      child: Center(
                        child: KText(
                            text: "Change Profile Picture",
                            style: TextStyle(
                              color: Constants.primaryWhite,
                              fontWeight: FontWeight.w400,
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width / 2.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: "Firstname *",
                              style: GoogleFonts.roboto(
                                color: Constants.lightGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextFormField(
                              key: _keyFirstName,
                              //focusNode: firstNameFocusNode,
                              autofocus: true,
                              // onEditingComplete: (){
                              //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                              // },
                              // onFieldSubmitted: (val){
                              //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                              // },
                              validator: (val){
                                if(val!.isEmpty){
                                  return 'Field is required';
                                }else{
                                  return '';
                                }
                              },
                              keyboardType: TextInputType.name,
                              onChanged: (val){
                                //_keyFirstName.currentState!.validate();
                              },
                              decoration: InputDecoration(
                                counterText: "",
                                contentPadding: EdgeInsets.only(top: 5,left: 5),
                              ),
                              maxLength: 40,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                              ],
                              style: TextStyle(fontSize: 15),
                              controller: firstNameController,
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: width / 68.3),
                      SizedBox(
                        width: width / 2.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: "Lastname *",
                              style: GoogleFonts.roboto(
                                color: Constants.lightGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextFormField(
                              key: _keyLastName,
                              //focusNode: firstNameFocusNode,
                              autofocus: true,
                              keyboardType: TextInputType.name,
                              // onEditingComplete: (){
                              //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                              // },
                              // onFieldSubmitted: (val){
                              //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                              // },
                              validator: (val){
                                if(val!.isEmpty){
                                  return 'Field is required';
                                }else{
                                  return '';
                                }
                              },
                              onChanged: (val){
                                 //_keyLastName.currentState!.validate();
                              },
                              decoration: InputDecoration(
                                counterText: "",
                                contentPadding: EdgeInsets.only(top: 5,left: 5),
                              ),
                              maxLength: 40,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                              ],
                              style: TextStyle(fontSize: 15),
                              controller: lastNameController,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  // SizedBox(
                  //   width: width,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       KText(
                  //         text: "Email *",
                  //         style: GoogleFonts.roboto(
                  //           color: Constants.lightGrey,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //       TextFormField(
                  //         key: _keyEmail,
                  //         keyboardType: TextInputType.emailAddress,
                  //         //focusNode: firstNameFocusNode,
                  //         autofocus: true,
                  //         // onEditingComplete: (){
                  //         //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                  //         // },
                  //         // onFieldSubmitted: (val){
                  //         //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                  //         // },
                  //         validator: (val){
                  //           if(!isEmail(val!)){
                  //             return 'Please enter a valid email.';
                  //           }else{
                  //             return '';
                  //           }
                  //         },
                  //         onChanged: (val){
                  //           //_keyEmail.currentState!.validate();
                  //         },
                  //         decoration: InputDecoration(
                  //           counterText: "",
                  //           contentPadding: EdgeInsets.only(top: 5,left: 5),
                  //         ),
                  //         maxLength: 40,
                  //         inputFormatters: [
                  //           //FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                  //         ],
                  //         style: TextStyle(fontSize: 15),
                  //         controller: emailController,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 30),
                  SizedBox(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: "Phone *",
                          style: GoogleFonts.roboto(
                            color: Constants.lightGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextFormField(
                          key: _keyPhone,
                          readOnly: true,
                          keyboardType: TextInputType.phone,
                          //focusNode: firstNameFocusNode,
                          autofocus: true,
                          // onEditingComplete: (){
                          //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                          // },
                          // onFieldSubmitted: (val){
                          //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                          // },
                          validator: (val){
                            if(val!.isEmpty) {
                              return 'Field is required';
                            } else if(val.length != 10){
                              return 'number must be 10 digits';
                            }else{
                              return '';
                            }
                          },
                          onChanged: (val){
                            //_keyPhone.currentState!.validate();
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: EdgeInsets.only(top: 5,left: 5),
                          ),
                          maxLength: 10,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          style: TextStyle(fontSize: 15),
                          controller: phoneController,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width / 2.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: "Age *",
                              style: GoogleFonts.roboto(
                                color: Constants.lightGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextFormField(
                              key: _keyAge,
                              //focusNode: firstNameFocusNode,
                              keyboardType: TextInputType.number,
                              autofocus: true,
                              // onEditingComplete: (){
                              //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                              // },
                              // onFieldSubmitted: (val){
                              //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                              // },
                              validator: (val){
                                if(val!.isEmpty){
                                  return 'Field is required';
                                }else{
                                  return '';
                                }
                              },
                              onChanged: (val){
                                //_keyAge.currentState!.validate();
                              },
                              decoration: InputDecoration(
                                counterText: "",
                                contentPadding: EdgeInsets.only(top: 5,left: 5),
                              ),
                              maxLength: 3,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              ],
                              style: TextStyle(fontSize: 15),
                              controller: ageController,
                            )
                          ],
                        ),
                      ),
                      // SizedBox(width: width / 68.3),
                      // SizedBox(
                      //   width: width / 2.4,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       KText(
                      //         text: "City *",
                      //         style: GoogleFonts.roboto(
                      //           color: Constants.lightGrey,
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.w400,
                      //         ),
                      //       ),
                      //       TextFormField(
                      //         key: _keyCity,
                      //         //focusNode: firstNameFocusNode,
                      //         keyboardType: TextInputType.name,
                      //         autofocus: true,
                      //         // onEditingComplete: (){
                      //         //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                      //         // },
                      //         // onFieldSubmitted: (val){
                      //         //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                      //         // },
                      //         validator: (val){
                      //           if(val!.isEmpty){
                      //             return 'Field is required';
                      //           }else{
                      //             return '';
                      //           }
                      //         },
                      //         onChanged: (val){
                      //           //_keyCity.currentState!.validate();
                      //         },
                      //         decoration: InputDecoration(
                      //           counterText: "",
                      //           contentPadding: EdgeInsets.only(top: 5,left: 5),
                      //         ),
                      //         maxLength: 40,
                      //         inputFormatters: [
                      //           FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                      //         ],
                      //         style: TextStyle(fontSize: 15),
                      //         controller: cityController,
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 30),
                  KText(
                    text: "Gender",
                    style: GoogleFonts.roboto(
                      color: Constants.lightGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      ListTile(
                        title: KText(text: 'Male',style: TextStyle()),
                        leading: Radio(
                          value: genderEnum.Male,
                          groupValue: genderController,
                          onChanged: (genderEnum? value) {
                            setState(() {
                              genderController = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: KText(text: 'Female',style: TextStyle()),
                        leading: Radio(
                          value: genderEnum.Female,
                          groupValue: genderController,
                          onChanged: (genderEnum? value) {
                            setState(() {
                              genderController = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: KText(text: 'Other',style: TextStyle()),
                        leading: Radio(
                          value: genderEnum.Others,
                          groupValue: genderController,
                          onChanged: (genderEnum? value) {
                            setState(() {
                              genderController = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: "Aadhaar Number *",
                          style: GoogleFonts.roboto(
                            color: Constants.lightGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextFormField(
                          key: _keyAadhar,
                          keyboardType: TextInputType.number,
                          //focusNode: firstNameFocusNode,
                          autofocus: true,
                          // onEditingComplete: (){
                          //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                          // },
                          // onFieldSubmitted: (val){
                          //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                          // },
                          validator: (val){
                            if(val!.isEmpty) {
                              return 'Field is required';
                            } else if(val.length != 12){
                              return 'number must be 12 digits';
                            }else{
                              return '';
                            }
                          },
                          onChanged: (val){
                            //_keyAadhar.currentState!.validate();
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: EdgeInsets.only(top: 5,left: 5),
                          ),
                          maxLength: 12,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          style: TextStyle(fontSize: 15),
                          controller: aadhaarNumberController,
                        )
                      ],
                    ),
                  ),

                  // SizedBox(height: 30),
                  // SizedBox(
                  //   width: width,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       KText(
                  //         text: "Address *",
                  //         style: GoogleFonts.roboto(
                  //           color: Constants.lightGrey,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //       TextFormField(
                  //         key: _keyAddress,
                  //         //focusNode: firstNameFocusNode,
                  //         keyboardType: TextInputType.streetAddress,
                  //         autofocus: true,
                  //         // onEditingComplete: (){
                  //         //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                  //         // },
                  //         // onFieldSubmitted: (val){
                  //         //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                  //         // },
                  //         validator: (val){
                  //           if(val!.isEmpty){
                  //             return 'Field is required';
                  //           }else{
                  //             return '';
                  //           }
                  //         },
                  //         onChanged: (val){
                  //           //_keyAddress.currentState!.validate();
                  //         },
                  //         decoration: InputDecoration(
                  //           counterText: "",
                  //           contentPadding: EdgeInsets.only(top: 5,left: 5),
                  //         ),
                  //         maxLength: 200,
                  //         inputFormatters: [
                  //           //FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                  //         ],
                  //         style: TextStyle(fontSize: 15),
                  //         controller: addressController,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  //SizedBox(height: 30),
                  // KText(
                  //     text: "Professional Details",
                  //     style: GoogleFonts.roboto(
                  //       color: Constants.darkBlack,
                  //       fontWeight: FontWeight.w600,
                  //       fontSize: 18,
                  //     )
                  // ),
                  // SizedBox(height: 30),
                  // Container(
                  //   width: width,
                  //   decoration:  BoxDecoration(
                  //       border: Border(
                  //           bottom: BorderSide(width:width/910.66,color: Colors.grey)
                  //       )
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       KText(
                  //         text: "Select your profession category *",
                  //         style: GoogleFonts.roboto(
                  //           color: Constants.lightGrey,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //       DropdownButton(
                  //         value: categoryController.text,
                  //         isExpanded: true,
                  //         underline: Container(),
                  //         icon: Icon(Icons.keyboard_arrow_down),
                  //         items: [
                  //           "Select Category",
                  //           "Doctor",
                  //           "Caretaker",
                  //           "Nurse"
                  //         ].map((items) {
                  //           return DropdownMenuItem(
                  //             value: items,
                  //             child: Text(items),
                  //           );
                  //         }).toList(),
                  //         onChanged: (newValue) {
                  //           setState(() {
                  //             categoryController.text = newValue!;
                  //           });
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //SizedBox(height: 30),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SizedBox(
                  //       width: width / 2.4,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           KText(
                  //             text: "Total years of Exp *",
                  //             style: GoogleFonts.roboto(
                  //               color: Constants.lightGrey,
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w400,
                  //             ),
                  //           ),
                  //           TextFormField(
                  //             key: _keyYearOfExp,
                  //             //focusNode: firstNameFocusNode,
                  //             keyboardType: TextInputType.number,
                  //             autofocus: true,
                  //             // onEditingComplete: (){
                  //             //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                  //             // },
                  //             // onFieldSubmitted: (val){
                  //             //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                  //             // },
                  //             validator: (val){
                  //               if(val!.isEmpty){
                  //                 return 'Field is required';
                  //               }else{
                  //                 return '';
                  //               }
                  //             },
                  //             onChanged: (val){
                  //                //_keyYearOfExp.currentState!.validate();
                  //             },
                  //             decoration: InputDecoration(
                  //               counterText: "",
                  //               contentPadding: EdgeInsets.only(top: 5,left: 5),
                  //             ),
                  //             maxLength: 3,
                  //             inputFormatters: [
                  //               FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  //             ],
                  //             style: TextStyle(fontSize: 15),
                  //             controller: yearOfExperienceController,
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(width: width / 68.3),
                  //     SizedBox(
                  //       width: width / 2.4,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           KText(
                  //             text: "Position *",
                  //             style: GoogleFonts.roboto(
                  //               color: Constants.lightGrey,
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w400,
                  //             ),
                  //           ),
                  //           TextFormField(
                  //             key: _keyPosition,
                  //             //focusNode: firstNameFocusNode,
                  //             keyboardType: TextInputType.text,
                  //             autofocus: true,
                  //             // onEditingComplete: (){
                  //             //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                  //             // },
                  //             // onFieldSubmitted: (val){
                  //             //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                  //             // },
                  //             validator: (val){
                  //               if(val!.isEmpty){
                  //                 return 'Field is required';
                  //               }else{
                  //                 return '';
                  //               }
                  //             },
                  //             onChanged: (val){
                  //                //_keyPosition.currentState!.validate();
                  //             },
                  //             decoration: InputDecoration(
                  //               counterText: "",
                  //               contentPadding: EdgeInsets.only(top: 5,left: 5),
                  //             ),
                  //             maxLength: 40,
                  //             inputFormatters: [
                  //               FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                  //             ],
                  //             style: TextStyle(fontSize: 15),
                  //             controller: positionController,
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 30),
                  // SizedBox(
                  //   width: width,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       KText(
                  //         text: "Are you currently working *",
                  //         style: GoogleFonts.roboto(
                  //           color: Constants.lightGrey,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //       SizedBox(height: 10),
                  //       ToggleSwitch(
                  //         minWidth: width,
                  //         minHeight: 35.0,
                  //         fontSize: 16.0,
                  //         initialLabelIndex: 1,
                  //         activeBgColor: [Constants.primaryAppColor],
                  //         activeFgColor: Colors.white,
                  //         inactiveBgColor: Colors.grey,
                  //         inactiveFgColor: Colors.grey[900],
                  //         totalSwitches: 2,
                  //         labels: ['Yes', 'No'],
                  //         onToggle: (index) {
                  //           if(index == 0){
                  //            // setState(() {
                  //               isCurrentlyWorking = true;
                  //             //});
                  //           }else{
                  //            // setState(() {
                  //               isCurrentlyWorking = false;
                  //            // });
                  //           }
                  //           print(isCurrentlyWorking);
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //SizedBox(height: 30),
                  // SizedBox(
                  //   width: width,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       KText(
                  //         text: "Organization Name *",
                  //         style: GoogleFonts.roboto(
                  //           color: Constants.lightGrey,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //       TextFormField(
                  //         key: _keyOrgName,
                  //         controller: orgNameController,
                  //         //focusNode: firstNameFocusNode,
                  //         keyboardType: TextInputType.name,
                  //         autofocus: true,
                  //         // onEditingComplete: (){
                  //         //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                  //         // },
                  //         // onFieldSubmitted: (val){
                  //         //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                  //         // },
                  //         validator: (val){
                  //           if(val!.isEmpty){
                  //             return 'Field is required';
                  //           }else{
                  //             return '';
                  //           }
                  //         },
                  //         onChanged: (val){
                  //           //_keyOrgName.currentState!.validate();
                  //         },
                  //         decoration: InputDecoration(
                  //           counterText: "",
                  //           contentPadding: EdgeInsets.only(top: 5,left: 5),
                  //         ),
                  //         maxLength: 40,
                  //         inputFormatters: [
                  //           FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                  //         ],
                  //         style: TextStyle(fontSize: 15),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 30),
                  // SizedBox(
                  //   width: width,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       KText(
                  //         text: "About yourself",
                  //         style: GoogleFonts.roboto(
                  //           color: Constants.lightGrey,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //       TextFormField(
                  //         //key: _keyFirstname,
                  //         //focusNode: firstNameFocusNode,
                  //         keyboardType: TextInputType.text,
                  //         autofocus: true,
                  //         // onEditingComplete: (){
                  //         //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                  //         // },
                  //         // onFieldSubmitted: (val){
                  //         //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                  //         // },
                  //         validator: (val){
                  //           if(val!.isEmpty){
                  //             return 'Field is required';
                  //           }else{
                  //             return '';
                  //           }
                  //         },
                  //         onChanged: (val){
                  //           // _keyFirstname.currentState!.validate();
                  //         },
                  //         decoration: InputDecoration(
                  //           counterText: "",
                  //           contentPadding: EdgeInsets.only(top: 5,left: 5),
                  //         ),
                  //         maxLength: 200,
                  //         inputFormatters: [
                  //          // FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                  //         ],
                  //         style: TextStyle(fontSize: 15),
                  //         controller: aboutController,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 30),
              InkWell(
                  onTap: () async {
                    if(!isLoading){
                      setState(() {
                        isLoading = true;
                      });
                       _keyFirstName.currentState!.validate();
                       _keyLastName.currentState!.validate();
                       _keyPhone.currentState!.validate();
                       //_keyEmail.currentState!.validate();
                       _keyAge.currentState!.validate();
                        //_keyCity.currentState!.validate();
                        _keyAadhar.currentState!.validate();
                        //_keyAddress.currentState!.validate();
                        // _keyYearOfExp.currentState!.validate();
                        // _keyOrgName.currentState!.validate();
                        // _keyPosition.currentState!.validate();
                        // _keyOrgName.currentState!.validate();
                      if(
                       firstNameController.text != "" &&
                        lastNameController.text != "" &&
                        phoneController.text != "" &&
                        aadhaarNumberController.text.length == 12 &&
                        //emailController.text != "" &&
                        ageController.text != ""
                        //cityController.text != "" &&
                         //positionController.text != "" &&
                           //orgNameController.text != "" &&
                           //categoryController.text != "Select Category" &&
                         //addressController.text != ""
                      ){
                        String downloadUrl = "";
                        String? fcmToken = await FirebaseMessaging.instance.getToken();
                        if(profileImage != null){
                          downloadUrl =  await uploadImageToStorage(profileImage!);
                        }
                        CareTakersModel careTaker = CareTakersModel(
                          gender: genderController.name,
                          orgName: orgNameController.text,
                          isCurrentlyWorking: isCurrentlyWorking,
                          name: firstNameController.text,
                          category : categoryController.text,
                          id: widget.id,
                          lanCode: widget.lanCode,
                          fcmToken: fcmToken!,
                          age: int.parse(ageController.text.toString()),
                          phone: phoneController.text,
                          workExperience: workExperienceController.text,
                          totalWorks: 0,//int.parse(totalWorksController.text.toString()),
                          email: emailController.text,
                          location: Location(
                            lat: latitude,
                            lng: longitude,
                          ),
                          address: addressController.text,
                          subCategory: subCategoryController.text,
                          city: cityController.text,
                          yearsOfExperience: 0,
                          position: positionController.text,
                          workingAt: workingAtController.text,
                          imgUrl: downloadUrl,
                          aadharNumber: aadhaarNumberController.text,
                          timestamp: DateTime.now().millisecondsSinceEpoch,
                          workType: workPreparenceController.text, languagesKnow: [], outstation: false, plansCount: 0, subscription: false,
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CareTakerRegisterFormView(careTaker: careTaker)));
                        //downloadUrl1 =  await uploadImageToStorage(aadharImage!);
                        // Response response = await CareTakersFireCrud.addCareTaker(
                        //    
                        // );
                        // if(response.code == 200){
                        //   setState(() {
                        //     isLoading = false;
                        //   });
                        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> CareTakerMainView()));
                        // }else{
                        //   print("Failed");
                        //   setState(() {
                        //     isLoading = false;
                        //   });
                        // }
                      }else{
                        setState(() {
                          isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Constants.primaryAppColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: isLoading
                          ? CircularProgressIndicator(
                        color: Constants.primaryWhite,
                      )
                          : KText(
                        text: "Next",
                        style: GoogleFonts.poppins(
                          color: Constants.primaryWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ),
                ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<String> uploadImageToStorage(File file) async {
    var snapshot = await  FirebaseStorage.instance
        .ref()
        .child('dailyupdates')
        .child("${file.path}")
        .putFile(file);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
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
                "Please fill all fields",
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
            ),
          ],
        )),
  );


}
