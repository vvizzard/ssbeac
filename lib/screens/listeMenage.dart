import 'package:argon_flutter/helper/csv_helpers.dart';
import 'package:argon_flutter/helper/database_helpers.dart';
import 'package:argon_flutter/screens/menageModifcation.dart';
import 'package:flutter/material.dart';

import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/input.dart';
import 'package:argon_flutter/widgets/table-cell.dart';
import 'package:intl/intl.dart';




class ListeMenage extends StatefulWidget {
  @override
  _ListeMenageState createState() => _ListeMenageState();
}

class _ListeMenageState extends State<ListeMenage> {
  final _formKey = GlobalKey<FormState>();  
  final dateFormat = DateFormat('dd_MM_yyyy');

  DatabaseHelper helper = DatabaseHelper.instance;
  List<Map> menages = [];

  void initState() {
    helper.queryAllMenage().then((value) => setState(() {
      menages = value;
    }));    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Ménages",
          rightOptions: false,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Menage"),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
          child: SafeArea(
            bottom: true,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16),
              ),
              

              Column(children: menages.map((e) {
                // MenageEntity m = MenageEntity.fromMap(e);
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(e['_id'].toString(), 
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
                                  Text(e['typeMenage']!=null?e['typeMenage']:"", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e['date']!=null?e['date']:"", 
                                      style: TextStyle(
                                        color: ArgonColors.text,
                                        fontSize: 12
                                      ),
                                      textAlign:TextAlign.end
                                    ),
                                  ),
                                ],
                              ),
                              // TableRow(
                              //   children: <Widget>[
                              //     Text("Prix par mois :", style: TextStyle(
                              //         color: ArgonColors.text,
                              //         fontSize: 12
                              //       )
                              //     ),
                              //     Container(
                              //       padding: EdgeInsets.all(2.0),
                              //       child: Text(e.value['prix'], 
                              //         style: TextStyle(
                              //           color: ArgonColors.text,
                              //           fontSize: 12
                              //         ),
                              //         textAlign:TextAlign.end
                              //       ),
                              //     ),
                              //   ],
                              // ),
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
                              helper.queryAllEnergieCuissonByMenage(e['_id']).then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MenageModification(
                                    menageEnCours: MenageEntity.fromMap(e),
                                    energieCuissons: value
                                  ),
                                ),
                              ));
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

              SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8),
                child: RaisedButton(
                  textColor: ArgonColors.text,
                  color: ArgonColors.success,
                  onPressed: () {
                    setState(() {
                      CsvHelper csvHelper = new CsvHelper();
                      // Ménages
                      List<List<String>> data = [];
                      data.add([
                        'Id', 
                        'Date',	
                        'District',
                        'Unite agglomeration',
                        'Type de menage',
                        'Taille de menage',
                        'Type gros consommateur',
                        'Frequence renouvellement BC traditionnel',
                        'Prix renouvellement BC traditionnel',
                        'Frequence renouvellement BC ameliore',
                        'Prix renouvellement BC ameliore',
                        'Frequence renouvellement CB traditionnel',
                        'Prix renouvellement CB traditionnel',
                        'Frequence renouvellement CB ameliore',
                        'Prix renouvellement CB ameliore'
                      ]);
                      menages.forEach((element) {
                        data.add([
                          element['_id'].toString(), element['date'], element['district'], element['agglomeration'], element['typeMenage'], 
                          element['tailleMenage'].toString(),element['typeGrosConsommateur'], element['frequenceRenouvellementBCTrad'].toString(), 
                          element['prixRenouvellementBCTrad'].toString(),element['frequenceRenouvellementBCAmeliore'].toString(), 
                          element['prixRenouvellementBCAmeliore'].toString(),element['frequenceRenouvellementCBTrad'].toString(), 
                          element['prixRenouvelementCBTrad'].toString(), element['frequenceRenouvellementCBAmeliore'].toString(),
                          element['prixRenouvelementCBAmeliore'].toString()
                        ]);
                      });

                      csvHelper.generateCsv(data[1][0]+'_menage_'+dateFormat.format(new DateTime.now())+'.csv', data);

                      // EnergieCuisson
                      data = [];
                      data.add(['Id',	'IdMenage',	'Energie cuisson',	'Autre energie cuisson',	'Quantite',	'Prix',	'Saison']);
                      helper.queryAllEnergieCuisson().then((value) => {
                        value.forEach((element) {
                          data.add([
                            element.id.toString(), element.idMenage.toString(), element.energieCuisson, element.autreEnergieCuisson,
                            element.qte.toString(), element.prix.toString(), element.saison
                          ]);
                        }),
                        csvHelper.generateCsv(data[1][0]+'_enerieCuisson_'+dateFormat.format(new DateTime.now())+'.csv', data)
                      });
                    });
                    // Navigator.pushReplacementNamed(context, '/home');
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 12, bottom: 12),
                      child: Text("Exporter",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.0))),
                ),
              ),
            ),

          ]),
        ),
      )));
  }
}
