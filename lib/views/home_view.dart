import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/views/profile_details_view.dart';
import 'package:happy_caretakers_client/widgets/custom_profile_card.dart';
import '../widgets/appbar_search.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.appBackgroundolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constants.appBackgroundolor,
        leadingWidth: 53,
        leading: Row(
          children: [
            SizedBox(width: 8),
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTSAvhi0UxIvUoeY1ZBoYaV4q7adi8eK8Urg&usqp=CAU"),
            ),
          ],
        ),
        title: const AppBarSearchWidget(),
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
        padding: const EdgeInsets.only(top: 17,left: 17,right: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello',
                      style: GoogleFonts.poppins(
                          fontSize: 23,
                          color: Constants.darkGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Veronica John',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Constants.darkGrey,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 40,
                  width: 60,
                )
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Professionals for you',
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Constants.darkGrey,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SizedBox(
                width: size.width,
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: CustomProfileCard(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      const ProfileDetailsView()));
                        },
                      ),
                    );
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
