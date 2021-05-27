import 'package:argon_flutter/helper/database_helpers.dart';
import 'package:flutter/material.dart';

import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/input.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


List<String> districts = ['Ambohidratrimo ',
'Andramasina ',
'Anjozorobe ',
'Ankazobe ',
'Antananarivo Atsimondrano ',
'Antananarivo Avaradrano ',
'Antananarivo Renivohitra ',
'Manjakandriana ',
'Antsirabe I ',
'Betafo ',
'Ambatolampy ',
'Antanifotsy ',
'Faratsiho ',
'Antsirabe II ',
'Mandoto ',
'Soavinandriana ',
'Arivonimamo ',
'Miarinarivo ',
'Tsiroanomandidy ',
'Fenoarivobe ',
'Ambalavao ',
'Fianarantsoa I ',
'Ambohimahasoa ',
'Ikalamavony ',
'Isandra ',
'Lalangina ',
'Vohibato ',
'Ambatofinandrahana ',
'Ambositra ',
'Fandriana ',
'Manandriana ',
'Ifanadiana ',
'Nosy-varika ',
'Mananjary ',
'Manakara atsimo ',
'Ikongo ',
'Vohipeno ',
'Ihosy ',
'Ivohibe ',
'Iakora ',
'Farafangana ',
'Vangaindrano ',
'Midongy-atsimo ',
'Vondrozo ',
'Befotaka ',
'Toamasina I ',
'Brickaville ',
'Vatomandry ',
'Mahanoro ',
'Marolambo ',
'Toamasina II ',
'Antanambao manampontsy ',
'Sainte Marie ',
'Maroantsetra ',
'Mananara-avaratra ',
'FENERIVE EST ',
'Soanierana Ivongo ',
'Vavatenina ',
'Amparafaravola ',
'Ambatondrazaka ',
'Moramanga ',
'Andilamena ',
'Anosibe-an’ala ',
'Mahajanga I ',
'Ambato boeni ',
'Marovoay ',
'Mitsinjo ',
'Mahajanga II ',
'Soalala ',
'Port-Bergé(Boriziny-vaovao) ',
'Mandritsara ',
'Analalava ',
'Befandriana nord ',
'Antsohihy ',
'Bealanana ',
'Mampikony ',
'Maevatanana ',
'Tsaratanana ',
'Kandreho ',
'Ambatomainty ',
'Antsalova ',
'Maintirano ',
'Morafenobe ',
'Besalampy ',
'Toliara-I ',
'Toliara-II ',
'Benenitra ',
'Beroroha ',
'Morombe ',
'Ankazoabo ',
'Betioky atsimo ',
'Ampanihy ouest ',
'Sakaraha ',
'Beloha ',
'Ambovombe-androy ',
'Bekily ',
'Tsihombe ',
'Amboasary-atsimo ',
'Taolagnaro ',
'Betroka ',
'Manja ',
'Morondava ',
'Mahabo ',
'Belo sur Tsiribihina ',
'Miandrivazo ',
'Antsiranana II ',
'Antsiranana I ',
'Ambilobe ',
'Nosy-Be ',
'Ambanja ',
'Antalaha ',
'Sambava ',
'Andapa ',
'Vohemar ',''];

List<String> agglomeration = [
  'Urbaine', 'Rurale',''
];

List<String> listTransport = ['Bicyclette', 'Charette', 'Taxi-brousse', 'Camion', 'Dos d\'homme', 'Autre',''];

List<String> typeDeplacement = ['Entrée', 'Sortie',''];

List<String> listeProduits = ['BC', 'CB',''];

class Barriere extends StatefulWidget {
  @override
  _BarriereState createState() => _BarriereState();
}

class _BarriereState extends State<Barriere> {
  final _formKey = GlobalKey<FormState>();  

  String dateLabel = "Choisir la date";
  
  DateTime date = new DateTime.now(); 
  String districtChoosed = '';
  String agglomerationChoosed = '';
  
  bool laisserPasser = false;
  String transportChoosed = '';
  String typeChoosed = '';
  String deplacementChoosed = '';
  String produitChoosed = '';
  String districtProvenance = '';
  String districtDestination = '';

