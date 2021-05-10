import 'package:argon_flutter/helper/database_helpers.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:argon_flutter/constants/Theme.dart';

import 'package:argon_flutter/widgets/drawer-tile.dart';

class ArgonDrawer extends StatelessWidget {
  final String currentPage;

  ArgonDrawer({this.currentPage});

  _launchURL() async {
    const url = 'https://creative-tim.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  DatabaseHelper helper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: ArgonColors.white,
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  // child: Image.asset("assets/img/argon-logo.png"),
                  child: Text("S.S.B.E.A.C.",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        )),
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 24, left: 16, right: 16),
            children: [
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Home")
                      Navigator.pushReplacementNamed(context, '/home');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Accueil",
                  isSelected: currentPage == "Home" ? true : false),
              DrawerTile(
                  icon: Icons.home_work_sharp,
                  onTap: () {
                    if (currentPage != "Menage")
                      Navigator.pushReplacementNamed(context, '/menage');
                  },
                  iconColor: ArgonColors.warning,
                  title: "Ménages",
                  isSelected: currentPage == "Menage" ? true : false),
              DrawerTile(
                  // icon: Icons.account_circle,
                  icon: Icons.pie_chart,
                  onTap: () {
                    if (currentPage != "Charbonnier")
                      Navigator.pushReplacementNamed(context, '/charbonnier');
                  },
                  iconColor: ArgonColors.info,
                  title: "Charbonnier",
                  isSelected: currentPage == "Charbonnier" ? true : false),
              DrawerTile(
                  icon: Icons.dashboard_outlined,
                  onTap: () {
                    if (currentPage != "DonneeSecondaire")
                      Navigator.pushReplacementNamed(context, '/donneeSecondaire');
                  },
                  iconColor: ArgonColors.error,
                  title: "Données Secondaires",
                  isSelected: currentPage == "DonneeSecondaire" ? true : false),
              DrawerTile(
                  icon: Icons.stop_rounded,
                  onTap: () {
                    if (currentPage != "Barriere")
                      Navigator.pushReplacementNamed(context, '/barriere');
                  },
                  iconColor: ArgonColors.primary,
                  title: "Barrière",
                  isSelected: currentPage == "Barriere" ? true : false),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 4, thickness: 0, color: ArgonColors.muted),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                  //   child: Text("DOCUMENTATION",
                  //       style: TextStyle(
                  //         color: Color.fromRGBO(0, 0, 0, 0.5),
                  //         fontSize: 15,
                  //       )),
                  // ),
                  DrawerTile(
                      icon: Icons.logout,
                      onTap: () => {
                        helper.deco().then((value) => Navigator.pushNamed(context, '/onboarding'))
                      },
                      iconColor: ArgonColors.muted,
                      title: "Déconnexion",
                      isSelected:
                          currentPage == "Getting started" ? true : false),
                ],
              )),
        ),
      ]),
    ));
  }
}
