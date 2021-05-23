import 'package:argon_flutter/screens/listeBarriere.dart';
import 'package:argon_flutter/screens/listeCharbonnier.dart';
import 'package:argon_flutter/screens/listeMenage.dart';
import 'package:argon_flutter/screens/listePepiniere.dart';
import 'package:argon_flutter/screens/listeProducteurEnergie.dart';
import 'package:argon_flutter/screens/listeProducteurFoyer.dart';
import 'package:argon_flutter/screens/listeReboisement.dart';
import 'package:argon_flutter/screens/pepiniere.dart';
import 'package:argon_flutter/screens/producteurEnergie.dart';
import 'package:argon_flutter/screens/producteurFoyer.dart';
import 'package:argon_flutter/screens/reboisement.dart';
import 'package:flutter/material.dart';

// screens
import 'package:argon_flutter/screens/onboarding.dart';
import 'package:argon_flutter/screens/pro.dart';
import 'package:argon_flutter/screens/home.dart';
import 'package:argon_flutter/screens/profile.dart';
import 'package:argon_flutter/screens/register.dart';
import 'package:argon_flutter/screens/articles.dart';
import 'package:argon_flutter/screens/elements.dart';
import 'package:argon_flutter/screens/menage.dart';
import 'package:argon_flutter/screens/barriere.dart';
import 'package:argon_flutter/screens/charbonnier.dart';
import 'package:argon_flutter/screens/donneeSecondaire.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SSBEAC',
        theme: ThemeData(fontFamily: 'OpenSans'),
        initialRoute: "/onboarding",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/onboarding": (BuildContext context) => new Register(),
          "/home": (BuildContext context) => new Home(),
          // "/profile": (BuildContext context) => new Profile(),
          // "/articles": (BuildContext context) => new Articles(),
          // "/elements": (BuildContext context) => new Elements(),
          // "/account": (BuildContext context) => new Register(),
          // "/pro": (BuildContext context) => new Pro(),
          "/menage": (BuildContext context) => new Menage(),
          "/listemenage": (BuildContext context) => new ListeMenage(),
          "/charbonnier": (BuildContext context) => new Charbonnier(),
          "/listecharbonnier": (BuildContext context) => new ListeCharbonnier(),
          "/donneeSecondaire": (BuildContext context) => new DonneeSecondaire(),
          "/listebarriere": (BuildContext context) => new ListeBarriere(),
          "/barriere": (BuildContext context) => new Barriere(),
          "/reboisement": (BuildContext context) => new Reboisement(),
          "/pepiniere": (BuildContext context) => new Pepiniere(),
          "/listereboisement": (BuildContext context) => new ListeReboisement(),
          "/listepepiniere": (BuildContext context) => new ListePepiniere(),
          "/producteurFoyer" : (BuildContext context) => new ProducteurFoyer(),
          "/listeProductionFoyer" : (BuildContext context) => new ListeProducteurFoyer(),
          "/producteurEnergie": (BuildContext context) => new ProducteurEnergie(),
          "/listeProductionEnergie": (BuildContext context) => new ListeProducteurEnergie()
        });
  }
}