  // produits
  Map<String, Map<String, String>> produits = {};

  // text field controller
  var qteProduitTemp = TextEditingController();
  var axe = TextEditingController();
  var longitude = TextEditingController();
  var latitude = TextEditingController();
  var provenance = TextEditingController();
  var destination = TextEditingController();

  var commune = TextEditingController();
  var agg = TextEditingController();

  DatabaseHelper helper = DatabaseHelper.instance;
  
  _save() async {
    if(produits.length == 0) return null;

    BarriereEntity barriereEnCours = BarriereEntity();

    String dateString = DateFormat('dd-MM-yyyy').format(date);
    barriereEnCours.dateBarriere=dateString;
    
    barriereEnCours.districtBarriere = districtChoosed;
    barriereEnCours.agglomerationBarriere = agglomerationChoosed;
    barriereEnCours.commune = commune.text;
    barriereEnCours.agg = agg.text;
    barriereEnCours.axe = axe.text;
    barriereEnCours.latitude = latitude.text;
    barriereEnCours.longitude = longitude.text;
    barriereEnCours.laisserPasser = laisserPasser;
    barriereEnCours.transport = transportChoosed;
    // barriereEnCours.type = typeChoosed;
    barriereEnCours.districtProvenance = districtProvenance;
    barriereEnCours.designationProvenance = provenance.text;
    barriereEnCours.districtArrivee = districtDestination;
    barriereEnCours.designationArrivee = destination.text;
    barriereEnCours.typeDeplacement = deplacementChoosed;

    List<ProduitEntity> listeProduits = [];

    produits.forEach((key, value) {
      ProduitEntity produit = ProduitEntity();
      produit.typeProduit = value['type'];
      produit.produit= value['produit'];
      produit.qte = double.tryParse(value['qte']);
      listeProduits.add(produit);
    });

    // print('barriere : ');
    // print(barriereEnCours.toMap());
    // print('produits : ');
    // print(listeProduits.toString());

    // DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insertBarriere(barriereEnCours, listeProduits);
    print(id);
    
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2018, 1),
      lastDate: DateTime(2101));
      if (picked != null && picked != date)
        setState(() {
          date = picked;
          dateLabel = picked.toString();
        });
  } 

  @override
  Widget build(BuildContext context) {
    helper.checkLogin().then((value) => !value?Navigator.pushNamed(context, '/onboarding'):0);
    return Scaffold(
        appBar: Navbar(
          title: "Barrière",
          rightOptions: false,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Barriere"),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
          child: SafeArea(
            bottom: true,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Date",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: GestureDetector(
                    onTap: ()=>_selectDate(context),
                    child: Input(
                      enable: false,
                      placeholder: dateLabel,
                      borderColor: ArgonColors.white,
                      onTap: ()=>_selectDate(context),
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 32),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("District",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: DropdownButton<String>(
                  style: TextStyle(
                    fontSize: 12,
                    color: ArgonColors.text,
                    backgroundColor: Colors.white
                  ),
                  value: districtChoosed,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      districtChoosed = newValue;
                    });
                  },
                  items: districts
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Unité agglomération",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: DropdownButton<String>(
                  style: TextStyle(
                    fontSize: 12,
                    color: ArgonColors.text,
                    backgroundColor: Colors.white
                  ),
                  value: agglomerationChoosed,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      agglomerationChoosed = newValue;
                    });
                  },
                  items: agglomeration
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Commune",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Input(
                    enable: true,
                    placeholder: "Entrer le nom de la commune",
                    borderColor: ArgonColors.white,
                    controller: commune,
                  )
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Agglomération",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Input(
                    enable: true,
                    placeholder: "Entrer le nom de l'agglomération",
                    borderColor: ArgonColors.white,
                    controller: agg,
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Axe de la barrière",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Input(
                    enable: true,
                    placeholder: "Entrer ici l'axe où se site la barrière",
                    borderColor: ArgonColors.white,
                    controller: axe,
                )
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16, bottom: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Coordonnées géographiques",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 16)),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Longitude",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Input(
                    enable: true,
                    placeholder: "Entrer ici la longitude de la situation de la barrière",
                    borderColor: ArgonColors.white,
                    controller: longitude,
                )
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Latitude",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Input(
                    enable: true,
                    placeholder: "Entrer ici la latitude de la situation de la barrière",
                    borderColor: ArgonColors.white,
                    controller: latitude,
                )
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Laisser-passer",
                      style: TextStyle(color: ArgonColors.text, fontSize: 12)),
                  Switch.adaptive(
                    value: laisserPasser,
                    onChanged: (bool newValue) =>
                        setState(() => laisserPasser = newValue),
                    activeColor: ArgonColors.primary,
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Transport",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: DropdownButton<String>(
                  style: TextStyle(
                    fontSize: 12,
                    color: ArgonColors.text,
                    backgroundColor: Colors.white
                  ),
                  value: transportChoosed,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      transportChoosed = newValue;
                    });
                  },
                  items: listTransport
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Provenance du produit",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: DropdownButton<String>(
                  style: TextStyle(
                    fontSize: 12,
                    color: ArgonColors.text,
                    backgroundColor: Colors.white
                  ),
                  value: districtProvenance,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      districtProvenance = newValue;
                    });
                  },
                  items: districts
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Désignation",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Input(
                    enable: true,
                    placeholder: "Entrer ici la désignation du provenance",
                    borderColor: ArgonColors.white,
                    controller: provenance,
                )
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Destination du produit",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: DropdownButton<String>(
                  style: TextStyle(
                    fontSize: 12,
                    color: ArgonColors.text,
                    backgroundColor: Colors.white
                  ),
                  value: districtDestination,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      districtDestination = newValue;
                    });
                  },
                  items: districts
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Désignation",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Input(
                    enable: true,
                    placeholder: "Entrer ici la désignation de la déstination",
                    borderColor: ArgonColors.white,
                    controller: destination,
                )
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Type de déplacement",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: DropdownButton<String>(
                  style: TextStyle(
                    fontSize: 12,
                    color: ArgonColors.text,
                    backgroundColor: Colors.white
                  ),
                  value: typeChoosed,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      typeChoosed = newValue;
                    });
                  },
                  items: typeDeplacement
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),

              // Produits
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Liste des produits",
                    style: TextStyle(
                      color: ArgonColors.text,
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    )
                  ),
                ),
              ),

              Column(children: produits.entries.map((e) {
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(e.value['produit'], 
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
                              /*TableRow(
                                children: <Widget>[
                                  Text("Type :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['type'],
                                      style: TextStyle(
                                        color: ArgonColors.text,
                                        fontSize: 12
                                      ),
                                      textAlign:TextAlign.end
                                    ),
                                  ),
                                ],
                              ),*/
                              TableRow(
                                children: <Widget>[
                                  Text("Quantité (kg) :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['qte'], 
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
                            child: const Text('Retirer'),
                            onPressed: () {
                              setState(() {
                                produits.remove(e.key);
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

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Produit",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: DropdownButton<String>(
                  style: TextStyle(
                    fontSize: 12,
                    color: ArgonColors.text,
                    backgroundColor: Colors.white
                  ),
                  value: produitChoosed,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      produitChoosed = newValue;
                    });
                  },
                  items: listeProduits
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Quantité de produit",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Input(
                    enable: true,
                    placeholder: "Entrer la quantité de produit (kg)",
                    borderColor: ArgonColors.white,
                    controller: qteProduitTemp,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly]
                )
              ),

              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 8),
                  child: RaisedButton(
                    textColor: ArgonColors.text,
                    color: ArgonColors.secondary,
                    onPressed: () {
                      setState(() {
                        produits.putIfAbsent(produitChoosed, () => {
                          "produit": produitChoosed,
                          "qte": qteProduitTemp.text,
                          "type": typeChoosed
                        });
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 12, bottom: 12),
                        child: Text("Ajouter",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.0))),
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 8),
                  child: RaisedButton(
                    textColor: ArgonColors.text,
                    color: ArgonColors.success,
                    onPressed: () {
                      _save();
                      Navigator.pushReplacementNamed(context, '/listebarriere');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 12, bottom: 12),
                        child: Text("Enregistrer",
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
