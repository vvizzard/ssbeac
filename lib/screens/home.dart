import 'dart:convert';

import 'package:argon_flutter/helper/csv_helpers.dart';
import 'package:argon_flutter/helper/database_helpers.dart';
import 'package:flutter/material.dart';

import 'package:argon_flutter/constants/Theme.dart';
import 'package:http/http.dart' as http;

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/card-horizontal.dart';
import 'package:argon_flutter/widgets/card-small.dart';
import 'package:argon_flutter/widgets/card-square.dart';
import 'package:argon_flutter/widgets/drawer.dart';

final Map<String, Map<String, String>> homeCards = {
  "Menage": {
    "title": "Ménage",
    "image":
        "assets/img/menage.png"
  },
  "Charbonnier": {
    "title": "Charbonnier",
    "image":
        "assets/img/charbonnier.jpg"
  },
  "DonneeSecondaire": {
    "title": "Données secondaires",
    "image":
        "assets/img/donnee.jpg"
  },
  "Barriere": {
    "title": "Barrière",
    "image":
        "assets/img/barrier.png"
  },
  "Reboisement": {
    "title": "Reboisement",
    "image":
        "assets/img/barrier.png"
  },
  "Pepiniere": {
    "title": "Pépiniere",
    "image":
        "assets/img/barrier.png"
  },
  "ProducteurFoyer": {
    "title": "Producteurs de foyer",
    "image":
    "assets/img/barrier.png"
  },
  "ProducteurEnergie": {
    "title": "Producteurs d'énergie",
    "image":
    "assets/img/barrier.png"
  }
};

class Home extends StatelessWidget {
  // final GlobalKey _scaffoldKey = new GlobalKey();
  DatabaseHelper helper = DatabaseHelper.instance;

  Future<int> synchro() async {
    // DatabaseHelper helper = DatabaseHelper.instance;
    Map<String, List> toSend = {};
    Future<int> valiny;
    helper.queryAllMenageString().then((value) => {
      
      for (var menage in value) {
        synchronisation(menage, 'add.php')
      },
      helper.queryAllEnergieCuissonString().then((value1) => {
        
        for (var ec in value1) {
          synchronisation(ec, 'ec')
        }
      }),
      helper.queryAllCharbonnierString().then((value2) => {
        
        for (var ch in value2) {
          synchronisation(ch, 'charbonnier')
        }
      }),
      helper.queryAllMeuleString().then((value3) => {
        
        for (var m in value3) {
          synchronisation(m, 'meule')
        }
      }),
      helper.queryAllBarriereString().then((value4) => {
        
        for (var b in value4) {
          synchronisation(b, 'barriere')
        }
      }),
      helper.queryAllProduitString().then((value5) => {
        
        for (var p in value5) {
          synchronisation(p, 'produit')
        }
      }),
      helper.queryAllDonneeSecondaireString().then((value6) => {
        for (var ds in value6) {
          synchronisation(ds, 'donneesecondaire')
        },
      })
    });
    return valiny;
  }

