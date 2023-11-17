import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/models/care_takers_model.dart';
import 'package:happy_caretakers_client/services/care_takers_firecrud.dart';
import 'package:happy_caretakers_client/views/profile_details_view.dart';
import 'package:happy_caretakers_client/widgets/custom_profile_card.dart';
import 'package:lottie/lottie.dart';
import '../Widgets/kText.dart';
import '../widgets/appbar_search.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {

  TextEditingController searchProfessionalsController = TextEditingController();
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
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
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: height/44.47058823529412,left: width/36,right: width/36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                      text: 'Veronica John',
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
            SizedBox(height: height/75.6),
            Center(
              child: KText(
                text: 'Professionals for you',
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
                splashFactory: null,
                isScrollable: true,
                controller: tabController,
                onTap: (index){},
                unselectedLabelColor: Constants.lightGrey,
                labelColor: Constants.primaryAppColor,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                tabs: [
                  Tab(
                    text: 'Doctors',
                  ),
                  Tab(
                    text: 'Nurses',
                  ),
                  Tab(
                    text: 'Caretakers',
                  ),
                  Tab(
                    text: 'Physiotherapist',
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: size.width,
                child: StreamBuilder(
                  stream: CareTakersFireCrud.fetchCareTakers(),
                  builder: (ctx, snap){
                    if(snap.hasData){
                      List<CareTakersModel> careTakers1 = snap.data!;
                      List<CareTakersModel> careTakers = [];
                      if(searchProfessionalsController.text != ""){
                        careTakers1.forEach((element) {
                          if(element.position.toLowerCase().startsWith(searchProfessionalsController.text.toLowerCase())){
                              careTakers.add(element);
                          }
                        });
                      }else{
                          careTakers = careTakers1;
                      }
                      return ListView.builder(
                        itemCount: careTakers.length,
                        itemBuilder: (ctx, i) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: height/50.4),
                            child: CustomProfileCard(
                              careTaker: careTakers[i],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => ProfileDetailsView(id: careTakers[i].id)
                                    ));
                              },
                            ),
                          );
                        },
                      );
                    }return Container();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
