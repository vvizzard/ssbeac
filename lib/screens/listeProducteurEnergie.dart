import 'package:argon_flutter/helper/csv_helpers.dart';
import 'package:argon_flutter/helper/database_helpers.dart';
import 'package:argon_flutter/screens/pepiniereModifcation.dart';
import 'package:argon_flutter/screens/producteurEnergieModifcation.dart';
import 'package:flutter/material.dart';

import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:intl/intl.dart';




class ListeProducteurEnergie extends StatefulWidget {
  @override
  _ListeProducteurEnergieState createState() => _ListeProducteurEnergieState();
}

class _ListeProducteurEnergieState extends State<ListeProducteurEnergie> {
  final _formKey = GlobalKey<FormState>();  
  final dateFormat = DateFormat('dd_MM_yyyy');

  DatabaseHelper helper = DatabaseHelper.instance;
  List<Map> pepiniereEnCours = [];

  void initState() {
    helper.queryAllProducteurF().then((value) => setState(() {
      pepiniereEnCours = value;
    }));    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "ProducteurEnergies",
          rightOptions: false,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "ProducteurEnergies"),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
          child: SafeArea(
            bottom: true,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16),
              ),
              

              Column(children: pepiniereEnCours.map((e) {
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
                                  Text('Energie : ', style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e['energie'],
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
                                  Text("Quantité", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e['qte'],
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
                                  Text("Nbr appuie", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e['appuie'],
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
                                  builder: (_) => ProducteurEnergieModification(
                                    productionEnergieEnCours: ProducteurEEntity.fromMap(e),
                                  ),
                                ),
                              );
                            },
                          ),
                          TextButton(
                            child: const Text('Supprimer'),
                            onPressed: () {
                              setState(() {
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
                        'Unité d\'agglomeration',
                        'Commune',
                        'Agglomération',
                        'Energie',
                        'Production pour la cuisson',
                        'Production total (Electricité/BIOGAZ)',
                      ]);
                      pepiniereEnCours.forEach((element) {
                        data.add([
                          element['_id'].toString(),
                          element['date'],
                          element['district'],
                          element['agglomeration'],
                          element['commune'],
                          element['agg'],
                          element['energie'],
                          element['qte'],
                          element['qte_total']
                        ]);
                      });

                      csvHelper.generateCsv(data[1][0]+'_producteur_energie_'+dateFormat.format(new DateTime.now())+'.csv', data);
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