  Future<String> synchronisation(Map toSend, String chemin) async {
    final response = await http.post(
      Uri.https('temporaire.llanddev.org', chemin),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: toSend,
    );
    print("result : _______________________________________________");
    print(response.body);
    return jsonDecode(response.body);
    // if (response.statusCode == 201) {
    //   return (jsonDecode(response.body));
    // } else {
    //   throw Exception(jsonDecode(response.body));
    // }
  }


  
  @override
  Widget build(BuildContext context) {
    helper.checkLogin().then((value) => !value?Navigator.pushNamed(context, '/onboarding'):0);
    return Scaffold(
        appBar: Navbar(
          title: "Accueil",
          searchBar: false,
          rightOptions: false
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        // key: _scaffoldKey,
        drawer: ArgonDrawer(currentPage: "Home"),
        body: Container(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 16.0),
                //   child: CardHorizontal(
                //       cta: "View article",
                //       title: homeCards["Ice Cream"]['title'],
                //       img: homeCards["Ice Cream"]['image'],
                //       tap: () {
                //         Navigator.pushNamed(context, '/pro');
                //       }),
                // ),
                // SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CardSmall(
                          cta: "Accéder au formulaire",
                          title: homeCards["Menage"]['title'],
                          img: homeCards["Menage"]['image'],
                          tap: () {
                            Navigator.pushNamed(context, '/menage');
                          }),
                      CardSmall(
                          cta: "Accéder au formulaire",
                          title: homeCards["Charbonnier"]['title'],
                          img: homeCards["Charbonnier"]['image'],
                          tap: () {
                            Navigator.pushNamed(context, '/charbonnier');
                          })
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardSmall(
                        cta: "Accéder au formulaire",
                        title: homeCards["DonneeSecondaire"]['title'],
                        img: homeCards["DonneeSecondaire"]['image'],
                        tap: () {
                          Navigator.pushNamed(context, '/donneeSecondaire');
                        }),
                    CardSmall(
                        cta: "Accéder au formulaire",
                        title: homeCards["Barriere"]['title'],
                        img: homeCards["Barriere"]['image'],
                        tap: () {
                          Navigator.pushNamed(context, '/barriere');
                        })
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardSmall(
                        cta: "Accéder au formulaire",
                        title: homeCards["Reboisement"]['title'],
                        img: homeCards["Reboisement"]['image'],
                        tap: () {
                          Navigator.pushNamed(context, '/reboisement');
                        }),
                    CardSmall(
                        cta: "Accéder au formulaire",
                        title: homeCards["Pepiniere"]['title'],
                        img: homeCards["Pepiniere"]['image'],
                        tap: () {
                          Navigator.pushNamed(context, '/pepiniere');
                        })
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardSmall(
                        cta: "Accéder au formulaire",
                        title: homeCards["ProducteurFoyer"]['title'],
                        img: homeCards["ProducteurFoyer"]['image'],
                        tap: () {
                          Navigator.pushNamed(context, '/producteurFoyer');
                        }),
                    CardSmall(
                        cta: "Accéder au formulaire",
                        title: homeCards["ProducteurEnergie"]['title'],
                        img: homeCards["ProducteurEnergie"]['image'],
                        tap: () {
                          Navigator.pushNamed(context, '/producteurEnergie');
                        })
                  ],
                ),
                SizedBox(height: 8.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/listemenage');
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Material(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Liste ménages"),
                          ),
                        )
                      ],)
                  ),
                ),
                SizedBox(height: 8.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/listecharbonnier');
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Material(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Liste charbonnier"),
                          ),
                        )
                      ],)
                  ),
                ),
                SizedBox(height: 8.0),
                
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/listebarriere');
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Material(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Liste Barrières"),
                          ),
                        )
                      ],)
                  ),
                ),
                
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/listereboisement');
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Material(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Liste Reboisement"),
                            ),
                          )
                        ],)
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/listepepiniere');
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Material(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Liste Pépiniere"),
                            ),
                          )
                        ],)
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/listeProductionFoyer');
                    },
                    child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Material(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Liste Producteur de Foyer"),
                              ),
                            )
                          ],)
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/listeProductionEnergie');
                    },
                    child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Material(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Liste Producteur d'énergie"),
                              ),
                            )
                          ],)
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, '/pro');
                      // CsvHelper helper = new CsvHelper();
                      // helper.generateCsv('menage.csv', [
                      //   ["No.", "Name", "Roll No."],
                      //   ["1", "randomAlpha(3)", "randomNumeric(3)"],
                      //   ["2", "randomAlpha(3)", "randomNumeric(3)"],
                      //   ["3", "randomAlpha(3)", "randomNumeric(3)"]
                      // ]);
                      synchro();
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Material(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Synchroniser"),
                            ),
                          )
                        ],)
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
