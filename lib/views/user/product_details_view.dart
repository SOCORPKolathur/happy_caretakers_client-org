import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/services/cart_firecrud.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:photo_view/photo_view.dart';
import '../../constants.dart';
import '../../models/cart_model.dart';
import '../../models/product_model.dart';
import '../../models/response.dart';
import '../../widgets/kText.dart';
import '../login_view.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView(
      {super.key,
      required this.productId,
      required this.productName});

  final String productId;
  final String productName;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  ProductModel currentProduct = ProductModel();
  List<String> categories = [];

  bool isAltredyInCart(List<CartModel> carts, String itemId) {
    bool isAltreadyIn = false;
    carts.forEach((element) {
      print(element.id);
      print(itemId);
      if (element.productId == itemId) {
        isAltreadyIn = true;
      }
    });
    return isAltreadyIn;
  }

  getQuantity(List<CartModel> carts, String itemId) {
    int quantity = 0;
    carts.forEach((element) {
      if (element.productId == itemId) {
        quantity = element.quantity!;
      }
    });
    return quantity;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
        backgroundColor: Constants.primaryAppColor,
        appBar: AppBar(
          backgroundColor: Constants.primaryAppColor,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: FirebaseAuth.instance.currentUser != null ? SafeArea(
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('Eccomerce')
                .doc(widget.productId)
                .get(),
            builder: (ctx, snap) {
              if (snap.hasData) {
                currentProduct = ProductModel.fromJson(
                    snap.data!.data() as Map<String, dynamic>);
                categories.clear();
                categories.addAll(currentProduct.categoty!.split(','));
                return Container(
                  height: height,
                  width: width,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 190,
                        child: Container(
                          height: height,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 65),
                                  KText(
                                    text: currentProduct.description!,
                                    style: GoogleFonts.poppins(
                                      color: Constants.lightGrey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          currentProduct.productname!,
                                          maxLines: 4,
                                          style: GoogleFonts.urbanist(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "1 Unit",
                                        style: GoogleFonts.urbanist(
                                          color: Constants.lightGrey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 28.0),
                                    child: Divider(),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 250,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Price : ",
                                                  style: GoogleFonts.urbanist(
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                Text(
                                                  currentProduct.price.toString(),
                                                  style: GoogleFonts.urbanist(
                                                    color: Constants.lightGrey,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17,
                                                    decoration: TextDecoration.lineThrough,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 250,
                                            child: Text(
                                              "₹ ${currentProduct.price.toString()}",
                                              style: GoogleFonts.urbanist(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.center,
                                      //   children: [
                                      //     InkWell(
                                      //       onTap: (){
                                      //         // int qty = getQuantity(carts,products[i].productId!)-1;
                                      //         // if(qty == 0){
                                      //         //   CaretakerCartFireCrud.deleteCart(userDocId: widget.userDocId, docId: products[i].productId!);
                                      //         // }else{
                                      //         //   CaretakerCartFireCrud.updateCartQuantity(userDocId: widget.userDocId, docId: products[i].productId!,quantity: qty);
                                      //         // }
                                      //       },
                                      //       child: Icon(
                                      //         Icons.remove_circle,
                                      //         color: Constants.primaryAppColor,
                                      //         size: size.height * 0.035,
                                      //       ),
                                      //     ),
                                      //     SizedBox(width: size.width/41.1),
                                      //     KText(
                                      //       text: "1",
                                      //       //text: getQuantity(carts,products[i].productId!).toString(),
                                      //       style: GoogleFonts.openSans(
                                      //         color: Constants.primaryAppColor,
                                      //         fontWeight: FontWeight.bold,
                                      //         fontSize: 14,
                                      //       ),
                                      //     ),
                                      //     SizedBox(width: size.width/41.1),
                                      //     InkWell(
                                      //       onTap:(){
                                      //         // int qty = getQuantity(carts,products[i].productId!)+1;
                                      //         // CaretakerCartFireCrud.updateCartQuantity(userDocId: widget.userDocId, docId: products[i].productId!,quantity: qty);
                                      //       },
                                      //       child: Icon(
                                      //         Icons.add_circle,
                                      //         color: Constants.primaryAppColor,
                                      //         size: size.height * 0.035,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // )
                                    ],
                                  ),
                                  SizedBox(height: 400),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Constants.primaryAppColor, width: 3),
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: CachedNetworkImageProvider(
                                currentProduct.img!,
                              )
                            )
                          ),
                        )
                      ),
                    ],
                  ),
                );
              }
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                  // child: Lottie.asset(
                  //   'assets/churchLoading.json',
                  //   fit: BoxFit.contain,
                  //   height: size.height * 0.4,
                  //   width: size.width * 0.7,
                  // ),
                ),
              );
            },
          ),
        )
            :  FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Eccomerce')
              .doc(widget.productId)
              .get(),
          builder: (ctx, snap) {
            if (snap.hasData) {
              currentProduct = ProductModel.fromJson(
                  snap.data!.data() as Map<String, dynamic>);
              categories.clear();
              categories.addAll(currentProduct.categoty!.split(','));
              return Container(
                height: height,
                width: width,
                child: Stack(
                  children: [
                    Positioned(
                      top: 190,
                      child: Container(
                        height: height,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 65),
                                KText(
                                  text: currentProduct.description!,
                                  style: GoogleFonts.poppins(
                                    color: Constants.lightGrey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 250,
                                      child: Text(
                                        currentProduct.productname!,
                                        maxLines: 4,
                                        style: GoogleFonts.urbanist(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "1 Unit",
                                      style: GoogleFonts.urbanist(
                                        color: Constants.lightGrey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 28.0),
                                  child: Divider(),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: 250,
                                          child: Row(
                                            children: [
                                              Text(
                                                "Price : ",
                                                style: GoogleFonts.urbanist(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              Text(
                                                currentProduct.price.toString(),
                                                style: GoogleFonts.urbanist(
                                                  color: Constants.lightGrey,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 17,
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 250,
                                          child: Text(
                                            "₹ ${currentProduct.price.toString()}",
                                            style: GoogleFonts.urbanist(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     InkWell(
                                    //       onTap: (){
                                    //         // int qty = getQuantity(carts,products[i].productId!)-1;
                                    //         // if(qty == 0){
                                    //         //   CaretakerCartFireCrud.deleteCart(userDocId: widget.userDocId, docId: products[i].productId!);
                                    //         // }else{
                                    //         //   CaretakerCartFireCrud.updateCartQuantity(userDocId: widget.userDocId, docId: products[i].productId!,quantity: qty);
                                    //         // }
                                    //       },
                                    //       child: Icon(
                                    //         Icons.remove_circle,
                                    //         color: Constants.primaryAppColor,
                                    //         size: size.height * 0.035,
                                    //       ),
                                    //     ),
                                    //     SizedBox(width: size.width/41.1),
                                    //     KText(
                                    //       text: "1",
                                    //       //text: getQuantity(carts,products[i].productId!).toString(),
                                    //       style: GoogleFonts.openSans(
                                    //         color: Constants.primaryAppColor,
                                    //         fontWeight: FontWeight.bold,
                                    //         fontSize: 14,
                                    //       ),
                                    //     ),
                                    //     SizedBox(width: size.width/41.1),
                                    //     InkWell(
                                    //       onTap:(){
                                    //         // int qty = getQuantity(carts,products[i].productId!)+1;
                                    //         // CaretakerCartFireCrud.updateCartQuantity(userDocId: widget.userDocId, docId: products[i].productId!,quantity: qty);
                                    //       },
                                    //       child: Icon(
                                    //         Icons.add_circle,
                                    //         color: Constants.primaryAppColor,
                                    //         size: size.height * 0.035,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // )
                                  ],
                                ),
                                SizedBox(height: 400),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Constants.primaryAppColor, width: 3),
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: CachedNetworkImageProvider(
                                    currentProduct.img!,
                                  )
                              )
                          ),
                        )
                    ),
                  ],
                ),
              );
            }
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
                // child: Lottie.asset(
                //   'assets/churchLoading.json',
                //   fit: BoxFit.contain,
                //   height: size.height * 0.4,
                //   width: size.width * 0.7,
                // ),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FirebaseAuth.instance.currentUser != null ? FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Eccomerce')
              .doc(widget.productId)
              .get(),
          builder: (ctx, snaps) {
            if (snaps.hasData) {
              ProductModel product = ProductModel.fromJson(
                  snaps.data!.data() as Map<String, dynamic>);
              return SizedBox(
                height: size.height / 11,
                width: size.width,
                child: SizedBox(
                  height: size.height / 18,
                  child: Center(
                      child: InkWell(
                          onTap: () async {
                             Response response = await CartFireCrud.addToCart(userDocId: FirebaseAuth.instance.currentUser!.uid, price: product.price!, imgUrl: product.img!, quantity: 1, productId: product.id!, productName: product.productname!);
                          },
                          child: StreamBuilder(
                            stream: CartFireCrud.fetchCartsForUser(FirebaseAuth.instance.currentUser!.uid),
                            builder: (ctx, snap) {
                              if (snap.hasData) {
                                List<CartModel> carts = snap.data!;
                                CartModel cart = CartModel();
                                carts.forEach((element) {
                                  if (element.productId == widget.productId) {
                                    cart = element;
                                  }
                                });
                                return Container(
                                  height: size.height * 0.06,
                                  width: size.width * 0.85,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Constants.primaryAppColor,
                                  ),
                                  child: Center(
                                    child: isAltredyInCart(carts, widget.productId)
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  int qty = getQuantity(carts,widget.productId)-1;
                                                  if(qty == 0){
                                                    CartFireCrud.deleteCart(userDocId: FirebaseAuth.instance.currentUser!.uid, docId: cart.productId!);
                                                  }else{
                                                    CartFireCrud.updateCartQuantity(userDocId: FirebaseAuth.instance.currentUser!.uid, docId: cart.productId!,quantity: qty);
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.remove_circle_outline,
                                                  color: Colors.white,
                                                  size: size.height * 0.045,
                                                ),
                                              ),
                                              SizedBox(
                                                  width: size.width / 31.1),
                                              KText(
                                                //text: "get Quantity",
                                                text: getQuantity(carts,widget.productId).toString(),
                                                style: GoogleFonts.openSans(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  //fontSize: Constants().getFontSize(context, "M"),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: size.width / 31.1),
                                              InkWell(
                                                onTap: () {
                                                  int qty = getQuantity(carts,widget.productId)+1;
                                                  CartFireCrud.updateCartQuantity(userDocId: FirebaseAuth.instance.currentUser!.uid, docId: cart.productId!,quantity: qty);
                                                },
                                                child: Icon(
                                                  Icons.add_circle_outline,
                                                  color: Colors.white,
                                                  size: size.height * 0.045,
                                                ),
                                              ),
                                            ],
                                          )
                                        : InkWell(
                                            onTap: () async {
                                              Response response = await CartFireCrud.addToCart(userDocId: FirebaseAuth.instance.currentUser!.uid, price: product.price!, imgUrl: product.img!, quantity: 1, productId: product.productid!, productName: product.productname!);
                                            },
                                            child: Center(
                                              child: KText(
                                                text: "Add Cart",
                                                style: GoogleFonts.openSans(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                );
                              }
                              return Container();
                            },
                          ))),
                ),
              );
            }
            return Container();
          },
        )
            : SizedBox(
          height: size.height / 11,
          width: size.width,
          child: SizedBox(
            height: size.height / 18,
            child: Center(
                child: Container(
                  height: size.height * 0.06,
                  width: size.width * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Constants.primaryAppColor,
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () async {
                        showLoginPopUp();
                      },
                      child: Center(
                        child: KText(
                          text: "Add Cart",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ),
          ),
        ),
    );
  }

  showImageModel(context, String imgUrl) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return PhotoView(
          imageProvider: CachedNetworkImageProvider(
            imgUrl,
          ),
        );
      },
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> const LoginView(isCareTaker: false,lanCode: 'en_US')));
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
