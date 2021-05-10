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

List<String> typeMeule = [
  'Traditionnel', 'Amélioré'
];

List<String> listeMeuleAmeliore = ['Non défini', 'MATI(Meule Amélioré à Tirage Inversée)', 'VMTP(Voay MiTaPy)', 'GMDR(Green Mad Dome Retort)', 'Autre'];

List<String> listeZonePrelevement = ['Forêt naturelle', 'Plantation', 'Mangrove', 'Arbre hors forêts'];
List<String> listeDomainePrelevement = ['Domaine\'état', 'Domaine privé', 'TG'];

class CharbonnierModification extends StatefulWidget {
  final CharbonnierEntity charbonnierEnCours;
  final List<MeuleEntity> meules;

  const CharbonnierModification(
    {Key key, this.charbonnierEnCours, this.meules}
  ):super(key: key); 

  @override
  _CharbonnierModificationState createState() => _CharbonnierModificationState();
}

class _CharbonnierModificationState extends State<CharbonnierModification> {
  final _formKey = GlobalKey<FormState>();  

  // DateFormat().format(date);
  String dateLabel = "Choisir la date";
  
  bool showTailleCharbonnier = false;
  DateTime date = new DateTime.now(); 
  String districtChoosed;
  String agglomerationChoosed;

  Map<String, Map<String, String>> meules = {};
  
