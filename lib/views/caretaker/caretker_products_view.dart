import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/models/care_takers_model.dart';
import 'package:happy_caretakers_client/models/product_model.dart';
import 'package:happy_caretakers_client/views/caretaker/caretaker_product_details_view.dart';
import 'package:happy_caretakers_client/widgets/product_card.dart';
import 'package:lottie/lottie.dart';
import '../../constants.dart';
import '../../widgets/appbar_search.dart';
import '../../widgets/caretaker_drawer_widget.dart';
import '../../widgets/kText.dart';

class CaretakerProductsView extends StatefulWidget {
  const CaretakerProductsView({super.key, required this.caretaker});

  final CareTakersModel caretaker;

  @override
  State<CaretakerProductsView> createState() => _CaretakerProductsViewState();
}

class _CaretakerProductsViewState extends State<CaretakerProductsView> with SingleTickerProviderStateMixin {

  TextEditingController searchProductController = TextEditingController();
  TabController? tabController;

  String searchQuery = "All";

  List<ProductModel> totalProducts = [];
  List<ProductModel> searchedProducts = [];

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    getProducts();
    super.initState();
  }

  List<String> tabs = [
    "All",
    "Baby",
    "Senior Citizen"
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  getProducts() async {
    var productDoc = await FirebaseFirestore.instance.collection('Eccomerce').get();
    for(int p = 0; p < productDoc.docs.length; p++){
      setState(() {
        totalProducts.add(ProductModel.fromJson(productDoc.docs[p].data()));
      });
    }
  }

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
                backgroundColor: Colors.white,
                radius: height/34.36363636363636,
                backgroundImage: widget.caretaker.imgUrl != ""  ? NetworkImage(widget.caretaker.imgUrl) : null,
                 child: Visibility(
                 visible: widget.caretaker.imgUrl == "",
                  child: Lottie.asset(
                    "assets/profile.json",
                     height: 200,
                  ),
               ),
              ),
            ],
          ),
          title: AppBarSearchWidget(
            isProduct: true,
            controller: searchProductController,
            onTap: (){

            },
            onChanged: (){
              setState(() {
                totalProducts.forEach((element) {
                  if(element.productname!.toLowerCase().startsWith(searchProductController.text)){
                    setState(() {
                      if(!searchedProducts.contains(element)){
                        searchedProducts.add(element);
                      }
                    });
                  }
                });
              });
            },
            onSubmitted: (){
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
        body: searchProductController.text != ""
            ? Padding(
          padding: EdgeInsets.only(top: height/44.47058823529412/*,left: width/24,right: width/24*/),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: searchedProducts.length,
                    itemBuilder: (ctx, i){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Constants.primaryWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 60,
                              decoration: BoxDecoration(
                                color: Constants.lightGrey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(searchedProducts[i].img!),
                                )
                              ),
                            ),
                            title: Text(
                              searchedProducts[i].productname!,
                              style: GoogleFonts.poppins(

                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "₹ "+searchedProducts[i].price!.toString(),
                                style: GoogleFonts.poppins(

                                ),
                              ),
                            ),
                            trailing: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CaretakersProductDetailsView(productId: searchedProducts[i].id!, productName: searchedProducts[i].productname!,userDocId: FirebaseAuth.instance.currentUser!.uid)));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Constants.primaryAppColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                  child: Text(
                                    "View",
                                    style: GoogleFonts.poppins(
                                      color: Constants.primaryWhite,
                                      fontSize: 13
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        )
            : Padding(
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
                  onTap: (index){
                    setState(() {
                      searchQuery = tabs[index];
                    });
                  },
                  unselectedLabelColor: Constants.lightGrey,
                  labelColor: Constants.primaryAppColor,
                  labelPadding: EdgeInsets.symmetric(horizontal: 1),
                  tabs: tabs.map((e) => Tab(
                    child: SizedBox(
                      width: 90,
                      child: Center(
                        child: Text(
                            e
                        ),
                      ),
                    ),
                  )).toList(),
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
                child: TabBarView(
                  controller: tabController,
                  children: [
                    buildAllProducts(),
                    buildBabyProducts(),
                    buildSeniorCitizenProducts(),
                  ],
                ),
              )
            ],
          ),
        ),
      endDrawer: CaretakerDrawerWidget(caretaker: widget.caretaker),
    );
  }

  buildAllProducts(){
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Eccomerce').snapshots(),
      builder: (ctx, snap){
        if(snap.hasData){
          List<ProductModel> products = [];
          snap.data!.docs.forEach((element) {
            products.add(ProductModel.fromJson(element.data()));
          });
          print(products.length);
          return SizedBox(
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
                      Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CaretakersProductDetailsView(productId: product.id!, productName: product.productname!,userDocId: FirebaseAuth.instance.currentUser!.uid)));
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
          );
        }return Container();
      },
    );
  }

  buildBabyProducts(){
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Eccomerce').snapshots(),
      builder: (ctx, snap){
        if(snap.hasData){
          List<ProductModel> products = [];
          snap.data!.docs.forEach((element) {
            if(element.get("categoty").toString().toLowerCase().contains("baby")){
              products.add(ProductModel.fromJson(element.data()));
            }
          });
          print(products.length);
          return SizedBox(
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
                      Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CaretakersProductDetailsView(productId: product.id!, productName: product.productname!,userDocId: FirebaseAuth.instance.currentUser!.uid)));
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
          );
        }return Container();
      },
    );
  }

  buildSeniorCitizenProducts(){
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Eccomerce').snapshots(),
      builder: (ctx, snap){
        if(snap.hasData){
          List<ProductModel> products = [];
          snap.data!.docs.forEach((element) {
            if(element.get("categoty").toString().toLowerCase().contains("senior citizen")){
              products.add(ProductModel.fromJson(element.data()));
            }
          });
          print(products.length);
          return SizedBox(
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
                      Navigator.push(context, MaterialPageRoute(builder: (ctx)=> CaretakersProductDetailsView(productId: product.id!, productName: product.productname!,userDocId: FirebaseAuth.instance.currentUser!.uid)));
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
          );
        }return Container();
      },
    );
  }

}
