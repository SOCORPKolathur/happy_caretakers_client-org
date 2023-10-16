import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/views/home_view.dart';
import 'package:happy_caretakers_client/views/messages_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int bottomIndex = 0;

  List<TabItem> items = [
    TabItem(
      icon: Icons.person_pin,
    ),
    TabItem(
      icon: Icons.save_outlined,
    ),
    TabItem(
      icon: Icons.add,
    ),
    TabItem(
      icon: Icons.cases_outlined,
    ),
    TabItem(
      icon: Icons.message_outlined,
    ),
  ];

  List<Widget> pages = [
    HomeView(),
    Container(),
    Container(),
    Container(),
    MessagesView(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[bottomIndex],
      bottomNavigationBar:  BottomBarCreative(
        items: items,
        backgroundColor: Constants.primaryWhite,
        color: Constants.darkGrey,
        colorSelected: Constants.primaryAppColor,
        indexSelected: bottomIndex,
        onTap: (int index) => setState(() {
          bottomIndex = index;
        }),
      ),
    );
  }
}
