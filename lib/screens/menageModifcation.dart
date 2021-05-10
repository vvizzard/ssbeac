import 'package:argon_flutter/helper/database_helpers.dart';
import 'package:flutter/material.dart';

import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/input.dart';
import 'package:argon_flutter/widgets/table-cell.dart';
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

List<String> typeMenage = [
  'Ménage', 'Gros consommateur',''
];

List<String> typeGrosConsommateur = [
  'Industriel', 'Artisanal(brique, distillerie, ...)', 'Restauration(Restaurant, gargote, boulangerie, ...)',''
];

List<String> listeEnergieCuisson = ['BC', 'CB', 'Autre',''];

List<String> listeAutreEnergieCuisson = ['Electricité', 'Pétrol', 'Ethanol', 'Briquette', 'Gaz', 'Biogaz', 'Bambou', 'Autre',''];

class MenageModification extends StatefulWidget {
  final MenageEntity menageEnCours;
  final List<EnergieCuissonEntity> energieCuissons;
  const MenageModification(
    {Key key, this.menageEnCours, this.energieCuissons}
  ):super(key: key); 

  @override
  _MenageModificationState createState() => _MenageModificationState();
}

class _MenageModificationState extends State<MenageModification> {
  final _formKey = GlobalKey<FormState>();  

  final dateFormat = DateFormat('dd-MM-yyyy');

  String dateLabel = "Choisir la date";
  bool showTailleMenage = false;
  bool showTypeGrosConsommateur = false;
  List<Widget> energieCuissonSecheWidget = [SizedBox(height: 8.0),];
  String energieCuissonSecheTemp="";
  String autreEnergieCuissonSecheTemp="";
  bool showAutreEnergieSeche = false;
  List<Widget> energieCuissonHumideWidget = [SizedBox(height: 8.0),];
  String energieCuissonHumideTemp="";
  String autreEnergieCuissonHumideTemp="";
  bool showAutreEnergieHumide = false;
  bool showFoyerBC = false;
  bool showFoyerCB = false;

  DatabaseHelper helper = DatabaseHelper.instance;

  // int idMenageEnCours;

  DateTime date = new DateTime.now(); 
  String districtChoosed = "";
  String agglomerationChoosed = "";
  String typeMenageChoosed = "";
  var tailleDeMenageChoosed = TextEditingController();
  String typeGrosConsommateurChoosed = "";

  // Liste énergie de cuisson sèche
  Map<String, Map<String, String>> energieCuissonSecheChoosed = {};
  var qteECSecheTemp = TextEditingController();
  var prixECSecheTemp = TextEditingController();

  // Liste énergie de cuisson humide
  Map<String, Map<String, String>> energieCuissonHumideChoosed = {};
  var qteECHumideTemp = TextEditingController();
  var prixECHumideTemp = TextEditingController();

  // Foyer
  var frequenceRenouvellementBCTrad = TextEditingController();
  var prixRenouvellementBCTrad = TextEditingController();
  var frequenceRenouvellementBCAmeliore = TextEditingController();
  var prixRenouvellementBCAmeliore = TextEditingController();
  
