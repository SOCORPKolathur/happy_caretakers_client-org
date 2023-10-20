import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/views/home_view.dart';
import 'package:happy_caretakers_client/views/messages_view.dart';
import 'package:happy_caretakers_client/views/products_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int bottomIndex = 0;

  List<TabItem> items = [
    TabItem(
      icon: Icons.account_circle_outlined,
    ),
    TabItem(
      icon: Icons.calendar_today_rounded,
    ),
    TabItem(
      icon: Icons.add,
    ),
    TabItem(
      icon: Icons.cases_outlined,
    ),
    TabItem(
      icon: Icons.message,
    ),
  ];

  List<Widget> pages = [
    HomeView(),
    Container(),
    Container(),
    ProductsView(),
    MessagesView(),
  ];


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: pages[bottomIndex],
      bottomNavigationBar:  BottomBarCreative(
        items: items,
        backgroundColor: Constants.primaryWhite,
        color: Constants.darkGrey,
        iconSize: width/13.33333333333333,
        colorSelected: Constants.primaryAppColor,
        indexSelected: bottomIndex,
        onTap: (int index) => setState(() {
          bottomIndex = index;
        }),
      ),
    );
  }
}
