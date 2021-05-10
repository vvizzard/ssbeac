import 'dart:convert';
import 'dart:ui';
import 'package:argon_flutter/helper/database_helpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/input.dart';

import 'package:argon_flutter/widgets/drawer.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _checkboxValue = false;

  final double height = window.physicalSize.height;

  var email = TextEditingController();
  var pw = TextEditingController();

  DatabaseHelper helper = DatabaseHelper.instance;

  // Future<int> log(String eMail, String password) async {
  //   Map<String,String> bodyToSend = {
  //     'email': eMail,
  //     'pwd': password,
  //   };

  //   final response = await http.post(
  //     Uri.https('temporaire.llanddev.org', 'log'),
  //     // headers: <String, String>{
  //     //   'Content-Type': 'application/json; charset=UTF-8',
  //     // },
      
  //     body: jsonEncode(bodyToSend),
  //   );
  //   print('header: __________________________________');
  //   print(bodyToSend);
  //   print('body: __________________________________');
  //   print(response.body);
  //   print(jsonDecode(response.body));
  //   return (jsonDecode(response.body));
  // }

  Future<int> log(String eMail, String password) async {
    Future<int> val = null;
    Map<String,String> toSend = {
      'email': eMail,
      'pwd': password,
    };
    final response = await http.post(
      Uri.https('temporaire.llanddev.org', 'log'),
      body: toSend,
    ).then((value) => {
      print("result : _______________________________________________"),
      print(jsonDecode(value.body)),
      val = helper.log(int.tryParse(jsonDecode(value.body)[2]))
    });
    return val;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(transparent: true, title: "", rightOptions: false),
        extendBodyBehindAppBar: true,
        drawer: ArgonDrawer(currentPage: "Account"),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/register-bg.png"),
                      fit: BoxFit.cover)),
            ),
            SafeArea(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 24.0, right: 24.0, bottom: 32),
                  child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.63,
                              color: Color.fromRGBO(244, 245, 247, 1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 24.0, bottom: 24.0),
                                        child: Center(
                                          child: Text(
                                              "Connexion",
                                              style: TextStyle(
                                                  color: ArgonColors.text,
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 16)),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                              placeholder: "E-mail",
                                              prefixIcon: Icon(Icons.school),
                                              controller: email,
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.all(8.0),
                                          //   child: Input(
                                          //       placeholder: "Email",
                                          //       prefixIcon: Icon(Icons.email)),
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Input(
                                                placeholder: "Mot de passe",
                                                obscureText: true,
                                                controller: pw,
                                                prefixIcon: Icon(Icons.lock)),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(
                                          //       left: 24.0),
                                          //   child: RichText(
                                          //       text: TextSpan(
                                          //           text: "password strength: ",
                                          //           style: TextStyle(
                                          //               color:
                                          //                   ArgonColors.muted),
                                          //           children: [
                                          //         TextSpan(
                                          //             text: "strong",
                                          //             style: TextStyle(
                                          //                 fontWeight:
                                          //                     FontWeight.w600,
                                          //                 color: ArgonColors
                                          //                     .success))
                                          //       ])),
                                          // ),
                                        ],
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       left: 8.0, top: 0, bottom: 16),
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.start,
                                      //     children: [
                                      //       Checkbox(
                                      //           activeColor:
                                      //               ArgonColors.primary,
                                      //           onChanged: (bool newValue) =>
                                      //               setState(() =>
                                      //                   _checkboxValue =
                                      //                       newValue),
                                      //           value: _checkboxValue),
                                      //       Text("I agree with the",
                                      //           style: TextStyle(
                                      //               color: ArgonColors.muted,
                                      //               fontWeight:
                                      //                   FontWeight.w200)),
                                      //       GestureDetector(
                                      //           onTap: () {
                                      //             Navigator.pushNamed(
                                      //                 context, '/pro');
                                      //           },
                                      //           child: Container(
                                      //             margin:
                                      //                 EdgeInsets.only(left: 5),
                                      //             child: Text("Privacy Policy",
                                      //                 style: TextStyle(
                                      //                     color: ArgonColors
                                      //                         .primary)),
                                      //           )),
                                      //     ],
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Center(
                                          child: FlatButton(
                                            textColor: ArgonColors.white,
                                            color: ArgonColors.primary,
                                            onPressed: () {
                                              // Respond to button press
                                              log(email.text, pw.text).then((value) => print(value)).then((value) => {
                                                helper.checkLogin().then((value) => {
                                                  value?Navigator.pushNamed(context, '/home'):0
                                                })
                                              });
                                              // Navigator.pushNamed(
                                              //     context, '/home');
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                    top: 12,
                                                    bottom: 12),
                                                child: Text("Connexion",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16.0))),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      )),
                ),
              ]),
            )
          ],
        ));
  }
}
