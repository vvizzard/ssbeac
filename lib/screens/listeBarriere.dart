import 'package:argon_flutter/helper/csv_helpers.dart';
import 'package:argon_flutter/helper/database_helpers.dart';
import 'package:argon_flutter/screens/barriereModifcation.dart';
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




class ListeBarriere extends StatefulWidget {
  @override
  _ListeBarriereState createState() => _ListeBarriereState();
}

class _ListeBarriereState extends State<ListeBarriere> {
  final _formKey = GlobalKey<FormState>();  
  final dateFormat = DateFormat('dd_MM_yyyy');

  DatabaseHelper helper = DatabaseHelper.instance;
  List<Map> barrieresEnCours = [];

  void initState() {
    helper.queryAllBarriere().then((value) => setState(() {
      barrieresEnCours = value;
      // print('blabla');
      // print(value);
    }));    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Barrieres",
          rightOptions: false,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Barrieres"),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
          child: SafeArea(
            bottom: true,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16),
              ),
              

              Column(children: barrieresEnCours.map((e) {
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
                                  Text('de ' + e['district_provenance'], style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text('vers ' + e['district_arrivee'], 
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
                                  Text("", style: TextStyle(
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
                              helper.queryAllProduitByBarriere(e['_id']).then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BarriereModification(
                                    barriereEnCours: BarriereEntity.fromMap(e),
                                    produits: value
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
                        'Axe',
                        'Latitude',	
                        'Longitude',	
                        'Laisser-passer',
                        'Transport',	
                        'District provenance',
                        'Designation provenance',	
                        'District arrive',
                        'Designation arrive'
                      ]);
                      barrieresEnCours.forEach((element) {
                        data.add([
                          element['_id'].toString(), element['date'], element['district'], element['axe'], 
                          element['latitude'].toString(), element['longitude'].toString(),element['laisser_passer'].toString(), 
                          element['transport'],element['district_provenance'],element['designation_provenance'],
                          element['district_arrivee'],element['designation_arrivee']
                        ]);
                      });

                      csvHelper.generateCsv(data[1][0]+'_barriere_'+dateFormat.format(new DateTime.now())+'.csv', data);

                      // EnergieCuisson
                      data = [];
                      data.add(['Id',	'IdBarriere',	'Type',	'Produit',	'Quantite']);
                      helper.queryAllProduit().then((value) => {
                        value.forEach((element) {
                          data.add([
                            element.id.toString(), element.idBarriere.toString(), element.typeProduit, element.produit, 
                            element.qte.toString()]);
                        }),
                        print('tralalalalalalalalalalalala'),
                        print(data),
                        csvHelper.generateCsv(data[1][0]+'_produits_'+dateFormat.format(new DateTime.now())+'.csv', data)
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
