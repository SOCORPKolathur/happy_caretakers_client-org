import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../widgets/kText.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryAppColor,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Constants.primaryWhite,
          ),
        ),
        title: KText(
          text: "Your Orders",
          style: GoogleFonts.montserrat(
            color: Constants.primaryWhite,
            fontWeight: FontWeight.w500,
            fontSize: width / 18.947368421,
          ),
        ),
      ),
    );
  }
}
