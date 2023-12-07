import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/models/care_takers_model.dart';
import 'package:happy_caretakers_client/services/care_takers_firecrud.dart';
import 'package:happy_caretakers_client/views/login_view.dart';
import 'package:happy_caretakers_client/views/user/profile_details_view.dart';
import 'package:happy_caretakers_client/widgets/custom_profile_card.dart';
import 'package:happy_caretakers_client/widgets/drawer_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import '../../widgets/appbar_search.dart';
import '../../widgets/kText.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {

  TextEditingController searchProfessionalsController = TextEditingController();
  TabController? tabController;

  double lat = 0.0;
  double lon = 0.0;

  @override
  void initState() {
    getLatLng();
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  getLatLng() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = position.latitude!;
      lon = position.longitude!;
    });
  }

  List<String> tabs = [
    'Doctors',
    'Nurses',
    'Caretakers',
    'Physiotherapist',
  ];

  String searchQuery = "doctor";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Constants.appBackgroundolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constants.appBackgroundolor,
        leadingWidth: width/6.792452830188679,
        leading: Row(
          children: [
            SizedBox(width: width/45),
            CircleAvatar(
              radius: height/34.36363636363636,
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTSAvhi0UxIvUoeY1ZBoYaV4q7adi8eK8Urg&usqp=CAU"),
            ),
          ],
        ),
        title: AppBarSearchWidget(
          controller: searchProfessionalsController,
          onTap:(){
            setState(() {});
          },
          onChanged: (){
            setState(() {});
          },
          onSubmitted:(){
            setState(() {});
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: height/44.47058823529412),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: width/36,right: width/36),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Hello',
                        style: GoogleFonts.poppins(
                            fontSize: width/15.65217391304348,
                            color: Constants.darkGrey,
                            fontWeight: FontWeight.w600),
                      ),
                      KText(
                        text: 'User',
                        style: GoogleFonts.poppins(
                            fontSize: width/20,
                            color: Constants.darkGrey,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(width: width/36),
                  SizedBox(
                    height: height/18.9,
                    width: width/9,
                    child: Lottie.asset('assets/hii_hand.json'),
                  )
                ],
              ),
            ),
            SizedBox(height: height/75.6),
            Center(
              child: KText(
                text: 'Professionals near you',
                style: GoogleFonts.poppins(
                    fontSize: width/20,
                    color: Constants.darkGrey,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: height/75.6),
            Container(
              height: 50,
              width: width,
              decoration: BoxDecoration(
                color: Constants.primaryWhite,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
              child: TabBar(
                tabAlignment: TabAlignment.start,
                splashFactory: null,
                isScrollable: true,
                controller: tabController,
                onTap: (index){
                  setState(() {
                    searchQuery = tabs[index].substring(0,tabs[index].length-1);
                    print(searchQuery);
                  });
                },
                unselectedLabelColor: Constants.lightGrey,
                labelColor: Constants.primaryAppColor,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                tabs: tabs.map((e) => Tab(text: e)).toList(),
              ),
            ),
            //padding: EdgeInsets.only(left: width/36,right: width/36),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: width/36,right: width/36),
                child: SizedBox(
                  width: size.width,
                  child: StreamBuilder(
                    stream: CareTakersFireCrud.fetchCareTakers(),
                    builder: (ctx, snap){
                      if(snap.hasData){
                        List<CareTakersModel> careTakers1 = snap.data!;
                        List<CareTakersModel> careTakers = [];
                        if(searchQuery != ""){
                          careTakers1.forEach((element) {
                            if(element.position.toLowerCase().startsWith(searchQuery.toLowerCase())){
                              careTakers.add(element);
                            }
                          });
                        }else{
                          careTakers = careTakers1;
                        }
                        return TabBarView(
                          controller: tabController,
                          children: [
                            ListView.builder(
                              itemCount: careTakers.length,
                              itemBuilder: (ctx, i) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: height/50.4),
                                  child: CustomProfileCard(
                                    lat: lat,
                                    lon: lon,
                                    careTaker: careTakers[i],
                                    onTap: () {
                                      if(Constants.checkUserLoginStatus()){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) => ProfileDetailsView(id: careTakers[i].id)
                                          ),
                                        );
                                      }else{
                                        showLoginPopUp();
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                            ListView.builder(
                              itemCount: careTakers.length,
                              itemBuilder: (ctx, i) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: height/50.4),
                                  child: CustomProfileCard(
                                    lat: lat,
                                    lon: lon,
                                    careTaker: careTakers[i],
                                    onTap: () {
                                      if(Constants.checkUserLoginStatus()){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) => ProfileDetailsView(id: careTakers[i].id)
                                          ),
                                        );
                                      }else{
                                        showLoginPopUp();
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                            ListView.builder(
                              itemCount: careTakers.length,
                              itemBuilder: (ctx, i) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: height/50.4),
                                  child: CustomProfileCard(
                                    lat: lat,
                                    lon: lon,
                                    careTaker: careTakers[i],
                                    onTap: () {
                                      if(Constants.checkUserLoginStatus()){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) => ProfileDetailsView(id: careTakers[i].id)
                                          ),
                                        );
                                      }else{
                                        showLoginPopUp();
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                            ListView.builder(
                              itemCount: careTakers.length,
                              itemBuilder: (ctx, i) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: height/50.4),
                                  child: CustomProfileCard(
                                    lat: lat,
                                    lon: lon,
                                    careTaker: careTakers[i],
                                    onTap: () {
                                      if(Constants.checkUserLoginStatus()){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) => ProfileDetailsView(id: careTakers[i].id)
                                          ),
                                        );
                                      }else{
                                        showLoginPopUp();
                                      }
                                    },
                                  ),
                                );
                              },
                            )
                          ],
                        );
                      }return Container();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      endDrawer: const DrawerWidget(),
    );
  }

  showLoginPopUp(){
    Dialogs.materialDialog(
        color: Colors.white,
        msg: 'You are not Logged In.Kindly log in to continue',
        title: 'Log In',
        lottieBuilder: Lottie.asset(
          'assets/logout.json',
          fit: BoxFit.contain,
        ),
        context: context,
        actions: [
          IconsButton(
            onPressed: () async {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> const LoginView(isCareTaker: false)));
            },
            text: 'Log In',
            color: Colors.blue,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
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
