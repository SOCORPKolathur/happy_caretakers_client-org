import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/views/home_view.dart';
import 'package:happy_caretakers_client/views/messages_view.dart';
import 'package:happy_caretakers_client/views/products_view.dart';
import 'package:happy_caretakers_client/views/profile_view.dart';
import 'package:inkblob_navigation_bar/inkblob_navigation_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  late PageController _pageController;
  bool _animatingPage = false;
  int _selectedIndex = 0;
  int _previousIndex = 0;

  //int bottomIndex = 0;

  // List<TabItem> items = [
  //   TabItem(
  //     icon: Icons.account_circle_outlined,
  //   ),
  //   TabItem(
  //     icon: Icons.calendar_today_rounded,
  //   ),
  //   TabItem(
  //     icon: Icons.add,
  //   ),
  //   TabItem(
  //     icon: Icons.cases_outlined,
  //   ),
  //   TabItem(
  //     icon: Icons.message,
  //   ),
  // ];

  List<Widget> pages = [
    HomeView(),
    Container(),
    Container(),
    ProductsView(),
    MessagesView(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _animatingPage = true;
      _previousIndex = _selectedIndex;
      _selectedIndex = index;
      _pageController
          .animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      )
          .then((value) {
        _animatingPage = false;
        _previousIndex = _selectedIndex;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      //body: pages[bottomIndex],
      // bottomNavigationBar:  BottomBarCreative(
      //   items: items,
      //   backgroundColor: Constants.primaryWhite,
      //   color: Constants.darkGrey,
      //   iconSize: width/13.33333333333333,
      //   colorSelected: Constants.primaryAppColor,
      //   indexSelected: bottomIndex,
      //   onTap: (int index) => setState(() {
      //     bottomIndex = index;
      //   }),
      // ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            if (!_animatingPage) {
              setState(() {
                _previousIndex = _selectedIndex;
                _selectedIndex = index;
              });
            }
          },
          children: <Widget>[
            HomeView(),
            MessagesView(),
            ProductsView(),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: InkblobNavigationBar(
        selectedIndex: _selectedIndex,
        previousIndex: _previousIndex,
        onItemSelected: _onItemTapped,
        containerHeight: 60,
        showElevation: false,
        //curve: Curves.bounceOut,
        animationDuration: const Duration(milliseconds: 500),
        items: <InkblobBarItem>[
          InkblobBarItem(
            title: Text(
              'Home',
              style: TextStyle(fontWeight: FontWeight.w500, color: Constants.lightGrey,),
            ),
            filledIcon: Icon(
              Icons.home,
              size: 35,
              color: Constants.primaryAppColor,
            ),
            emptyIcon: Icon(
              Icons.home_outlined,
              size: 30,
              color: Constants.lightGrey,
            ),
            color: Constants.primaryAppColor,
          ),
          InkblobBarItem(
            title: Text(
              'Messages',
              style: TextStyle(fontWeight: FontWeight.w500, color: Constants.lightGrey,),
            ),
            filledIcon: Icon(
              Icons.message,
              size: 35,
              color: Constants.primaryAppColor,
            ),
            emptyIcon: Icon(
              Icons.message_outlined,
              size: 30,
              color: Constants.lightGrey,
            ),
            color: Constants.primaryAppColor,
          ),
          InkblobBarItem(
            title: Text(
              'Products',
              style: TextStyle(fontWeight: FontWeight.w500, color: Constants.lightGrey,),
            ),
            filledIcon: Icon(
              Icons.shopping_cart_rounded,
              size: 35,
              color: Constants.primaryAppColor,
            ),
            emptyIcon: Icon(
                Icons.shopping_cart_outlined,
              size: 30,
              color: Constants.lightGrey,
            ),
            color: Constants.primaryAppColor,
          ),
          InkblobBarItem(
            title: Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.w500, color: Constants.lightGrey,),
            ),
            filledIcon: Icon(
              Icons.person,
              size: 35,
              color: Constants.primaryAppColor,
            ),
            emptyIcon: Icon(
              Icons.person_outline_sharp,
              size: 30,
              color: Constants.lightGrey,
            ),
            color: Constants.primaryAppColor,
          ),
        ],
      ),
    );
  }
}