  var especeBois = TextEditingController();
  var longueurTemp = TextEditingController();
  var largeurTemp = TextEditingController();
  var hauteurTemp = TextEditingController();
  var qte = TextEditingController();
  var qteC = TextEditingController();
  String typeMeuleChoosed;
  bool showMeuleAmeliore = false;
  String meuleAmelioreChoosed;
  String zonePrelevementChoosed;
  String domainePrelevementChoosed;
  bool autorisation = false;

  
  _save(CharbonnierEntity charbonnierEnCours) async {
    if(meules.length == 0) return null;

    // charbonnierEnCours.districtCharbonnier = districtChoosed;
    String dateString = DateFormat('dd-MM-yyyy').format(date);
    dateString.compareTo(charbonnierEnCours.dateCharbonnier)!=0?charbonnierEnCours.dateCharbonnier=dateString:0;
    charbonnierEnCours.especeBoisCharbonnier = especeBois.text;
    // charbonnierEnCours.qteBoisCharbonnier = double.tryParse(qte.text);
    // charbonnierEnCours.qteCharbonCharbonnier = double.tryParse(qteC.text);
    // charbonnierEnCours.zonePrelevelementCharbonnier = zonePrelevementChoosed;
    // charbonnierEnCours.domainePrelevelementCharbonnier = domainePrelevementChoosed;
    // charbonnierEnCours.autorisationCharbonnier = autorisation;

    List<MeuleEntity> listeMeules = [];

    meules.forEach((key, value) {
      MeuleEntity meule = MeuleEntity();
      meule.typeMeule = value['type'];
      meule.meule= value['meule'];
      meule.longueur = double.tryParse(value['longueur']);
      meule.largeur = double.tryParse(value['largeur']);
      meule.hauteur = double.tryParse(value['hauteur']);
      meule.qteB = double.tryParse(value['qteB']);
      meule.qteC = double.tryParse(value['qteC']);
      listeMeules.add(meule);
    });

    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.updateCharbonnier(charbonnierEnCours, listeMeules);
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
          dateLabel = DateFormat('dd-MM-yyyy').format(picked);
        });
  } 

  @override
  Widget build(BuildContext context) {
    especeBois.text = widget.charbonnierEnCours.especeBoisCharbonnier.toString();
    // qte.text = widget.charbonnierEnCours.qteBoisCharbonnier.toString();
    // qteC.text = widget.charbonnierEnCours.qteCharbonCharbonnier.toString();
    dateLabel = widget.charbonnierEnCours.dateCharbonnier;
    
    for (var i = 0; i < widget.meules.length; i++) {
      meules.putIfAbsent(widget.meules[i].typeMeule, () => {
        "type": widget.meules[i].typeMeule,
        "meule": widget.meules[i].meule,
        "longueur": widget.meules[i].longueur.toString(),
        "largeur": widget.meules[i].largeur.toString(),
        "hauteur": widget.meules[i].hauteur.toString(),
        "qteB": widget.meules[i].qteB.toString(),
        "qteC": widget.meules[i].qteC.toString(),
        "index": i.toString()
      });
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
                  value: widget.charbonnierEnCours.districtCharbonnier,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      widget.charbonnierEnCours.districtCharbonnier = newValue;
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
                  value: widget.charbonnierEnCours.agglomerationCharbonnier,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      widget.charbonnierEnCours.agglomerationCharbonnier = newValue;
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

              // Saison sèche
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Meules",
                    style: TextStyle(
                      color: ArgonColors.text,
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    )
                  ),
                ),
              ),

              Column(children: meules.entries.map((e) {
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(e.value['type'], 
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
                              if(e.value['meule']!=null) TableRow(
                                children: <Widget>[
                                  Text("Meule :", style: TextStyle(
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['meule'], 
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
                                  Text("Longueur :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['longueur'], 
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
                                  Text("Largeur :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['largeur'], 
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
                                  Text("Hauteur :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['hauteur'], 
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
                                  Text("Quantité de bois :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['qteB'], 
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
                                  Text("Qte de charbon :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['qteC'], 
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
                                widget.meules.removeAt(int.tryParse(e.value['index']));
                                meules.remove(e.key);
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
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Type de meule utilisée",
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
                  value: typeMeuleChoosed,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      typeMeuleChoosed = newValue;
                      typeMeuleChoosed.contains("Amélioré")?showMeuleAmeliore=true:showMeuleAmeliore=false;
                    });
                  },
                  items: typeMeule
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),

              // Meule ameliore
              Visibility(
                visible: showMeuleAmeliore,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Type de meule amélioré",
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                )
              ),
              Visibility(
                visible: showMeuleAmeliore,
                child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: DropdownButton<String>(
                    style: TextStyle(
                      fontSize: 12,
                      color: ArgonColors.text,
                      backgroundColor: Colors.white
                    ),
                    value: meuleAmelioreChoosed,
                    isExpanded: true,
                    onChanged: (String newValue) {
                      setState(() {
                        meuleAmelioreChoosed = newValue;
                      });
                    },
                    items: listeMeuleAmeliore
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
                  child: Text("Longueur",
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
                    placeholder: "Entrer la longueur de la meule",
                    borderColor: ArgonColors.white,
                    controller: longueurTemp,
                )
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Largeur",
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
                    placeholder: "Entrer la largeur de la meule",
                    borderColor: ArgonColors.white,
                    controller: largeurTemp,
                )
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Hauteur",
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
                    placeholder: "Entrer la hauteur de la meule",
                    borderColor: ArgonColors.white,
                    controller: hauteurTemp,
                )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Quantité de bois utilisé",
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
                    placeholder: "Entrer la quantité de bois utilisé",
                    borderColor: ArgonColors.white,
                    controller: qte,
                )
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Quantité de charbon produit",
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
                    placeholder: "Entrer la quantité de charbon produit",
                    borderColor: ArgonColors.white,
                    controller: qteC,
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
                        meules.putIfAbsent(typeMeuleChoosed, () => {
                          "type": typeMeuleChoosed,
                          "meule": meuleAmelioreChoosed,
                          "longueur": longueurTemp.text,
                          "largeur": largeurTemp.text,
                          "hauteur": hauteurTemp.text,
                          "qteB": qte.text,
                          "qteC": qteC.text
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

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Espèce de bois utilisé",
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
                    placeholder: "Entrer l'espèce de bois utilisé",
                    borderColor: ArgonColors.white,
                    controller: especeBois
                )
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Zone de prélèvement",
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
                  value: widget.charbonnierEnCours.zonePrelevelementCharbonnier,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      widget.charbonnierEnCours.zonePrelevelementCharbonnier = newValue;
                    });
                  },
                  items: listeZonePrelevement
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 8.0),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Domaine de prélèvement",
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
                  value: widget.charbonnierEnCours.domainePrelevelementCharbonnier,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      widget.charbonnierEnCours.domainePrelevelementCharbonnier = newValue;
                    });
                  },
                  items: listeDomainePrelevement
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 8.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Autorisation d'exploiter",
                          style: TextStyle(
                              color: ArgonColors.text,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ),
                  ),
                  Switch.adaptive(
                    value: widget.charbonnierEnCours.autorisationCharbonnier,
                    onChanged: (bool newValue) =>
                        setState(() => widget.charbonnierEnCours.autorisationCharbonnier = newValue),
                    activeColor: ArgonColors.primary,
                  ),
                ],
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
                    _save(widget.charbonnierEnCours);
                    Navigator.pushReplacementNamed(context, '/listecharbonnier');
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
