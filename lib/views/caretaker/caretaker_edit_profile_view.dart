import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../constants.dart';
import '../../models/care_takers_model.dart';
import '../../models/response.dart';
import '../../services/care_takers_firecrud.dart';
import '../../widgets/kText.dart';

class CaretakerEditProfileView extends StatefulWidget {
  const CaretakerEditProfileView({super.key, required this.careTaker});

  final CareTakersModel careTaker;
  @override
  State<CaretakerEditProfileView> createState() => _CaretakerEditProfileViewState();
}

class _CaretakerEditProfileViewState extends State<CaretakerEditProfileView> {

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
  TextEditingController aboutController = TextEditingController();
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
      aboutController.clear();
      aadhaarNumberController.clear();
      orgNameController.clear();
      addressController.clear();
      categoryController.text = "Select Category";
      isCurrentlyWorking = false;
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
      phoneController.text = widget.careTaker.phone;
      firstNameController.text = widget.careTaker.firstName;
      lastNameController.text = widget.careTaker.lastName;
      emailController.text = widget.careTaker.email;
      ageController.text = widget.careTaker.age.toString();
      aadhaarNumberController.text = widget.careTaker.aadharNumber;
      aadhaarNumberController.text = widget.careTaker.aadharNumber;
      addressController.text = widget.careTaker.address;
      orgNameController.text = widget.careTaker.orgName;
      aboutController.text = widget.careTaker.about;
      categoryController.text = widget.careTaker.category;
      cityController.text = widget.careTaker.city;
      yearOfExperienceController.text = widget.careTaker.yearsOfExperience.toString();
      positionController.text = widget.careTaker.position;
      isCurrentlyWorking = widget.careTaker.isCurrentlyWorking;
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
                      text: "Edit Profile",
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
                            )
                                : DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(widget.careTaker.imgUrl)
                            ),
                            border: Border.all(color: Constants.primaryAppColor,width: 3),
                          ),
                          child: (imageForShow == null && widget.careTaker.imgUrl == "") ? Center(
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
                          ) : null,
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
                  SizedBox(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: "Email *",
                          style: GoogleFonts.roboto(
                            color: Constants.lightGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextFormField(
                          key: _keyEmail,
                          keyboardType: TextInputType.emailAddress,
                          //focusNode: firstNameFocusNode,
                          autofocus: true,
                          // onEditingComplete: (){
                          //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                          // },
                          // onFieldSubmitted: (val){
                          //   FocusScope.of(context).requestFocus(lastNameFocusNode);
                          // },
                          validator: (val){
                            if(!isEmail(val!)){
                              return 'Please enter a valid email.';
                            }else{
                              return '';
                            }
                          },
                          onChanged: (val){
                            //_keyEmail.currentState!.validate();
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: EdgeInsets.only(top: 5,left: 5),
                          ),
                          maxLength: 40,
                          inputFormatters: [
                            //FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                          ],
                          style: TextStyle(fontSize: 15),
                          controller: emailController,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
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
                      SizedBox(width: width / 68.3),
                      SizedBox(
                        width: width / 2.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: "City *",
                              style: GoogleFonts.roboto(
                                color: Constants.lightGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextFormField(
                              key: _keyCity,
                              //focusNode: firstNameFocusNode,
                              keyboardType: TextInputType.name,
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
                                //_keyCity.currentState!.validate();
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
                              controller: cityController,
                            )
                          ],
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
                  SizedBox(height: 30),
                  SizedBox(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: "Address *",
                          style: GoogleFonts.roboto(
                            color: Constants.lightGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextFormField(
                          key: _keyAddress,
                          //focusNode: firstNameFocusNode,
                          keyboardType: TextInputType.streetAddress,
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
                            //_keyAddress.currentState!.validate();
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: EdgeInsets.only(top: 5,left: 5),
                          ),
                          maxLength: 200,
                          inputFormatters: [
                            //FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                          ],
                          style: TextStyle(fontSize: 15),
                          controller: addressController,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  KText(
                      text: "Professional Details",
                      style: GoogleFonts.roboto(
                        color: Constants.darkBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      )
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: width,
                    decoration:  BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width:width/910.66,color: Colors.grey)
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: "Select your profession category *",
                          style: GoogleFonts.roboto(
                            color: Constants.lightGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        DropdownButton(
                          value: categoryController.text,
                          isExpanded: true,
                          underline: Container(),
                          icon: Icon(Icons.keyboard_arrow_down),
                          items: [
                            "Select Category",
                            "Doctor",
                            "Caretaker",
                            "Nurse"
                          ].map((items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              categoryController.text = newValue!;
                            });
                          },
                        ),
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
                              text: "Total years of Exp *",
                              style: GoogleFonts.roboto(
                                color: Constants.lightGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextFormField(
                              key: _keyYearOfExp,
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
                                //_keyYearOfExp.currentState!.validate();
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
                              controller: yearOfExperienceController,
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
                              text: "Position *",
                              style: GoogleFonts.roboto(
                                color: Constants.lightGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextFormField(
                              key: _keyPosition,
                              //focusNode: firstNameFocusNode,
                              keyboardType: TextInputType.text,
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
                                //_keyPosition.currentState!.validate();
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
                              controller: positionController,
                            )
                          ],
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
                          text: "Are you currently working *",
                          style: GoogleFonts.roboto(
                            color: Constants.lightGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        ToggleSwitch(
                          minWidth: width,
                          minHeight: 35.0,
                          fontSize: 16.0,
                          initialLabelIndex: 1,
                          activeBgColor: [Constants.primaryAppColor],
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.grey[900],
                          totalSwitches: 2,
                          labels: ['Yes', 'No'],
                          onToggle: (index) {
                            if(index == 0){
                              // setState(() {
                              isCurrentlyWorking = true;
                              //});
                            }else{
                              // setState(() {
                              isCurrentlyWorking = false;
                              // });
                            }
                            print(isCurrentlyWorking);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: "Organization Name *",
                          style: GoogleFonts.roboto(
                            color: Constants.lightGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextFormField(
                          key: _keyOrgName,
                          controller: orgNameController,
                          //focusNode: firstNameFocusNode,
                          keyboardType: TextInputType.name,
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
                            //_keyOrgName.currentState!.validate();
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
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: "About yourself",
                          style: GoogleFonts.roboto(
                            color: Constants.lightGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextFormField(
                          //key: _keyFirstname,
                          //focusNode: firstNameFocusNode,
                          keyboardType: TextInputType.text,
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
                            // _keyFirstname.currentState!.validate();
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: EdgeInsets.only(top: 5,left: 5),
                          ),
                          maxLength: 200,
                          inputFormatters: [
                            // FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                          ],
                          style: TextStyle(fontSize: 15),
                          controller: aboutController,
                        )
                      ],
                    ),
                  ),
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
                        _keyEmail.currentState!.validate();
                        _keyAge.currentState!.validate();
                        _keyCity.currentState!.validate();
                        _keyAadhar.currentState!.validate();
                        _keyAddress.currentState!.validate();
                        _keyYearOfExp.currentState!.validate();
                        _keyOrgName.currentState!.validate();
                        _keyPosition.currentState!.validate();
                        _keyOrgName.currentState!.validate();
                        if(
                        firstNameController.text != "" &&
                            lastNameController.text != "" &&
                            phoneController.text != "" &&
                            phoneController.text.length == 10 &&
                            aadhaarNumberController.text.length == 12 &&
                            emailController.text != "" &&
                            ageController.text != "" &&
                            cityController.text != "" &&
                            positionController.text != "" &&
                            orgNameController.text != "" &&
                            categoryController.text != "Select Category" &&
                            addressController.text != ""
                        ){
                          String downloadUrl = "";
                          String? fcmToken = await FirebaseMessaging.instance.getToken();
                          if(profileImage != null){
                            downloadUrl =  await uploadImageToStorage(profileImage!);
                          }
                          //downloadUrl1 =  await uploadImageToStorage(aadharImage!);
                          Response response = await CareTakersFireCrud.updateCareTaker(
                              CareTakersModel(
                                orgName: orgNameController.text,
                                isCurrentlyWorking: isCurrentlyWorking,
                                firstName: firstNameController.text,
                                category : categoryController.text,
                                id: widget.careTaker.id,
                                fcmToken: fcmToken!,
                                lastName: lastNameController.text,
                                age: int.parse(ageController.text.toString()),
                                phone: phoneController.text,
                                rating: [],
                                workExperience: workExperienceController.text,
                                totalWorks: 0,//int.parse(totalWorksController.text.toString()),
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
                                imgUrl: downloadUrl != "" ? downloadUrl : widget.careTaker.imgUrl,
                                aadharNumber: aadhaarNumberController.text,
                                timestamp: DateTime.now().millisecondsSinceEpoch,
                                workPreparence: workPreparenceController.text,
                              )
                          );
                          if(response.code == 200){
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context);
                            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> CareTakerMainView()));
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
