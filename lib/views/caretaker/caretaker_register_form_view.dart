import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/models/care_takers_model.dart';
import 'package:happy_caretakers_client/views/caretaker/widgets/selection_checkbox.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../models/response.dart';
import '../../services/care_takers_firecrud.dart';
import '../../widgets/kText.dart';
import 'caretaker_main_view.dart';

enum workCategory { Doctor, Caretaker, Nurse, Physiotherapist }
enum subCategory{AAA,BBB,CCC,DDD,FFF}

class CareTakerRegisterFormView extends StatefulWidget {
  const CareTakerRegisterFormView({super.key,required this.careTaker});

  final CareTakersModel careTaker;
  @override
  State<CareTakerRegisterFormView> createState() => _CareTakerRegisterFormViewState();
}

class _CareTakerRegisterFormViewState extends State<CareTakerRegisterFormView> {
  bool ifOutstation = false;
  int expIndex = 0;
  String selectedWorkType = "";
  double latitude = 0.0;
  double longitude = 0.0;

  List<String> expDataList = [
    "0 - 1",
    "2 - 3",
    "Above 3",
  ];

  workCategory workCategoryValue = workCategory.Doctor;
  subCategory subCategoryValue = subCategory.AAA;
  CareTakersModel? careTaker;

  TextEditingController subCategoryController = TextEditingController();
  TextEditingController workTypeController = TextEditingController();
  @override
  void initState() {
    getLocation();
    setData();
    super.initState();
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

  setData() {
    setState(() {
      careTaker = CareTakersModel(
          name: widget.careTaker.name,
          id: widget.careTaker.id,
          lanCode: widget.careTaker.lanCode,
          fcmToken: widget.careTaker.fcmToken,
          phone: widget.careTaker.phone,
          workExperience: widget.careTaker.workExperience,
          isCurrentlyWorking: widget.careTaker.isCurrentlyWorking,
          category: widget.careTaker.category,
          location: widget.careTaker.location,
         subCategory: widget.careTaker.subCategory,
          yearsOfExperience: widget.careTaker.yearsOfExperience,
          imgUrl: widget.careTaker.imgUrl,
          aadharNumber: widget.careTaker.aadharNumber,
          timestamp: widget.careTaker.timestamp,
          workType: widget.careTaker.workType, languagesKnow: widget.careTaker.languagesKnow,  plansCount: widget.careTaker.plansCount, subscription: widget.careTaker.subscription, ifOutstation: widget.careTaker.ifOutstation, createdDate: '',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: Constants.appBackgroundolor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Constants.primaryAppColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText(
                text: "Your Work Preference",
                style: TextStyle(
                  color: Constants.primaryAppColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: <Widget>[
                  ListTile(
                    title: KText(text: 'Doctor',style: TextStyle()),
                    leading: Radio(
                      value: workCategory.Doctor,
                      groupValue: workCategoryValue,
                      onChanged: (workCategory? value) {
                        setState(() {
                          workCategoryValue = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: KText(text: 'Caretaker',style: TextStyle()),
                    leading: Radio(
                      value: workCategory.Caretaker,
                      groupValue: workCategoryValue,
                      onChanged: (workCategory? value) {
                        setState(() {
                          workCategoryValue = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: KText(text: 'Nurse',style: TextStyle()),
                    leading: Radio(
                      value: workCategory.Nurse,
                      groupValue: workCategoryValue,
                      onChanged: (workCategory? value) {
                        setState(() {
                          workCategoryValue = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: KText(text: 'Physiotherapist',style: TextStyle()),
                    leading: Radio(
                      value: workCategory.Physiotherapist,
                      groupValue: workCategoryValue,
                      onChanged: (workCategory? value) {
                        setState(() {
                          workCategoryValue = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              KText(
                text: "Your Experience",
                style: TextStyle(
                  color: Constants.primaryAppColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 150,
                width: width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: expDataList.length,
                  itemBuilder: (ctx, i){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            expIndex = i;
                          });
                        },
                        child: Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 140,
                            width: 110,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Constants.primaryAppColor,
                                  blurRadius: 4,
                                  offset: Offset(-2, 3),
                                )
                              ]
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: expIndex != i ? Constants.primaryWhite : Constants.primaryAppColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                      child: KText(
                                        text: expDataList[i],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: expIndex == i ? Constants.primaryWhite : Constants.primaryAppColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  KText(
                                    text: "Years",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Constants.primaryAppColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              KText(
                text: "SubCategory",
                style: TextStyle(
                  color: Constants.primaryAppColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),

              SizedBox(height: 10),
              Column(
                children: <Widget>[
                  ListTile(
                    title: KText(text: 'AAA',style: TextStyle()),
                    leading: Radio(
                      value: subCategory.AAA,
                      groupValue: subCategoryValue,
                      onChanged: (subCategory? value) {
                        setState(() {
                          subCategoryValue = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: KText(text: 'BBB',style: TextStyle()),
                    leading: Radio(
                      value: subCategory.BBB,
                      groupValue: subCategoryValue,
                      onChanged: (subCategory? value) {
                        setState(() {
                          subCategoryValue = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: KText(text: 'CCC',style: TextStyle()),
                    leading: Radio(
                      value: subCategory.CCC,
                      groupValue: subCategoryValue,
                      onChanged: (subCategory? value) {
                        setState(() {
                          subCategoryValue = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: KText(text: 'DDD',style: TextStyle()),
                    leading: Radio(
                      value: subCategory.DDD,
                      groupValue: subCategoryValue,
                      onChanged: (subCategory? value) {
                        setState(() {
                          subCategoryValue = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WorkTypeSelection(
                      onWorkTypeSelected: (String selectedType) {
                        setState(() {
                          selectedWorkType = selectedType;
                          workTypeController.text = selectedWorkType;
                        });
                      },
                      workTypeController: workTypeController,
                    ),

                  ],
                ),
              ),
              KText(
                text: "Languages Known",
                style: TextStyle(
                  color: Constants.primaryAppColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),

              SizedBox(height: 10),
              Column(
                children: <Widget>[
                  ListTile(
                    title: KText(text: 'AAA',style: TextStyle()),
                    leading: Radio(
                      value: subCategory.AAA,
                      groupValue: subCategoryValue,
                      onChanged: (subCategory? value) {
                        setState(() {
                          subCategoryValue = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: KText(text: 'BBB',style: TextStyle()),
                    leading: Radio(
                      value: subCategory.BBB,
                      groupValue: subCategoryValue,
                      onChanged: (subCategory? value) {
                        setState(() {
                          subCategoryValue = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: KText(text: 'CCC',style: TextStyle()),
                    leading: Radio(
                      value: subCategory.CCC,
                      groupValue: subCategoryValue,
                      onChanged: (subCategory? value) {
                        setState(() {
                          subCategoryValue = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: KText(text: 'DDD',style: TextStyle()),
                    leading: Radio(
                      value: subCategory.DDD,
                      groupValue: subCategoryValue,
                      onChanged: (subCategory? value) {
                        setState(() {
                          subCategoryValue = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: "Are you willing to work out of stations ?",
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
                            ifOutstation = true;
                            //});
                          }else{
                            // setState(() {
                            ifOutstation = false;
                            // });
                          }
                          print(ifOutstation);
                        },
                      ),
                    ]
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  bool isPaid = false;
                  careTaker!.subCategory = subCategoryValue.name;
                  careTaker!.workExperience = expDataList[expIndex];
                  careTaker!.category = workCategoryValue.name;
                  careTaker!.location = Location(lat: latitude,lng: longitude);
                  print(careTaker!.toJson());
                  await showPaymentPopUp(context);
                  isPaid = true;
                  if(isPaid){
                    Response response = await CareTakersFireCrud.addCareTaker(
                        careTaker!
                    );
                    if(response.code == 200){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> CareTakerMainView()));
                    }else{
                      print("Failed");

                    }
                  }else{

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
                      child: KText(
                        text: "Submit",
                        style: GoogleFonts.poppins(
                          color: Constants.primaryWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                ),

              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }


  showPaymentPopUp(context){
    return Dialogs.materialDialog(
        color: Colors.white,
        msg: 'Pay 200 rs to continue',
        msgStyle: GoogleFonts.poppins(

        ),
        msgAlign: TextAlign.center,
        title: 'Pay Now',
        lottieBuilder: Lottie.asset(
          'assets/logout.json',
          fit: BoxFit.contain,
        ),
        context: context,
        actions: [
          IconsButton(
            onPressed: () async {
              // FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).update({
              //   "subscriptionCount" : 10,
              // });
              Navigator.pop(context,true);
              return true;
            },
            text: 'Pay Now',
            color: Colors.blue,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
          IconsButton(
            onPressed: () {
              Navigator.pop(context,false);
              return false;
            },
            text: 'Cancel',
            color: Colors.grey,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]
    );
  }


}
