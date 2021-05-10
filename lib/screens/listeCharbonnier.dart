import 'package:argon_flutter/helper/csv_helpers.dart';
import 'package:argon_flutter/helper/database_helpers.dart';
import 'package:argon_flutter/screens/charbonnierModifcation.dart';
import 'package:argon_flutter/screens/menageModifcation.dart';
import 'package:flutter/material.dart';

import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/input.dart';
import 'package:argon_flutter/widgets/table-cell.dart';
import 'package:intl/intl.dart';




class ListeCharbonnier extends StatefulWidget {
  @override
  _ListeCharbonnierState createState() => _ListeCharbonnierState();
}

class _ListeCharbonnierState extends State<ListeCharbonnier> {
  final _formKey = GlobalKey<FormState>();  
  final dateFormat = DateFormat('dd_MM_yyyy');

  DatabaseHelper helper = DatabaseHelper.instance;
  List<Map> charbonniers = [];

  void initState() {
    helper.queryAllCharbonnier().then((value) => setState(() {
      charbonniers = value;
      // print('blabla');
      // print(value);
    }));    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Charbonniers",
          rightOptions: false,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Charbonniers"),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
          child: SafeArea(
            bottom: true,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16),
              ),
              

              Column(children: charbonniers.map((e) {
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
                                  Text(e['district']!=null?e['district']:"", style: TextStyle(
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
                              helper.queryAllMeuleByCharbonnier(e['_id']).then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CharbonnierModification(
                                    charbonnierEnCours: CharbonnierEntity.fromMap(e),
                                    meules: value
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
                        'Espece bois',
                        'Zone prelevement',
                        'Domaine prelevement',
                        'Autorisation',
                        'Qte bois',
                        'Qte charbon'

                      ]);
                      charbonniers.forEach((element) {
                        data.add([
                          element['_id'].toString(), element['date'], element['district'], element['agglomeration'], 
                          element['espece_bois'], element['zone_prelevement'], element['domaine_prelevement'],
                          element['autorisation'].toString(), element['qte_bois'].toString(), element['qte_charbon'].toString()]);
                      });

                      csvHelper.generateCsv(data[1][0]+'_charbonnier_'+dateFormat.format(new DateTime.now())+'.csv', data);

                      // EnergieCuisson
                      data = [];
                      data.add(['Id',	'IdCharbonnier',	'Type',	'Meule',	'Longueur',	'Largeur',	
                          'Hauteur', 'quantité de bois',	'quantité de charbon']);
                      helper.queryAllMeule().then((value) => {
                        value.forEach((element) {
                          data.add([
                            element.id.toString(), element.idCharbonnier.toString(), 
                            element.typeMeule, element.meule, 
                            element.longueur.toString(),element.largeur.toString(), element.hauteur.toString(),
                            element.qteB.toString(), element.qteC.toString()
                          ]);
                        }),
                        csvHelper.generateCsv(data[1][0]+'_meules_'+dateFormat.format(new DateTime.now())+'.csv', data)
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
