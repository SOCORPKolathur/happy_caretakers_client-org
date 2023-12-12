import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:intl/intl.dart';

class CaretakerChatView extends StatefulWidget {
  const CaretakerChatView({super.key, required this.data});

  final DocumentSnapshot data;

  @override
  State<CaretakerChatView> createState() => _CaretakerChatViewState();
}

class _CaretakerChatViewState extends State<CaretakerChatView> {

  ScrollController _scrollController = new ScrollController();
  TextEditingController chatMessage = new TextEditingController();

  late DocumentSnapshot currentUser;

  setCurrentUser(user){
    currentUser = user;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: Constants.appBackgroundolor,
      body: SafeArea(
          child: FutureBuilder(
            future: FirebaseFirestore.instance.collection('CareTakers').doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder: (ctx, userSnap1){
              if(userSnap1.hasData){
                setCurrentUser(userSnap1.data!);
                DocumentSnapshot user = userSnap1.data!;
                return Column(
                  children: [
                    Container(
                      height: size.height/9.45,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Constants.primaryAppColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: size.width/22.5),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Constants.primaryWhite,
                                ),
                              ),
                              SizedBox(
                                width: size.width/45,
                              ),
                              CircleAvatar(
                                radius: size.height/32.8695652173913,
                                backgroundColor: Colors.grey.shade300,
                                //backgroundImage: NetworkImage(widget.data.get("senderImage"),
                                //),
                                child: Center(
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width/20),
                              Expanded(
                                child: SizedBox(
                                    height: size.height/9.45,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: size.width/1.8,
                                          child: Text(
                                            widget.data.get("sender"),
                                            style: GoogleFonts.poppins(
                                                color: Constants.primaryWhite,
                                                fontSize: size.width/20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height/75.6),
                    Expanded(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('CareTakers').doc(FirebaseAuth.instance.currentUser!.uid).collection('Chats').doc(widget.data.id).collection('Messages').orderBy("timestamp",descending: false).snapshots(),
                          builder: (context, messageSnap) {
                            if(messageSnap.hasData){
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Constants.appBackgroundolor,
                                padding: EdgeInsets.symmetric(vertical: height / 37.95, horizontal: width / 19.6),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      SingleChildScrollView(
                                        reverse: true,
                                        child: ListView.builder(
                                            itemCount: messageSnap.data!.docs.length,
                                            scrollDirection: Axis.vertical,
                                            controller: _scrollController,
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Column(
                                                crossAxisAlignment: messageSnap.data!.docs[index]["sender"] == "${user.get("firstName")} ${user.get("lastName")}" ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                                children: [
                                                  messageTile(Size(width, height), messageSnap.data!.docs[index].data(),
                                                    context,
                                                    messageSnap.data!.docs[index].id,
                                                    user,
                                                  ),
                                                  messageSnap.data!.docs[index]["submitdate"] == "${DateTime.now().year}-${ DateTime.now().month}-${ DateTime.now().day}" ?
                                                  Text(
                                                    'Today  ${messageSnap
                                                        .data!
                                                        .docs[index]["submittime"]}',
                                                    style: TextStyle(
                                                        fontSize: width /
                                                            40,
                                                        color: Colors
                                                            .grey,
                                                        fontWeight: FontWeight
                                                            .w700),)
                                                      :
                                                  messageSnap
                                                      .data!
                                                      .docs[index]["submitdate"] ==
                                                      "${DateTime
                                                          .now()
                                                          .year}-${ DateTime
                                                          .now()
                                                          .month}-${ DateTime
                                                          .now()
                                                          .day -
                                                          1}"
                                                      ?
                                                  Text(
                                                    'Yesterday  ${messageSnap
                                                        .data!
                                                        .docs[index]["submittime"]}',
                                                    style: TextStyle(
                                                        fontSize: width /
                                                            40,
                                                        color: Colors
                                                            .grey,
                                                        fontWeight: FontWeight
                                                            .w700),)
                                                      :
                                                  Text(
                                                    "${messageSnap
                                                        .data!
                                                        .docs[index]["submitdate"]}  ${messageSnap
                                                        .data!
                                                        .docs[index]["submittime"]}",
                                                    style: TextStyle(
                                                        fontSize: width /
                                                            40,
                                                        color: Colors
                                                            .grey,
                                                        fontWeight: FontWeight
                                                            .w700),),
                                                  Text(
                                                    '${messageSnap
                                                        .data!
                                                        .docs[index]["sender"]}',
                                                    style: TextStyle(
                                                        fontSize: width /
                                                            40,
                                                        color: Colors
                                                            .grey,
                                                        fontWeight: FontWeight
                                                            .w700),),
                                                  SizedBox(
                                                    height: height /
                                                        80,)
                                                ],
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }return Container();
                          }
                      ),
                    ),
                    Container(
                      height: height / 10.18,
                    )
                  ],
                );
              }
              return Container();
            },
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: size.height / 15,
        width: double.infinity,
        child: SizedBox(
          height: size.height / 18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Constants.primaryWhite,
                ),
                height: size.height/12.6,
                width: size.width * 0.8,
                child: TextField(
                  controller: chatMessage,
                  onEditingComplete: onSendMessag,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: size.width/36),
                    hintText: "Type your message",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(width: size.width/72),
              InkWell(
                onTap: onSendMessag,
                child: Material(
                  elevation: 2,
                  color: Constants.primaryWhite,
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                      height: size.height/12.6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Icon(
                          Icons.send,
                          color: Constants.primaryAppColor,
                        ),
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget messageTile(Size size, chatMap,BuildContext context, id,DocumentSnapshot user) {
    double width = MediaQuery.of(context).size.width;
    return Builder(builder: (_) {
      if (chatMap['type'] == "text") {
        return
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
                width: size.width,
                alignment:  chatMap['sender']== "${user.get("firstName")} ${user.get("lastName")}"? Alignment.centerRight: Alignment.centerLeft,
                child:
                GestureDetector(
                  onLongPress: () {
                    showDialog(context: context, builder: (ctx) =>
                        AlertDialog(
                          title: const Text('Are you sure delete this message'),
                          actions: [
                            TextButton(onPressed: () {
                              if(chatMap['sender'] == "${user.get("firstName")} ${user.get("lastName")}"){
                                FirebaseFirestore.instance.collection('').doc(id).delete();
                              }
                              Navigator.pop(context);
                            }, child: const Text('Delete'))
                          ],
                        ));
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 8, horizontal: 14),
                      margin: EdgeInsets.symmetric(
                          vertical: 5, horizontal: 0),
                      decoration: BoxDecoration(
                        color:  chatMap['sender']=="${user.get("firstName")} ${user.get("lastName")}"? Colors.white: Constants.primaryAppColor,
                        border: Border.all(color: chatMap['sender']=="${user.get("firstName")} ${user.get("lastName")}"? Constants.primaryAppColor
                            .withOpacity(0.65) : Constants.primaryAppColor),
                        borderRadius: BorderRadius.only(topLeft: Radius
                            .circular(15),
                          bottomLeft: chatMap['sender']=="${user.get("firstName")} ${user.get("lastName")}"? Radius.circular(15) : Radius.circular(0),
                          bottomRight: chatMap['sender']=="${user.get("firstName")} ${user.get("lastName")}"? Radius.circular(0) : Radius.circular(15),
                          topRight: Radius.circular(15),),
                      ),
                      child: Column(
                        children: [
                          Text(
                            chatMap['message'],
                            style: GoogleFonts.montserrat(
                              fontSize: width/30.15384615,
                              fontWeight: FontWeight.w500,
                              color: chatMap['sender']=="${user.get("firstName")} ${user.get("lastName")}"? Colors.black : Colors.white,
                            ),
                          ),
                        ],
                      )),
                )
            ),
          );
      }
      else {
        return SizedBox();
      }
    });
  }

  void onSendMessag() async {
    String messageText = '';
    print("object");
    messageText = chatMessage.text;
    if (chatMessage.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "message": chatMessage.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
        "submittime":"${DateFormat('hh:mm a').format(DateTime.now())}",
        "timestamp" : DateTime.now().millisecondsSinceEpoch,
        "sender": "${currentUser.get("firstName")} ${currentUser.get("lastName")}",
        "submitdate":"${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
      };
      FirebaseFirestore.instance.collection('CareTakers').doc(FirebaseAuth.instance.currentUser!.uid).collection('Chats').doc(widget.data.id).collection('Messages').add(messages);
      FirebaseFirestore.instance.collection('Users').doc(widget.data.id).collection('Chats').doc(FirebaseAuth.instance.currentUser!.uid).collection('Messages').add(messages);
      chatMessage.clear();
      await sendPushMessage(widget.data.get("senderToken"), messageText, "New message Received");
      messageText = '';
    }
    else {
      print("Enter Some Text");
    }
  }

  Future<bool> sendPushMessage(String token, String body, String title) async {
    bool isSended = false;
    try {
      var response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'key=${Constants.apiKeyForNotification}',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        isSended = true;
      } else {
        isSended = false;
      }
    } catch (e) {
      print("error push notification");
    }
    return isSended;
  }

}
