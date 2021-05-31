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
  'Vohemar '];

List<String> agglomeration = [
  'Urbaine', 'Rurale'
];

List<String> typeMenage = [
  'Ménage', 'Gros consommateur'
];

List<String> typeGrosConsommateur = [
  'Industriel',
  'Artisanal(brique, distillerie, ...)',
  'Restauration(Restaurant, gargote, boulangerie, ...)'
];

List<String> listeEnergieCuisson = [
  'Bois de Chauffe', 'Charbon de Bois', 'Biogaz', 'Gaz', 'Bioéthanol',
  'Résidus agricoles/Sous-produits', 'Electricité', 'Briquette/Charbon Vert',
  'Pétrole'
];

List<String> listetypeFoyer = [
  'Foyer traditionnel', 'Foyer amélioré'
];

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
  final dateFormat = DateFormat('dd-MM-yyyy');
  String unite = '(kg)';

  String dateLabel = "Choisir la date";
  bool showTailleMenage = false;
  bool showTypeGrosConsommateur = false;
  List<Widget> energieCuissonSecheWidget = [SizedBox(height: 8.0),];
  String energieCuissonSecheTempChoosed;
  String typeFoyerTempChoosed;
  bool showTypeFoyer = false;
  List<Widget> energieCuissonHumideWidget = [SizedBox(height: 8.0),];
  String energieCuissonHumideTempChoosed;
  String typeFoyerHumideTempChoosed;
  bool showTypeFoyerHumide = false;
  bool showFoyer = false;

  DatabaseHelper helper = DatabaseHelper.instance;

  // int idMenageEnCours;

  DateTime date = new DateTime.now(); 
  String districtChoosed = "";
  String agglomerationChoosed = "";
  String typeMenageChoosed = "";
  var tailleDeMenageChoosed = TextEditingController();
  String typeGrosConsommateurChoosed = "";

  var commune = TextEditingController();
  var agg = TextEditingController();

  // Liste énergie de cuisson sèche
  Map<String, Map<String, String>> energieCuissonSecheChoosed = {};
  var frequenceFoyer = TextEditingController();
  var puFoyer = TextEditingController();
  var qteECSecheTemp = TextEditingController();
  var prixECSecheTemp = TextEditingController();

  // Liste énergie de cuisson humide
  Map<String, Map<String, String>> energieCuissonHumideChoosed = {};
  var frequenceFoyerH = TextEditingController();
  var puFoyerH = TextEditingController();
  var qteECHumideTemp = TextEditingController();
  var prixECHumideTemp = TextEditingController();

  
  _save(MenageEntity menageEnCours) async {
    menageEnCours.tailleMenage = int.tryParse(tailleDeMenageChoosed.text);
    dateFormat.format(date).compareTo(menageEnCours.dateMenage)!=0?menageEnCours.dateMenage = dateFormat.format(date):0;
    menageEnCours.commune = commune.text;
    menageEnCours.agg = agg.text;

    List<EnergieCuissonEntity> energies = [];

    energieCuissonSecheChoosed.forEach((key, value) {
      EnergieCuissonEntity energie = EnergieCuissonEntity();
      energie.energieCuisson = value['energie'];
      energie.typeFoyer = value['aenergie'];
      energie.qte = int.tryParse(value['qte']);
      energie.prix = int.tryParse(value['prix']);
      energie.frequenceFoyer = double.tryParse(value['frequence']);
      energie.puFoyer = double.tryParse(value['pu']);
      energie.saison = 'seche';
      energies.add(energie);
    });
    energieCuissonHumideChoosed.forEach((key, value) {
      EnergieCuissonEntity energie = EnergieCuissonEntity();
      energie.energieCuisson = value['energie'];
      energie.typeFoyer = value['aenergie'];
      energie.qte = int.tryParse(value['qte']);
      energie.prix = int.tryParse(value['prix']);
      energie.frequenceFoyer = double.tryParse(value['frequence']);
      energie.puFoyer = double.tryParse(value['pu']);
      energie.saison = 'humide';
      energies.add(energie);
    });

    DatabaseHelper helper = DatabaseHelper.instance;
    print(energies);
    int id = await helper.updateMenage(menageEnCours, energies);
    print(id);
    
  }


  Future<void> _selectDate(BuildContext context, MenageEntity m) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2018, 1),
      lastDate: DateTime(2101));
      if (picked != null && picked != date)
        setState(() {
          date = picked;
          dateLabel = dateFormat.format(picked);
          m.dateMenage = dateLabel;
          print(dateLabel);
        });
  }

  // true if show and false if hide
  bool checkFoyer(String newEnergie) {
    bool valiny = true;
    energieCuissonSecheChoosed.forEach((key, value) {
      print('seche:');
      print(newEnergie);
      print('humide:');
      print(value['energie']);
      if (newEnergie.compareTo(value['energie']) == 0) {
        print('mitovy');
        valiny = false;
      }
    });
    return valiny;
  }

  @override
  Widget build(BuildContext context) {
    dateLabel = widget.menageEnCours.dateMenage;
    tailleDeMenageChoosed.text = widget.menageEnCours.tailleMenage.toString();
    commune.text = widget.menageEnCours.commune;
    agg.text = widget.menageEnCours.agg;

    for (var i = 0; i < widget.energieCuissons.length; i++) {
      if(widget.energieCuissons[i].saison.toLowerCase().contains('seche')) {
        energieCuissonSecheChoosed.putIfAbsent(widget.energieCuissons[i].energieCuisson, () => {
          "energie": widget.energieCuissons[i].energieCuisson,
          "aenergie": widget.energieCuissons[i].typeFoyer,
          "qte": widget.energieCuissons[i].qte.toString(),
          "prix": widget.energieCuissons[i].prix.toString(),
          "frequence": widget.energieCuissons[i].frequenceFoyer.toString(),
          "pu": widget.energieCuissons[i].puFoyer.toString(),
          "index": i.toString()
        });
        print('seche');
      } else {
        energieCuissonHumideChoosed.putIfAbsent(widget.energieCuissons[i].energieCuisson, () => {
          "energie": widget.energieCuissons[i].energieCuisson,
          "aenergie": widget.energieCuissons[i].typeFoyer,
          "qte": widget.energieCuissons[i].qte.toString(),
          "prix": widget.energieCuissons[i].prix.toString(),
          "frequence": widget.energieCuissons[i].frequenceFoyer.toString(),
          "pu": widget.energieCuissons[i].puFoyer.toString(),
          "index": i.toString()
        });
        print('humide');
      }
    }

    // print('energies');
    // print(widget.energieCuissons);
    
    return Scaffold(
        appBar: Navbar(
          title: "Consommateur",
          rightOptions: false,
        ),
        backgroundColor: ArgonColors.white,
        drawer: ArgonDrawer(currentPage: "MenageM"),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
          child: SafeArea(
            bottom: true,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16),
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
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0,
                                color: Color.fromRGBO(223, 225, 229, 1),
                                style: BorderStyle.solid
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(4.0))
                        ),
                      ),
                      child: GestureDetector(
                        onTap: ()=>_selectDate(context, widget.menageEnCours),
                        child: Input(
                          enable: false,
                          placeholder: widget.menageEnCours.dateMenage,
                          borderColor: Color.fromRGBO(223, 225, 229, 1),
                        ),
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
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
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0,
                                color: Color.fromRGBO(223, 225, 229, 1),
                                style: BorderStyle.solid
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(4.0))
                        ),
                      ),
                      child: Padding(
                          padding:const EdgeInsets.only(left: 8.0),
                          child: DropdownButton<String>(
                            hint: Text("Choisir le district",
                                style: TextStyle(
                                    color: ArgonColors.muted,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14
                                )
                            ),
                            underline: SizedBox(),
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
                      )
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
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0,
                                color: Color.fromRGBO(223, 225, 229, 1),
                                style: BorderStyle.solid
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(4.0))
                        ),
                      ),
                      child: Padding(
                          padding:const EdgeInsets.only(left: 8.0),
                          child: DropdownButton<String>(
                            hint: Text("Choisir l'unité d'agglomération",
                                style: TextStyle(
                                    color: ArgonColors.muted,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14
                                )
                            ),
                            underline: SizedBox(),
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
                          )
                      )
                  )
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
                      borderColor: Color.fromRGBO(223, 225, 229, 1),
                      controller: commune
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
                      placeholder: "Entrer le nom de l'agglomération ",
                      borderColor: Color.fromRGBO(223, 225, 229, 1),
                      controller: agg
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Type de consommateur",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0,
                                color: Color.fromRGBO(223, 225, 229, 1),
                                style: BorderStyle.solid
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(4.0))
                        ),
                      ),
                      child: Padding(
                          padding:const EdgeInsets.only(left: 8.0),
                          child: DropdownButton<String>(
                            hint: Text("Choisir le type de consommateur",
                                style: TextStyle(
                                    color: ArgonColors.muted,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14
                                )
                            ),
                            underline: SizedBox(),
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
                          )
                      )
                  )
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
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: tailleDeMenageChoosed,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
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
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0,
                                  color: Color.fromRGBO(223, 225, 229, 1),
                                  style: BorderStyle.solid
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(4.0))
                          ),
                        ),
                        child: Padding(
                            padding:const EdgeInsets.only(left: 8.0),
                            child: DropdownButton<String>(
                              hint: Text("Choisir le type de gros consommateur",
                                  style: TextStyle(
                                      color: ArgonColors.muted,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14
                                  )
                              ),
                              underline: SizedBox(),
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
                            )
                        )
                    )
                )
              ),

              // Saison sèche
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 24.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Consommation en saison sèche",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w600,
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
                              TableRow(
                                children: <Widget>[
                                  Text("Quantité consommée :", style: TextStyle(
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
                                  Text("Prix :", style: TextStyle(
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
                              if(e.value['aenergie']!=null && e.value['aenergie'].length!=0) TableRow(
                                children: <Widget>[
                                  Text("Types de foyers utilisés :", style: TextStyle(
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
                                  Text("Renouvellement de foyers :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                  )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['frequence'],
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
                                  Text("Prix total annuel de foyer :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                  )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['pu'],
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
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0,
                                color: Color.fromRGBO(223, 225, 229, 1),
                                style: BorderStyle.solid
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(4.0))
                        ),
                      ),
                      child: Padding(
                          padding:const EdgeInsets.only(left: 8.0),
                          child: DropdownButton<String>(
                            hint: Text("Choisir le type d'énergie de cuisson",
                                style: TextStyle(
                                    color: ArgonColors.muted,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14
                                )
                            ),
                            underline: SizedBox(),
                            style: TextStyle(
                                fontSize: 12,
                                color: ArgonColors.text,
                                backgroundColor: Colors.white
                            ),
                            value: energieCuissonSecheTempChoosed,
                            isExpanded: true,
                            onChanged: (String nValue) {
                              setState(() {
                                energieCuissonSecheTempChoosed = nValue;
                                if(energieCuissonSecheTempChoosed.contains('Charbon de Bois')
                                    ||energieCuissonSecheTempChoosed.contains('Bois de Chauffe')) {
                                  showTypeFoyer = true;
                                } else {
                                  showTypeFoyer = false;
                                }
                                if(energieCuissonSecheTempChoosed.contains('Biogaz')){
                                  unite = '(m³)';
                                } else if(energieCuissonSecheTempChoosed.contains('Electricité')) {
                                  unite = '(kWh)';
                                } else if(energieCuissonSecheTempChoosed.contains('Bioéthanol')
                                    ||energieCuissonSecheTempChoosed.contains('Pétrol')) {
                                  unite = '(l)';
                                } else {
                                  unite = '(kg)';
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
                      )
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Quantité déstinée à la cuisson par mois",
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
                    placeholder: "Entrer la quantité "+unite,
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: qteECSecheTemp,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
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
                    placeholder: "Entrer le coût par mois (Ar)",
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: prixECSecheTemp,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
                  )
              ),
              // Type foyer
              Visibility(
                  visible: showTypeFoyer,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Types de foyers utilisés",
                          style: TextStyle(
                              color: ArgonColors.text,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ),
                  )
              ),
              Visibility(
                visible: showTypeFoyer,
                child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0,
                                  color: Color.fromRGBO(223, 225, 229, 1),
                                  style: BorderStyle.solid
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(4.0))
                          ),
                        ),
                        child: Padding(
                            padding:const EdgeInsets.only(left: 8.0),
                            child: DropdownButton<String>(
                              hint: Text("Choisir le type de foyer utilisé",
                                  style: TextStyle(
                                      color: ArgonColors.muted,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14
                                  )
                              ),
                              underline: SizedBox(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: ArgonColors.text,
                                  backgroundColor: Colors.white
                              ),
                              value: typeFoyerTempChoosed,
                              isExpanded: true,
                              onChanged: (String newValue) {
                                setState(() {
                                  typeFoyerTempChoosed = newValue;
                                });
                              },
                              items: listetypeFoyer
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                        )
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Fréquence de renouvellement des foyers par an",
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
                    placeholder: "Entrer la fréquence annuelle",
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: frequenceFoyer,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Prix total annuel des foyers",
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
                    placeholder: "Entrer le prix total annuel des foyers (Ar)",
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: puFoyer,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
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
                        energieCuissonSecheChoosed.putIfAbsent(energieCuissonSecheTempChoosed, () => {
                            "energie": energieCuissonSecheTempChoosed,
                            "aenergie": typeFoyerTempChoosed,
                            "qte": qteECSecheTemp.text,
                            "prix": prixECSecheTemp.text,
                            "frequence" : frequenceFoyer.text,
                            "pu" : puFoyer.text
                          }
                        );
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
                padding: const EdgeInsets.only(left: 8.0, top: 24.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Consommation en saison humide",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w600,
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
                              TableRow(
                                children: <Widget>[
                                  Text("Quantité consommée :", style: TextStyle(
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
                                  Text("Prix :", style: TextStyle(
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
                              if(e.value['aenergie']!=null && e.value['aenergie'].length!=0) TableRow(
                                children: <Widget>[
                                  Text("Types de foyers utilisés :", style: TextStyle(
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
                              if(e.value['frequence']!=null && e.value['frequence'].compareTo('null')!=0
                                  && e.value['frequence'].length!=0) TableRow(
                                children: <Widget>[
                                  Text("Renouvellement de foyers :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                  )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['frequence'],
                                        style: TextStyle(
                                            color: ArgonColors.text,
                                            fontSize: 12
                                        ),
                                        textAlign:TextAlign.end
                                    ),
                                  ),
                                ],
                              ),
                              if(e.value['pu']!=null && e.value['pu'].compareTo('null')!=0
                                  && e.value['pu'].length!=0) TableRow(
                                children: <Widget>[
                                  Text("Prix total annuel de foyer :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                  )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['pu'],
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
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0,
                                color: Color.fromRGBO(223, 225, 229, 1),
                                style: BorderStyle.solid
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(4.0))
                        ),
                      ),
                      child: Padding(
                          padding:const EdgeInsets.only(left: 8.0),
                          child: DropdownButton<String>(
                            hint: Text("Choisir le type d'énergie de cuisson",
                                style: TextStyle(
                                    color: ArgonColors.muted,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14
                                )
                            ),
                            underline: SizedBox(),
                            style: TextStyle(
                                fontSize: 12,
                                color: ArgonColors.text,
                                backgroundColor: Colors.white
                            ),
                            value: energieCuissonHumideTempChoosed,
                            isExpanded: true,
                            onChanged: (String newValue) {
                              setState(() {
                                energieCuissonHumideTempChoosed = newValue;
                                if(energieCuissonHumideTempChoosed.contains('Charbon de Bois')
                                    || energieCuissonHumideTempChoosed.contains('Bois de Chauffe')) {
                                  showTypeFoyerHumide = true;
                                } else {
                                  showTypeFoyerHumide = false;
                                }
                                if(energieCuissonHumideTempChoosed.contains('Biogaz')){
                                  unite = '(m³)';
                                } else if(energieCuissonHumideTempChoosed.contains('Electricité')) {
                                  unite = '(kWh)';
                                } else if(energieCuissonHumideTempChoosed.contains('Bioéthanol')
                                    ||energieCuissonHumideTempChoosed.contains('Pétrol')) {
                                  unite = '(l)';
                                } else {
                                  unite = '(kg)';
                                }
                                showFoyer = checkFoyer(energieCuissonHumideTempChoosed);
                              });
                            },
                            items: listeEnergieCuisson
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                      )
                  )
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
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: qteECHumideTemp,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
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
                    placeholder: "Entrer le coût par mois (Ar)",
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: prixECHumideTemp,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
                  )
              ),
              // Types de foyers utilisés saison Humide
              Visibility(
                  visible: showTypeFoyerHumide,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Types de foyers utilisés",
                          style: TextStyle(
                              color: ArgonColors.text,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ),
                  )
              ),
              Visibility(
                visible: showTypeFoyerHumide,
                child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0,
                                  color: Color.fromRGBO(223, 225, 229, 1),
                                  style: BorderStyle.solid
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(4.0))
                          ),
                        ),
                        child: Padding(
                            padding:const EdgeInsets.only(left: 8.0),
                            child: DropdownButton<String>(
                              hint: Text("Choisir le type de foyer utilisé",
                                  style: TextStyle(
                                      color: ArgonColors.muted,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14
                                  )
                              ),
                              underline: SizedBox(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: ArgonColors.text,
                                  backgroundColor: Colors.white
                              ),
                              value: typeFoyerHumideTempChoosed,
                              isExpanded: true,
                              onChanged: (String newValue) {
                                setState(() {
                                  typeFoyerHumideTempChoosed = newValue;
                                });
                              },
                              items: listetypeFoyer
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                        )
                    )
                )
              ),
              Visibility(
                  visible: showFoyer,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Fréquence de renouvellement des foyers par an",
                          style: TextStyle(
                              color: ArgonColors.text,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ),
                  )
              ),
              Visibility(
                visible: showFoyer,
                child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Input(
                      enable: true,
                      placeholder: "Entrer la fréquence annuelle",
                      borderColor: Color.fromRGBO(223, 225, 229, 1),
                      controller: frequenceFoyerH,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
                    )
                ),
              ),
              Visibility(
                  visible: showFoyer,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Prix total annuel des foyers",
                          style: TextStyle(
                              color: ArgonColors.text,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ),
                  )
              ),
              Visibility(
                visible: showFoyer,
                child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Input(
                      enable: true,
                      placeholder: "Entrer le prix total annuel des foyers (Ar)",
                      borderColor: Color.fromRGBO(223, 225, 229, 1),
                      controller: puFoyerH,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
                    )
                ),
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
                        energieCuissonHumideChoosed.putIfAbsent(energieCuissonHumideTempChoosed, () => {
                            "energie": energieCuissonHumideTempChoosed,
                            "aenergie": typeFoyerHumideTempChoosed,
                            "qte": qteECHumideTemp.text,
                            "prix": prixECHumideTemp.text,
                            "frequence": frequenceFoyerH.text,
                            "pu": puFoyerH.text
                          }
                        );
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
