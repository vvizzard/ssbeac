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

List<String> typeMeule = [
  'Traditionnelle', 'MATI', 'VMTP', 'GMDR', 'Autre'
];

/*List<String> listeMeuleAmeliore = [
  'MATI(Meule Amélioré à Tirage Inversée)', 'VMTP(Voay MiTaPy)',
  'GMDR(Green Mad Dome Retort)', 'Autre'
];*/

List<String> listeZonePrelevement = [
  'Forêt naturelle', 'Plantation', 'Mangrove', 'Arbre hors forêts'
];
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
  var formateur = TextEditingController();
  var commune = TextEditingController();
  var agg = TextEditingController();
  String zonePrelevementChoosed;
  String domainePrelevementChoosed;
  String typeMeuleChoosed;
  bool showMeuleAmeliore = false;
  String meuleAmelioreChoosed;

  
  _save(CharbonnierEntity charbonnierEnCours) async {
    if(meules.length == 0) return null;

    String dateString = DateFormat('dd-MM-yyyy').format(date);
    dateString.compareTo(charbonnierEnCours.dateCharbonnier)!=0?charbonnierEnCours.dateCharbonnier=dateString:0;
    charbonnierEnCours.especeBoisCharbonnier = especeBois.text;
    charbonnierEnCours.formateur = formateur.text;

    List<MeuleEntity> listeMeules = [];

    meules.forEach((key, value) {
      MeuleEntity meule = MeuleEntity();
      meule.typeMeule = value['type'];
      // meule.meule= value['meule'];
      meule.longueur = double.tryParse(value['longueur']);
      meule.largeur = double.tryParse(value['largeur']);
      meule.hauteur = double.tryParse(value['hauteur']);
      meule.qteB = double.tryParse(value['qteB']);
      meule.qteC = double.tryParse(value['qteC']);
      meule.zonePrelevement = value['zone'];
      meule.domaine = value['domaine'];
      listeMeules.add(meule);
    });

    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.updateCharbonnier(charbonnierEnCours, listeMeules);
    print(id);
    
  }


  Future<void> _selectDate(BuildContext context, CharbonnierEntity c) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2018, 1),
      lastDate: DateTime(2101));
      if (picked != null && picked != date)
        setState(() {
          date = picked;
          dateLabel = DateFormat('dd-MM-yyyy').format(picked);
          c.dateCharbonnier = dateLabel;
        });
  } 

  @override
  Widget build(BuildContext context) {
    especeBois.text = widget.charbonnierEnCours.especeBoisCharbonnier.toString();
    dateLabel = widget.charbonnierEnCours.dateCharbonnier;
    formateur.text = widget.charbonnierEnCours.formateur;
    commune.text = widget.charbonnierEnCours.commune;
    agg.text = widget.charbonnierEnCours.agg;
    
    for (var i = 0; i < widget.meules.length; i++) {
      meules.putIfAbsent(widget.meules[i].typeMeule, () => {
        "type": widget.meules[i].typeMeule,
        // "meule": widget.meules[i].meule,
        "longueur": widget.meules[i].longueur.toString(),
        "largeur": widget.meules[i].largeur.toString(),
        "hauteur": widget.meules[i].hauteur.toString(),
        "qteB": widget.meules[i].qteB.toString(),
        "qteC": widget.meules[i].qteC.toString(),
        "zone": widget.meules[i].zonePrelevement,
        "domaine" : widget.meules[i].domaine,
        "index": i.toString()
      });
    }
    
    return Scaffold(
        appBar: Navbar(
          title: "Charbonnier",
          rightOptions: false,
        ),
        backgroundColor: ArgonColors.white,
        drawer: ArgonDrawer(currentPage: "CharbonnierM"),
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
                        onTap: ()=>_selectDate(context, widget.charbonnierEnCours),
                        child: Input(
                          enable: false,
                          placeholder: widget.charbonnierEnCours.dateCharbonnier,
                          borderColor: Color.fromRGBO(223, 225, 229, 1),
                        ),
                      )
                  ),
                ),
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
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: agg,
                  )
              ),
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
                              /*if(e.value['meule']!=null) TableRow(
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
                              ),*/
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
                                  Text("Zone de prélèvement :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                  )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['zone'],
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
                                  Text("Domaine :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                  )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['domaine'],
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
                  child: Text("Type de meule de carbonisation utilisée",
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
                      )
                  )
              ),

              /*// Meule ameliore
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
              ),*/

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
                    placeholder: "Entrer la longueur (m)",
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: longueurTemp,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
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
                    placeholder: "Entrer la largeur (m)",
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: largeurTemp,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
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
                    placeholder: "Entrer la hauteur (m)",
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: hauteurTemp,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
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
                            value: zonePrelevementChoosed,
                            isExpanded: true,
                            onChanged: (String newValue) {
                              setState(() {
                                zonePrelevementChoosed = newValue;
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
                      )
                  )
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
                            value: domainePrelevementChoosed,
                            isExpanded: true,
                            onChanged: (String newValue) {
                              setState(() {
                                domainePrelevementChoosed = newValue;
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
                      )
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
                    placeholder: "Entrer la quantité de bois utilisé (kg)",
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: qte,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
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
                    placeholder: "Entrer la quantité de charbon produit (kg)",
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: qteC,
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
                        meules.putIfAbsent(typeMeuleChoosed, () => {
                          "type": typeMeuleChoosed,
                          // "meule": meuleAmelioreChoosed,
                          "longueur": longueurTemp.text,
                          "largeur": largeurTemp.text,
                          "hauteur": hauteurTemp.text,
                          "zone": zonePrelevementChoosed,
                          "domaine": domainePrelevementChoosed,
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
                    placeholder: "Dresser la liste des espèces utilisées",
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: especeBois
                )
              ),

              SizedBox(height: 8.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Existence d'authorisation ou permis",
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

              SizedBox(height: 8.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Participation à une/des formation(s)\nsur les techniques améliorées\nde carbonisation",
                          style: TextStyle(
                              color: ArgonColors.text,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ),
                  ),
                  Switch.adaptive(
                    value: widget.charbonnierEnCours.formation,
                    onChanged: (bool newValue) =>
                        setState(() => widget.charbonnierEnCours.formation = newValue),
                    activeColor: ArgonColors.primary,
                  ),
                ],
              ),
              Visibility(
                  visible: widget.charbonnierEnCours.formation,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Formateur",
                          style: TextStyle(
                              color: ArgonColors.text,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ),
                  ),
              ),
              Visibility(
                  visible: widget.charbonnierEnCours.formation,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Input(
                          enable: true,
                          placeholder: "Entrer l'institution organisatrice",
                          borderColor: Color.fromRGBO(223, 225, 229, 1),
                          controller: formateur
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
