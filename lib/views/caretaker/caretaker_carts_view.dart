import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/models/care_takers_model.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import '../../constants.dart';
import '../../models/cart_model.dart';
import '../../models/orders_model.dart';
import '../../models/response.dart';
import '../../services/caretker/caretker_cart_firecrud.dart';
import '../../widgets/kText.dart';

class CaretakerCartView extends StatefulWidget {
  const CaretakerCartView({super.key});


  @override
  State<CaretakerCartView> createState() => _CaretakerCartViewState();
}

class _CaretakerCartViewState extends State<CaretakerCartView> {

  bool isAltredyInCart(List<CartModel> carts, String itemId){
    bool isAltreadyIn = false;
    carts.forEach((element) {
      if(element.id == itemId){
        isAltreadyIn = true;
      }
    });
    return isAltreadyIn;
  }

  getQuantity(List<CartModel> carts, String itemId){
    int quantity = 0;
    carts.forEach((element) {
      if(element.productId == itemId){
        quantity = element.quantity!;
      }
    });
    return quantity;
  }

  double getTotalAmount(List<CartModel> products) {
    double amount = 0.0;
    for (int i = 0; i < products.length; i++) {
      amount += products[i].price! * products[i].quantity!;
    }
    return amount;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryAppColor,
        centerTitle: true,
        title: KText(
          text: "Carts",
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back,color: Colors.white),
        ),
      ),
      body: SizedBox(
          height: size.height,
          width: size.width,
          child: StreamBuilder(
            stream: CaretakerCartFireCrud.fetchCartsForUser(FirebaseAuth.instance.currentUser!.uid),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                List<CartModel> carts = snapshot.data!;
                return carts.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        "assets/no_noti.json",
                      ),
                      SizedBox(height: size.height/43.3),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: size.height/19.244444444,
                          width: size.width * 0.6,
                          decoration: BoxDecoration(
                            color: Constants.primaryAppColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child:  KText(
                              text: "Start Shopping",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
                    : Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          for (int i = 0; i < carts.length; i++)
                            Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(2, 3),
                                  )
                                ],
                              ),
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    height: size.height * 0.21,
                                    width: size.width * 0.55,
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          height: size.height/28.866666667,
                                          width: size.width * 0.45,
                                          child: KText(
                                            maxLines: 1,
                                            text: carts[i].productName!,
                                            style: GoogleFonts.urbanist(
                                              color:
                                              const Color(0xff5F5F5F),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.height/173.2),
                                        Text(
                                          "Amount :${carts[i].price!}",
                                          style: GoogleFonts.urbanist(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: size.height/173.2),
                                        Text(
                                          "Qty :${carts[i].quantity!}",
                                          style: GoogleFonts.urbanist(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: size.height/173.2),
                                        Text(
                                          r"$ " +(carts[i].price! * carts[i].quantity!).toString(),
                                          style: GoogleFonts.urbanist(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                          ),
                                        ),
                                        InkWell(
                                            child: StreamBuilder(
                                              stream: CaretakerCartFireCrud.fetchCartsForUser(FirebaseAuth.instance.currentUser!.uid),
                                              builder: (ctx,snap){
                                                if(snap.hasData){
                                                  List<CartModel> carts = snap.data!;
                                                  return Container(
                                                    height: size.height * 0.05,
                                                    width: size.width * 0.46,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Constants.primaryAppColor,
                                                    ),
                                                    child: Center(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            InkWell(
                                                              onTap: (){
                                                                int qty = getQuantity(carts,carts[i].productId!)-1;
                                                                if(qty == 0){
                                                                  CaretakerCartFireCrud.deleteCart(userDocId: FirebaseAuth.instance.currentUser!.uid, docId: carts[i].productId!);
                                                                }else{
                                                                  CaretakerCartFireCrud.updateCartQuantity(userDocId: FirebaseAuth.instance.currentUser!.uid, docId: carts[i].productId!,quantity: qty);
                                                                }
                                                              },
                                                              child: Icon(
                                                                Icons.remove_circle_outline,
                                                                color: Colors.white,
                                                                size: size.height * 0.035,
                                                              ),
                                                            ),
                                                            SizedBox(width: size.width/41.1),
                                                            KText(
                                                              text: getQuantity(carts,carts[i].productId!).toString(),
                                                              style: GoogleFonts.openSans(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            SizedBox(width: size.width/41.1),
                                                            InkWell(
                                                              onTap:(){
                                                                int qty = getQuantity(carts,carts[i].productId!)+1;
                                                                CaretakerCartFireCrud.updateCartQuantity(userDocId: FirebaseAuth.instance.currentUser!.uid, docId: carts[i].productId!,quantity: qty);
                                                              },
                                                              child: Icon(
                                                                Icons.add_circle_outline,
                                                                color: Colors.white,
                                                                size: size.height * 0.035,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                    ),
                                                  );
                                                }return Container();
                                              },
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: size.height * 0.16,
                                    width: size.width * 0.3,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: CachedNetworkImageProvider(
                                            carts[i].imgUrl!,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                    bottomBar(size, carts)
                  ],
                );
              }
              return Container();
            },
          )),
    );
  }

  bottomBar(Size size, List<CartModel> carts) {
    return Material(
      elevation: 3,
      child: FutureBuilder(
        future: FirebaseFirestore.instance.collection('CareTakers').doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder: (ctx, userSnap){
          if(userSnap.hasData){
            CareTakersModel careTakersModel = CareTakersModel.fromJson(userSnap.data!.data() as Map<String, dynamic>);
            return Container(
              height: size.height * 0.071,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(-1, -3),
                  )
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      KText(
                        text: "Total Price : ",
                        style: GoogleFonts.urbanist(
                          color: const Color(0xff5F5F5F),
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: size.width/51.375),
                      SizedBox(
                        width: size.width * 0.35,
                        child: KText(
                          text: getTotalAmount(carts).toString(),
                          style: GoogleFonts.urbanist(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        List<Products> tempProducts = [];
                        carts.forEach((element) {
                          tempProducts.add(Products(
                              quantity: element.quantity,
                              imgUrl: element.imgUrl,
                              price: element.price,
                              name: element.productName,
                              id: element.productId));
                        });
                        Response response = await CaretakerCartFireCrud.addToOrder(
                          userDocId: FirebaseAuth.instance.currentUser!.uid,
                          phone: careTakersModel.phone,
                          method: "method",
                          status: "Ordered",
                          userName: careTakersModel.firstName + careTakersModel.lastName,
                          amount: getTotalAmount(carts),
                          products: tempProducts,
                          address: careTakersModel.address,
                        );
                        if (response.code == 200) {
                          for (int k = 0; k < carts.length; k++) {
                            Response res = await CaretakerCartFireCrud.deleteCart(
                                userDocId: FirebaseAuth.instance.currentUser!.uid, docId: carts[k].productId!);
                          }


                          Dialogs.materialDialog(
                              color: Colors.white,
                              msg: 'Order placed Successfully',
                              title: 'Success',
                              lottieBuilder: Lottie.asset(
                                'assets/logout.json',
                                fit: BoxFit.contain,
                              ),
                              context: context,
                              actions: [
                                IconsButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  text: 'Ok',
                                  color: Colors.blue,
                                  textStyle: TextStyle(color: Colors.white),
                                  iconColor: Colors.white,
                                ),
                              ]
                          );

                        } else {
                          // CoolAlert.show(
                          //     context: context,
                          //     type: CoolAlertType.error,
                          //     text: "Failed to Order",
                          //     width: size.width * 0.4,
                          //     backgroundColor:
                          //     Constants.primaryAppColor.withOpacity(0.8));
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(1),
                        height: size.height * 0.059,
                        width: size.width * 0.3,
                        decoration: BoxDecoration(
                          color: Constants.primaryAppColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: KText(
                            text: "Checkout",
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }return Container();
        },
      ),
    );
  }
}
