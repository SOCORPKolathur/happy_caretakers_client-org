import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/models/product_model.dart';
import 'package:happy_caretakers_client/views/product_details_view.dart';
import 'package:happy_caretakers_client/widgets/product_card.dart';
import 'package:lottie/lottie.dart';

import '../Widgets/kText.dart';
import '../constants.dart';
import '../widgets/appbar_search.dart';
import '../widgets/category_card_product.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> with SingleTickerProviderStateMixin {

  TextEditingController searchProductController = TextEditingController();
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
          controller: searchProductController,
          onTap: (){

          },
          onChanged: (){
            setState(() {});
          },
          onSubmitted: (){
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Eccomerce').snapshots(),
        builder: (ctx, snap){
          if(snap.hasData){
            List<ProductModel> products = [];
            snap.data!.docs.forEach((element) { 
              products.add(
                ProductModel.fromJson(element.data())
              );
            });
            return Padding(
              padding: EdgeInsets.only(top: height/44.47058823529412/*,left: width/24,right: width/24*/),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width/24),
                    child: KText(
                      text: 'Buy your neccesary thinks here,',
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                          fontSize: width/15.65217391304348,
                          color: Constants.darkGrey,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  SizedBox(height: height/75.6),
                  Container(
                    height: 50,
                    width: size.width,
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
                      labelPadding: EdgeInsets.symmetric(horizontal: 1),
                      tabs: [
                        Tab(
                          child: SizedBox(
                            width: 90,
                            child: Center(
                              child: Text(
                                "All"
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: SizedBox(
                            width: 90,
                            child: Center(
                              child: Text(
                                  "Baby"
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: SizedBox(
                            width: 90,
                            child: Center(
                              child: Text(
                                  "Senior Citizen"
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(

                            width: 90,
                            child: Center(
                              child: Text(
                                  "Other"
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height/151.2),
                  SizedBox(height: height/75.6),
                  SizedBox(height: height/75.6),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width/24),
                    child: KText(
                      text: 'Specials',
                      style: GoogleFonts.poppins(
                          fontSize: width/18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  SizedBox(height: height/75.6),
                  Expanded(
                    child: SizedBox(
                      width: size.width,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/24),
                        child: GridView.builder(
                          itemCount: products.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 16/21
                          ),
                          itemBuilder: (ctx,i){
                            ProductModel product = products[i];
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (ctx)=> ProductDetailsView(productId: product.id!, productName: product.productname!, userDocId: '')));
                              },
                              child: ProductCard(
                                title: product.productname!,
                                imgUrl: product.img!,
                                price: product.price!,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}
