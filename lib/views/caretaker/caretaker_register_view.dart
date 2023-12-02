import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/models/care_takers_model.dart';
import 'package:happy_caretakers_client/models/response.dart';
import 'package:happy_caretakers_client/services/care_takers_firecrud.dart';
import 'package:happy_caretakers_client/views/caretaker/caretaker_main_view.dart';
import 'package:happy_caretakers_client/views/root_app.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/kText.dart';

class CaretakerRegisterView extends StatefulWidget {
  const CaretakerRegisterView({super.key,required this.id, required this.phone});

  final String id;
  final String phone;

  @override
  State<CaretakerRegisterView> createState() => _CaretakerRegisterViewState();
}

class _CaretakerRegisterViewState extends State<CaretakerRegisterView> {

  double latitude = 0.0;
  double longitude = 0.0;

  File? profileImage;
  XFile? imageForShow;

  File? aadharImage;
  XFile? aadharImageForShow;


  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController workExperienceController = TextEditingController();
  TextEditingController totalWorksController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController workingAtController = TextEditingController();
  TextEditingController workPreparenceController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController yearOfExperienceController = TextEditingController(text: '0');

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
        aboutController.clear();
        addressController.clear();
    });
  }


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

  pickAadharImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        aadharImage = File(pickedFile.path);
        aadharImageForShow = pickedFile;
      });
    } else {
      print('No image selected.');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: Constants.appBackgroundolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "assets/hct_logo.png",
                    height: height/9.45,
                    width: width/4.5,
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(
                      text: "Register as a Caretaker in",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Constants.lightGrey,
                      ),
                    ),
                    KText(
                      text: "Happy Caretakers",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Constants.primaryAppColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Center(
                    child: Container(
                      height: 150,
                      width: 150,
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
                            KText(
                              text: "Profile Photo",
                              style: GoogleFonts.poppins(
                                color: Constants.primaryWhite,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ):null,
                    )
                ),
                const SizedBox(height: 10),
                Center(
                  child: InkWell(
                    onTap: (){
                      pickImage();
                    },
                    child: Container(
                      height: 40,
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Constants.primaryAppColor,
                          width: 3,
                        ),
                      ),
                      child: Center(
                        child: KText(
                            text: "Change Profile Picture",
                            style: TextStyle(
                              color: Constants.primaryAppColor,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.person, color: Constants.primaryAppColor),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText: 'First Name',
                        hintStyle: TextStyle(
                          color: Constants.lightGrey,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.person, color: Constants.primaryAppColor),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText: 'Last Name',
                        hintStyle: TextStyle(
                          color: Constants.lightGrey,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.phone, color: Constants.primaryAppColor),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText: 'Phone',
                        hintStyle: TextStyle(
                          color: Constants.lightGrey,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.alternate_email, color: Constants.primaryAppColor),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Constants.lightGrey,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.location_city, color: Constants.primaryAppColor),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText: 'City',
                        hintStyle: TextStyle(
                          color: Constants.lightGrey,
                        ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: ageController,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.circle, color: Constants.primaryAppColor),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText: 'Age',
                        hintStyle: TextStyle(
                          color: Constants.lightGrey,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: yearOfExperienceController,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.person, color: Constants.primaryAppColor),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText: 'Years of Experience',
                        hintStyle: TextStyle(
                          color: Constants.lightGrey,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: totalWorksController,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.person, color: Constants.primaryAppColor),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText: 'Total Works',
                        hintStyle: TextStyle(
                          color: Constants.lightGrey,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: positionController,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.person, color: Constants.primaryAppColor),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText: 'Position',
                        hintStyle: TextStyle(
                          color: Constants.lightGrey,
                        ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: workingAtController,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.person, color: Constants.darkGrey),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText: 'Working At',
                        hintStyle: TextStyle(
                          color: Constants.lightGrey,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: workPreparenceController,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.person, color: Constants.darkGrey),
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText: 'Work Preference',
                        hintStyle: TextStyle(
                          color: Constants.lightGrey,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: workExperienceController,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText: 'Work Experience',
                        hintStyle: TextStyle(
                          color: Constants.lightGrey,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: aboutController,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText: 'About',
                        hintStyle: TextStyle(
                          color: Constants.lightGrey,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: addressController,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        hintText: 'Address',
                        hintStyle: TextStyle(
                          color: Constants.lightGrey,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                    child: InkWell(
                      onTap: (){
                        pickAadharImage();
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Constants.primaryAppColor,
                          image: aadharImageForShow != null
                              ? DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(aadharImage!)
                          ) : null,
                          //     : DecorationImage(
                          //     fit: BoxFit.fill,
                          //     image: NetworkImage(oldImgUrl)
                          // ),
                        ),
                        child: aadharImageForShow == null ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                color: Constants.primaryWhite,
                                size: 40,
                              ),
                              KText(
                                text: "Aadhaar Photo",
                                style: GoogleFonts.poppins(
                                  color: Constants.primaryWhite,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ):null,
                      ),
                    )
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    if(!isLoading){
                      setState(() {
                        isLoading = true;
                      });
                      if(
                       firstNameController.text != "" &&
                        lastNameController.text != "" &&
                        phoneController.text != "" &&
                        emailController.text != "" &&
                        ageController.text != "" &&
                        cityController.text != "" &&
                        workExperienceController.text != "" &&
                        totalWorksController.text != "" &&
                         positionController.text != "" &&
                        workingAtController.text != "" &&
                        workPreparenceController.text != "" &&
                        aboutController.text != "" &&
                         addressController.text != ""
                      ){
                        String downloadUrl = "";
                        String downloadUrl1 = "";
                        String? fcmToken = await FirebaseMessaging.instance.getToken();
                        downloadUrl =  await uploadImageToStorage(profileImage!);
                        downloadUrl1 =  await uploadImageToStorage(aadharImage!);
                        Response response = await CareTakersFireCrud.addCareTaker(
                            CareTakersModel(
                              firstName: firstNameController.text,
                              id: widget.id,
                              lastName: lastNameController.text,
                              age: int.parse(ageController.text.toString()),
                              phone: phoneController.text,
                              rating: [],
                              workExperience: workExperienceController.text,
                              totalWorks: int.parse(totalWorksController.text.toString()),
                              email: emailController.text,
                              location: Location(
                                lat: latitude,
                                lng: longitude,
                              ),
                              address: addressController.text,
                              about: aboutController.text,
                              city: cityController.text,
                              yearsOfExperience: int.parse(yearOfExperienceController.text.toString()),
                              position: positionController.text,
                              workingAt: workingAtController.text,
                              imgUrl: downloadUrl,
                              aadharUrl: downloadUrl1,
                              timestamp: DateTime.now().millisecondsSinceEpoch,
                              workPreparence: workPreparenceController.text,
                            )
                        );
                        if(response.code == 200){
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> CareTakerMainView()));
                        }else{
                          print("Failed");
                          setState(() {
                            isLoading = false;
                          });
                        }
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
                        text: "Register",
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
