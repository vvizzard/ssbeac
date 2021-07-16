import 'package:argon_flutter/helper/csv_helpers.dart';
import 'package:argon_flutter/helper/database_helpers.dart';
import 'package:argon_flutter/screens/foretModifcation.dart';
// import 'package:argon_flutter/screens/foretModifcation.dart';
import 'package:flutter/material.dart';

import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:intl/intl.dart';




class ListeForetNaturel extends StatefulWidget {
  @override
  _ListeForetNaturelState createState() => _ListeForetNaturelState();
}

class _ListeForetNaturelState extends State<ListeForetNaturel> {
  final _formKey = GlobalKey<FormState>();  
  final dateFormat = DateFormat('dd_MM_yyyy');

  DatabaseHelper helper = DatabaseHelper.instance;
  List<Map> foretEnCours = [];

  void initState() {
    helper.queryAllForetNaturel().then((value) => setState(() {
      foretEnCours = value;
    }));    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Liste des Forêts Naturelle",
          rightOptions: false,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "ListForetNaturels"),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
          child: SafeArea(
            bottom: true,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16),
              ),

              Column(children: foretEnCours.map((e) {
                // MenageEntity m = MenageEntity.fromMap(e);
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text('#'+e['_id'].toString(), 
                          style: TextStyle(
                            color: ArgonColors.text,
                            fontSize: 12
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Table(
                            // border: unset,
                            columnWidths: const <int, TableColumnWidth>{
                              0: FlexColumnWidth(),
                              1: FlexColumnWidth(),
                            },
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            children: <TableRow>[
                              TableRow(
                                children: <Widget>[
                                  Text('Localité : ', style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e['agg'],
                                      style: TextStyle(
                                        color: ArgonColors.text,
                                        fontSize: 12
                                      ),
                                      textAlign:TextAlign.end
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: <Widget>[
                                  Text("Superficie", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e['superficie'].toString(), 
                                      style: TextStyle(
                                        color: ArgonColors.text,
                                        fontSize: 12
                                      ),
                                      textAlign:TextAlign.end
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: <Widget>[
                                  Text("date", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e['date'], 
                                      style: TextStyle(
                                        color: ArgonColors.text,
                                        fontSize: 12
                                      ),
                                      textAlign:TextAlign.end
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('Modifier'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ForetModification(
                                    foretNaturelleEnCours: ForetNaturelEntity.fromMap(e),
                                  ),
                                ),
                              );
                            },
                          ),
                          TextButton(
                            child: const Text('Supprimer'),
                            onPressed: () {
                              setState(() {
                                // energieCuissonSecheChoosed.remove(e.key);
                                // checkFoyer('BC') ? showFoyerBC=true : showFoyerBC=false;
                                // checkFoyer('CB') ? showFoyerCB=true : showFoyerCB=false;
                              });
                            },
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList()),

            //   SizedBox(
            //   width: double.infinity,
            //   child: Padding(
            //     padding:
            //         const EdgeInsets.only(top: 8),
            //     child: RaisedButton(
            //       textColor: ArgonColors.text,
            //       color: ArgonColors.success,
            //       onPressed: () {
            //         setState(() {
            //           CsvHelper csvHelper = new CsvHelper();
            //           // Ménages
            //           List<List<String>> data = [];
            //           data.add([
            //             'Id',
            //             'Date',
            //             'District',
            //             'Unité d\'agglomeration',
            //             'Commune',
            //             'Agglomération',
            //             'Proprietaire',
            //             'Genre',
            //             'Type de foret'
            //             'Superficie',
            //             'Pare-feux',
            //             'Pare-feux choisis',
            //             'Culture',
            //             'Essence',
            //             'Provenance semence',
            //             'Productivite',
            //             'Travaux sol',
            //             'Annee plantation',
            //             'Densite',
            //             'Taux remplissage',
            //             'Fertilisant',
            //             'Acteurs/Opérateurs'
            //           ]);
            //           foretEnCours.forEach((element) {
            //             data.add([
            //               element['_id'].toString(),
            //               element['date'],
            //               element['district'],
            //               element['agglomeration'],
            //               element['commune'],
            //               element['agg'],
            //               element['proprietaire'],
            //               element['genre'],
            //               element['type'],
            //               element['superficie'].toString(),
            //               element['pare_feux'].toString(),
            //               element['pare_feux_choosed'],
            //               element['culture'],
            //               element['essence'],
            //               element['provenance_semence'],
            //               element['productivite'],
            //               element['travaux_sol'],
            //               element['annee_plantation'].toString(),
            //               element['densite'].toString(),
            //               element['taux_remplissage'].toString(),
            //               element['fertilisant'].toString(),
            //               element['acteur'].toString()
            //             ]);
            //           });
            //
            //           csvHelper.generateCsv(data[1][0]+'_foret_'+dateFormat.format(new DateTime.now())+'.csv', data);
            //         });
            //         // Navigator.pushReplacementNamed(context, '/home');
            //       },
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(4.0),
            //       ),
            //       child: Padding(
            //           padding: EdgeInsets.only(
            //               left: 16.0, right: 16.0, top: 12, bottom: 12),
            //           child: Text("Exporter",
            //               style: TextStyle(
            //                   fontWeight: FontWeight.w600, fontSize: 16.0))),
            //     ),
            //   ),
            // ),

          ]),
        ),
      )));
  }
}
