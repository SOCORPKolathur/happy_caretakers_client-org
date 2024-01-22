import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/views/caretaker/caretaker_login_view.dart';
import 'package:happy_caretakers_client/views/choose_role_view.dart';
import 'package:happy_caretakers_client/views/login_view.dart';

import '../../constants.dart';
import '../../widgets/kText.dart';
import '../languages_view.dart';

class CareTakerLanguageSelectView extends StatefulWidget {
  const CareTakerLanguageSelectView({super.key});

  @override
  State<CareTakerLanguageSelectView> createState() => _CareTakerLanguageSelectViewState();
}

class _CareTakerLanguageSelectViewState extends State<CareTakerLanguageSelectView> {

  List<ChooseLanguageModel> languagesList = [
    ChooseLanguageModel(
      name: "Tamil",
      orgName: "தமிழ்",
      code: "ta",
    ),
    ChooseLanguageModel(
      name: "English",
      orgName: "English",
      code: "en_US",
    ),
    ChooseLanguageModel(
      name: "Hindi",
      orgName: "हिंदी",
      code: "hi",
    ),
    ChooseLanguageModel(
      name: "Telugu",
      orgName: "తెలుగు",
      code: "te",
    ),
    ChooseLanguageModel(
      name: "Malayalam",
      orgName: "മലയാളം",
      code: "ml",
    ),
    ChooseLanguageModel(
      name: "Kannada",
      orgName: "ಕನ್ನಡ",
      code: "kn",
    ),
    ChooseLanguageModel(
      name: "Bengali",
      orgName: "বাংলা",
      code: "bn",
    ),
    ChooseLanguageModel(
      name: "Spanish",
      orgName: "Español",
      code: "es",
    ),
    ChooseLanguageModel(
      name: "Portuguese",
      orgName: "Português",
      code: "pt",
    ),
    ChooseLanguageModel(
      name: "French",
      orgName: "Français",
      code: "fr",
    ),
    ChooseLanguageModel(
      name: "Dutch",
      orgName: "Nederlands",
      code: "nl",
    ),
    ChooseLanguageModel(
      name: "German",
      orgName: "Deutsch",
      code: "de",
    ),
    ChooseLanguageModel(
      name: "Italian",
      orgName: "Italiano",
      code: "it",
    ),
    ChooseLanguageModel(
      name: "Swedish",
      orgName: "Svenska",
      code: "sv",
    )
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryAppColor,
        centerTitle: true,
        title: KText(
          text: "Select Your Language",
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
      body: SafeArea(
          child: Stack(
            children: [
              // Container(
              //   height: size.height,
              //   width: size.width,
              //   decoration: const BoxDecoration(
              //       image: DecorationImage(
              //           fit: BoxFit.fill,
              //           image:
              //           AssetImage("assets/dolomite-alps-peaks-italy 1.png"),),
              //   ),
              // ),
              Container(
                height: size.height,
                width: size.width,
                color: Colors.white70,
              ),
              SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  children: [
                    // SizedBox(height: size.height * 0.05),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     InkWell(
                    //       onTap: (){
                    //         Navigator.pop(context);
                    //       },
                    //       child: const Icon(Icons.arrow_back),
                    //     ),
                    //     KText(
                    //       text: "Select Your Language",
                    //       style: GoogleFonts.openSans(
                    //         fontSize: size.width/22.833333333,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //     SizedBox(width: size.width/20.55)
                    //   ],
                    // ),
                    // SizedBox(height: size.height * 0.05),
                    Expanded(
                      child: SizedBox(
                          width: double.infinity,
                          child: GridView.builder(
                            itemCount: languagesList.length,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0,
                                childAspectRatio: 16 / 15),
                            itemBuilder: (BuildContext context, int i) {
                              return InkWell(
                                onTap: () {
                                  setLanguage(languagesList[i].code!);
                                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> MainView()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                                  child: Container(
                                    height: size.height/10.825,
                                    width: size.height/10.825,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff).withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          offset: Offset(1, 3),
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          languagesList[i].orgName!,
                                          style: GoogleFonts.openSans(
                                            fontSize: size.width/20.55,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: size.height/173.2),
                                        Text(
                                          languagesList[i].name!.toUpperCase(),
                                          style: GoogleFonts.openSans(
                                            fontSize: size.width/31.615384615,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }

  setLanguage(String language) async {
    await changeLocale(context, language);
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> LoginView(isCareTaker: true, lanCode: language)));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> ChooseRoleView()));

  }

}