  var frequenceRenouvellementCBTrad = TextEditingController();
  var prixRenouvelementCBTrad = TextEditingController();
  var frequenceRenouvellementCBAmeliore = TextEditingController();
  var prixRenouvelementCBAmeliore = TextEditingController();

  
  _save(MenageEntity menageEnCours) async {
    menageEnCours.tailleMenage = int.tryParse(tailleDeMenageChoosed.text);
    menageEnCours.frequenceRenouvellementBCTrad = int.tryParse(frequenceRenouvellementBCTrad.text);
    menageEnCours.frequenceRenouvellementBCAmeliore = int.tryParse(frequenceRenouvellementBCAmeliore.text);
    menageEnCours.prixRenouvellementBCTrad = int.tryParse(prixRenouvellementBCTrad.text);
    menageEnCours.prixRenouvellementBCAmeliore = int.tryParse(prixRenouvellementBCAmeliore.text);
    menageEnCours.frequenceRenouvellementCBTrad = int.tryParse(frequenceRenouvellementCBTrad.text);
    menageEnCours.frequenceRenouvellementCBAmeliore = int.tryParse(frequenceRenouvellementCBAmeliore.text);
    menageEnCours.prixRenouvelementCBTrad = int.tryParse(prixRenouvelementCBTrad.text);
    menageEnCours.prixRenouvelementCBAmeliore = int.tryParse(prixRenouvelementCBAmeliore.text);
    dateFormat.format(date).compareTo(menageEnCours.dateMenage)!=0?menageEnCours.dateMenage = dateFormat.format(date):0;

    List<EnergieCuissonEntity> energies = [];

    energieCuissonSecheChoosed.forEach((key, value) {
      EnergieCuissonEntity energie = EnergieCuissonEntity();
      energie.energieCuisson = value['energie'];
      energie.autreEnergieCuisson= value['aenergie'];
      energie.qte = int.tryParse(value['qte']);
      energie.prix = int.tryParse(value['prix']);
      energie.saison = 'seche';
      energies.add(energie);
    });
    energieCuissonHumideChoosed.forEach((key, value) {
      EnergieCuissonEntity energie = EnergieCuissonEntity();
      energie.energieCuisson = value['energie'];
      energie.autreEnergieCuisson= value['aenergie'];
      energie.qte = int.tryParse(value['qte']);
      energie.prix = int.tryParse(value['prix']);
      energie.saison = 'humide';
      energies.add(energie);
    });

    DatabaseHelper helper = DatabaseHelper.instance;
    print(energies);
    int id = await helper.updateMenage(menageEnCours, energies);
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
          dateLabel = dateFormat.format(picked);
        });
  } 

  bool checkFoyer(String energie) {
    if(energieCuissonSecheChoosed.containsKey(energie) || energieCuissonHumideChoosed.containsKey(energie)) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    dateLabel = widget.menageEnCours.dateMenage;
    tailleDeMenageChoosed.text = widget.menageEnCours.tailleMenage.toString();
    frequenceRenouvellementBCTrad.text = widget.menageEnCours.frequenceRenouvellementBCTrad.toString();
    frequenceRenouvellementBCAmeliore.text = widget.menageEnCours.frequenceRenouvellementBCAmeliore.toString();
    prixRenouvellementBCTrad.text = widget.menageEnCours.prixRenouvellementBCTrad.toString();
    prixRenouvellementBCAmeliore.text = widget.menageEnCours.prixRenouvellementBCAmeliore.toString();
    frequenceRenouvellementCBTrad.text = widget.menageEnCours.frequenceRenouvellementCBTrad.toString();
    frequenceRenouvellementCBAmeliore.text = widget.menageEnCours.frequenceRenouvellementCBAmeliore.toString();
    prixRenouvelementCBTrad.text = widget.menageEnCours.prixRenouvelementCBTrad.toString();
    prixRenouvelementCBAmeliore.text = widget.menageEnCours.prixRenouvelementCBAmeliore.toString();

    for (var i = 0; i < widget.energieCuissons.length; i++) {
      if(widget.energieCuissons[i].saison.toLowerCase().contains('seche')) {
        energieCuissonSecheChoosed.putIfAbsent(widget.energieCuissons[i].energieCuisson, () => {
          "energie": widget.energieCuissons[i].energieCuisson,
          "aenergie": widget.energieCuissons[i].autreEnergieCuisson,
          "qte": widget.energieCuissons[i].qte.toString(),
          "prix": widget.energieCuissons[i].prix.toString(),
          "index": i.toString()
        });
        print('seche');
      } else {
        energieCuissonHumideChoosed.putIfAbsent(widget.energieCuissons[i].energieCuisson, () => {
          "energie": widget.energieCuissons[i].energieCuisson,
          "aenergie": widget.energieCuissons[i].autreEnergieCuisson,
          "qte": widget.energieCuissons[i].qte.toString(),
          "prix": widget.energieCuissons[i].prix.toString(),
          "index": i.toString()
        });
        print('humide');
      }
      checkFoyer('CB');
      checkFoyer('BC');
    }

    // print('energies');
    // print(widget.energieCuissons);
    
    return Scaffold(
        appBar: Navbar(
          title: "Ménage",
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
                  value: widget.menageEnCours.districtMenage,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      widget.menageEnCours.districtMenage = newValue;
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
                  value: widget.menageEnCours.agglomerationMenage,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      widget.menageEnCours.agglomerationMenage = newValue;
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
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Type de ménage",
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
                  value: widget.menageEnCours.typeMenage,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      widget.menageEnCours.typeMenage = newValue;
                      if(widget.menageEnCours.typeMenage.contains("Ménage")) {
                        showTailleMenage=true;
                        showTypeGrosConsommateur=false;
                      } else {
                        showTailleMenage=false;
                        showTypeGrosConsommateur=true;
                      }
                    });
                  },
                  items: typeMenage
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),

              // Taille de ménage
              Visibility(
                visible: showTailleMenage||widget.menageEnCours.typeMenage.contains('Ménage'),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Taille de ménage",
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                )
              ),
              
              Visibility(
                visible: showTailleMenage||widget.menageEnCours.typeMenage.contains('Ménage'),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Input(
                    // enable: false,
                    placeholder: "Entrer la taille de ménage",
                    borderColor: ArgonColors.white,
                    controller: tailleDeMenageChoosed,
                    // onTap: ()=>_selectDate(context),
                  ),
                )
              ),

              // Type de gros consommateur
              Visibility(
                visible: showTypeGrosConsommateur||!widget.menageEnCours.typeMenage.contains('Ménage'),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Type de gros consommateur",
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                )
              ),
              Visibility(
                visible: showTypeGrosConsommateur||!widget.menageEnCours.typeMenage.contains('Ménage'),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: DropdownButton<String>(
                    style: TextStyle(
                      fontSize: 12,
                      color: ArgonColors.text,
                      backgroundColor: Colors.white
                    ),
                    value: widget.menageEnCours.typeGrosConsommateur,
                    isExpanded: true,
                    onChanged: (String newValue) {
                      setState(() {
                        widget.menageEnCours.typeGrosConsommateur = newValue;
                      });
                    },
                    items: typeGrosConsommateur
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),

              // Saison sèche
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Saison sèche",
                    style: TextStyle(
                      color: ArgonColors.text,
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    )
                  ),
                ),
              ),

              Column(children: energieCuissonSecheChoosed.entries.map((e) {
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(e.value['energie'], 
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
                              if(e.value['aenergie'].length!=0) TableRow(
                                children: <Widget>[
                                  Text("Autre energie :", style: TextStyle(
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['aenergie'], 
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
                                  Text("Quantité par mois (kg) :", style: TextStyle(
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
                              TableRow(
                                children: <Widget>[
                                  Text("Prix par mois :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['prix'], 
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
                                widget.energieCuissons.removeAt(int.tryParse(e.value['index']));
                                energieCuissonSecheChoosed.remove(e.key);
                                checkFoyer('BC') ? showFoyerBC=true : showFoyerBC=false;
                                checkFoyer('CB') ? showFoyerCB=true : showFoyerCB=false;
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
                  child: Text("Energie de cuisson",
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
                  value: energieCuissonSecheTemp,
                  isExpanded: true,
                  onChanged: (String nValue) {
                    setState(() {
                      energieCuissonSecheTemp = nValue;
                      if(energieCuissonSecheTemp.contains('Autre')) {
                        showAutreEnergieSeche = true;
                      } else {
                        showAutreEnergieSeche = false;
                      }
                    });
                  },
                  items: listeEnergieCuisson
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),

              // Autre energie de cuisson saison seche
              Visibility(
                visible: showAutreEnergieSeche,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Autres énergies de cuissons",
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                )
              ),
              Visibility(
                visible: showAutreEnergieSeche,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: DropdownButton<String>(
                    style: TextStyle(
                      fontSize: 12,
                      color: ArgonColors.text,
                      backgroundColor: Colors.white
                    ),
                    value: autreEnergieCuissonSecheTemp,
                    isExpanded: true,
                    onChanged: (String newValue) {
                      setState(() {
                        autreEnergieCuissonSecheTemp = newValue;
                      });
                    },
                    items: listeAutreEnergieCuisson
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Quantité par mois (kg)",
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
                    placeholder: "Entrer la quantité utilisée par mois",
                    borderColor: ArgonColors.white,
                    controller: qteECSecheTemp,
                )
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Prix par mois",
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
                    placeholder: "Entrer le coût par mois",
                    borderColor: ArgonColors.white,
                    controller: prixECSecheTemp,
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
                        energieCuissonSecheChoosed.putIfAbsent(energieCuissonSecheTemp, () => {
                            "energie": energieCuissonSecheTemp,
                            "aenergie": autreEnergieCuissonSecheTemp,
                            "qte": qteECSecheTemp.text,
                            "prix": prixECSecheTemp.text
                          }
                        );
                        checkFoyer('BC') ? showFoyerBC=true : showFoyerBC=false;
                        checkFoyer('CB') ? showFoyerCB=true : showFoyerCB=false;
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

              // Saison humide
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Saison humide",
                    style: TextStyle(
                      color: ArgonColors.text,
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    )
                  ),
                ),
              ),

              Column(children: energieCuissonHumideChoosed.entries.map((e) {
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(e.value['energie'], 
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
                              if(e.value['aenergie'].length!=0) TableRow(
                                children: <Widget>[
                                  Text("Autre energie :", style: TextStyle(
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['aenergie'], 
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
                                  Text("Quantité par mois (kg) :", style: TextStyle(
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
                              TableRow(
                                children: <Widget>[
                                  Text("Prix par mois :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['prix'], 
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
                                widget.energieCuissons.removeAt(int.tryParse(e.value['index']));
                                energieCuissonHumideChoosed.remove(e.key);
                                checkFoyer('BC') ? showFoyerBC=true : showFoyerBC=false;
                                checkFoyer('CB') ? showFoyerCB=true : showFoyerCB=false;
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
                  child: Text("Energie de cuisson",
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
                  value: energieCuissonHumideTemp,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      energieCuissonHumideTemp = newValue;
                      if(energieCuissonHumideTemp.contains('Autre')) {
                        showAutreEnergieHumide = true;
                      } else {
                        showAutreEnergieHumide = false;
                      }
                    });
                  },
                  items: listeEnergieCuisson
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),

              // Autre energie de cuisson saison Humide
              Visibility(
                visible: showAutreEnergieHumide,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Autres énergies de cuissons",
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                )
              ),
              Visibility(
                visible: showAutreEnergieHumide,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: DropdownButton<String>(
                    style: TextStyle(
                      fontSize: 12,
                      color: ArgonColors.text,
                      backgroundColor: Colors.white
                    ),
                    value: autreEnergieCuissonHumideTemp,
                    isExpanded: true,
                    onChanged: (String newValue) {
                      setState(() {
                        autreEnergieCuissonHumideTemp = newValue;
                      });
                    },
                    items: listeAutreEnergieCuisson
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Quantité par mois (kg)",
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
                    placeholder: "Entrer la quantité utilisée par mois",
                    borderColor: ArgonColors.white,
                    controller: qteECHumideTemp,
                )
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Prix par mois",
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
                    placeholder: "Entrer le coût par mois",
                    borderColor: ArgonColors.white,
                    controller: prixECHumideTemp,
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
                        energieCuissonHumideChoosed.putIfAbsent(energieCuissonHumideTemp, () => {
                            "energie": energieCuissonHumideTemp,
                            "aenergie": autreEnergieCuissonHumideTemp,
                            "qte": qteECHumideTemp.text,
                            "prix": prixECHumideTemp.text
                          }
                        );
                        checkFoyer('BC') ? showFoyerBC=true : showFoyerBC=false;
                        checkFoyer('CB') ? showFoyerCB=true : showFoyerCB=false;
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

            // BC 
            
            // Foyer traditionnel
            Visibility(
              visible: showFoyerBC,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Foyer traditionnel BC",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              )
            ),
            Visibility(
              visible: showFoyerBC,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Input(
                  enable: true,
                  placeholder: "Entrer la fréquence de renouvellement par an",
                  borderColor: ArgonColors.white,
                  controller: frequenceRenouvellementBCTrad,
                ),
              )
            ),
            Visibility(
              visible: showFoyerBC,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Input(
                  enable: true,
                  placeholder: "Entrer le prix",
                  borderColor: ArgonColors.white,
                  controller: prixRenouvellementBCTrad,
                ),
              )
            ),          
              
            // Foyer amélioré
            Visibility(
              visible: showFoyerBC,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Foyer amélioré BC",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              )
            ),
            Visibility(
              visible: showFoyerBC,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Input(
                  enable: true,
                  placeholder: "Entrer la fréquence de renouvellement par an",
                  borderColor: ArgonColors.white,
                  controller: frequenceRenouvellementBCAmeliore,
                ),
              )
            ),
            Visibility(
              visible: showFoyerBC,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Input(
                  enable: true,
                  placeholder: "Entrer le prix",
                  borderColor: ArgonColors.white,
                  controller: prixRenouvellementBCAmeliore,
                ),
              )
            ),   

            // CB
            
            // Foyer traditionnel
            Visibility(
              visible: showFoyerCB,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Foyer traditionnel CB",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              )
            ),
            Visibility(
              visible: showFoyerCB,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Input(
                  enable: true,
                  placeholder: "Entrer la fréquence de renouvellement par an",
                  borderColor: ArgonColors.white,
                  controller: frequenceRenouvellementCBTrad,
                ),
              )
            ),
            Visibility(
              visible: showFoyerCB,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Input(
                  enable: true,
                  placeholder: "Entrer le prix",
                  borderColor: ArgonColors.white,
                  controller: prixRenouvelementCBTrad,
                ),
              )
            ),          
              
            // Foyer amélioré
            Visibility(
              visible: showFoyerCB,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Foyer amélioré CB",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              )
            ),
            Visibility(
              visible: showFoyerCB,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Input(
                  enable: true,
                  placeholder: "Entrer la fréquence de renouvellement par an",
                  borderColor: ArgonColors.white,
                  controller: frequenceRenouvellementCBAmeliore,
                ),
              )
            ),
            Visibility(
              visible: showFoyerCB,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Input(
                  enable: true,
                  placeholder: "Entrer le prix",
                  borderColor: ArgonColors.white,
                  controller: prixRenouvelementCBAmeliore,
                ),
              )
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
                    _save(widget.menageEnCours);
                    Navigator.pushReplacementNamed(context, '/listemenage');
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
