import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/widgets/product_card.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';
import '../widgets/appbar_search.dart';
import '../widgets/category_card_product.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
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
          controller: TextEditingController(),
          onTap: (){

          },
          onSubmitted: (){

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
        padding: EdgeInsets.only(top: height/44.47058823529412,left: width/24,right: width/24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Buy your neccesary thinks here,',
              maxLines: 2,
              style: GoogleFonts.poppins(
                  fontSize: width/15.65217391304348,
                  color: Constants.darkGrey,
                  fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: height/75.6),
            Container(
              height: height/7.56,
              width: size.width,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx,i){
                  return Padding(
                    padding: EdgeInsets.only(right: width/36),
                    child: CategoryCardProduct(
                      name: 'Senior Citizen',
                      icon: Icons.child_care_rounded,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: height/151.2),
            Text(
              'Specials',
              style: GoogleFonts.poppins(
                  fontSize: width/18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: height/75.6),
            Expanded(
              child: SizedBox(
                width: size.width,
                child: GridView.builder(
                  itemCount: 8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 16/21
                  ),
                  itemBuilder: (ctx,i){
                    return ProductCard(
                      title: 'Prouct $i',
                      imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTSAvhi0UxIvUoeY1ZBoYaV4q7adi8eK8Urg&usqp=CAU',
                      price: (i + 1) * 100.0,
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
