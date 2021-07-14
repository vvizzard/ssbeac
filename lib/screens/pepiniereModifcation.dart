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

List<String> listeGenre = [
  'Homme', 'Femme','Autre'
];

List<String> listeTypePepiniere = [
  'Projet' ,'Hors projet' 
];

class PepiniereModification extends StatefulWidget {
  final PepiniereEntity pepiniereEnCours;
  
  const PepiniereModification(
    {Key key, this.pepiniereEnCours}
  ):super(key: key); 

  @override
  _PepiniereModificationState createState() => _PepiniereModificationState();
}

class _PepiniereModificationState extends State<PepiniereModification> {
  final _formKey = GlobalKey<FormState>();  

  final dateFormat = DateFormat('dd-MM-yyyy');

  String dateLabel = "Choisir la date";
  DateTime date = new DateTime.now(); 
  
  var commune = TextEditingController();
  var agg = TextEditingController();
  var proprietaire = TextEditingController();
  var projetAppuie = TextEditingController();
  var lat = TextEditingController();
  var long = TextEditingController();
  var especes = TextEditingController();
  var nbrPlant = TextEditingController();
  var taux = TextEditingController();
  var platebande = TextEditingController();
  var surface = TextEditingController();

  DatabaseHelper helper = DatabaseHelper.instance;

  
  _save(PepiniereEntity pepiniereEnCours) async {
    dateFormat.format(date).compareTo(pepiniereEnCours.date)!=0?pepiniereEnCours.date = dateFormat.format(date):0;
    pepiniereEnCours.commune = commune.text;
    pepiniereEnCours.agg = agg.text;
    pepiniereEnCours.proprietaire = proprietaire.text;
    pepiniereEnCours.lat = lat.text;
    pepiniereEnCours.long = long.text;
    pepiniereEnCours.projetAppuie = projetAppuie.text;
    pepiniereEnCours.especes = especes.text;
    pepiniereEnCours.nbrPlant = int.tryParse(nbrPlant.text);
    pepiniereEnCours.taux = double.tryParse(taux.text);
    pepiniereEnCours.platebande = int.tryParse(taux.text);
    pepiniereEnCours.surface = double.tryParse(taux.text);

    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.update(pepiniereEnCours);
    print(id);
  }


  Future<void> _selectDate(BuildContext context, PepiniereEntity b) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2018, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != date)
      setState(() {
        date = picked;
        dateLabel = DateFormat('dd-MM-yyyy').format(picked);
        b.date = dateLabel;
      });
  }

  @override
  Widget build(BuildContext context) {
    dateLabel = widget.pepiniereEnCours.date;
    commune.text = widget.pepiniereEnCours.commune;
    agg.text = widget.pepiniereEnCours.agg;
    proprietaire.text = widget.pepiniereEnCours.proprietaire;
    lat.text = widget.pepiniereEnCours.lat;
    long.text = widget.pepiniereEnCours.long;
    projetAppuie.text = widget.pepiniereEnCours.projetAppuie;
    especes.text = widget.pepiniereEnCours.especes;
    nbrPlant.text = widget.pepiniereEnCours.nbrPlant.toString();
    taux.text = widget.pepiniereEnCours.taux.toString();
    platebande.text = widget.pepiniereEnCours.platebande.toString();
    surface.text = widget.pepiniereEnCours.surface.toString();
    
    return Scaffold(
      appBar: Navbar(
        title: "Pepiniere",
        rightOptions: false,
      ),
      backgroundColor: ArgonColors.white,
      drawer: ArgonDrawer(currentPage: "Pepiniere"),
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
                      onTap: ()=>_selectDate(context, widget.pepiniereEnCours),
                      child: Input(
                        enable: false,
                        placeholder: widget.pepiniereEnCours.date,
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
                          value: widget.pepiniereEnCours.district,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              widget.pepiniereEnCours.district = newValue;
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
                          value: widget.pepiniereEnCours.agglomeration,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              widget.pepiniereEnCours.agglomeration = newValue;
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
                  placeholder: "Entrer la longitude en degré décimal",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: long,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
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
                  placeholder: "Entrer la latitude en degré décimal",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: lat,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
                )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Type de pépiniériste",
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
                          hint: Text("Choisir le type de pépiniériste",
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
                          value: widget.pepiniereEnCours.type,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              widget.pepiniereEnCours.type = newValue;
                            });
                          },
                          items: listeTypePepiniere
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
                child: Text("Projet d'appuie",
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
                  placeholder: "Entrer le nom du projet",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: projetAppuie,
                )
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Propriétaire",
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
                  placeholder: "Entrer le Nom et prénom si personne physique/Dénomination si personne morale",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: proprietaire,
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Genre",
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
                          hint: Text("Choisir le genre",
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
                          value: widget.pepiniereEnCours.genreChoosed,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              widget.pepiniereEnCours.genreChoosed = newValue;
                            });
                          },
                          items: listeGenre
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
                  child: Text("Essence",
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
                  placeholder: "Entrer les essences recensées",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: especes,
              )
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Nombre de plan produit",
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
                  placeholder: "Entrer le nombre de plan total",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: nbrPlant,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Taux de réuissite",
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
                  placeholder: "Entrer le taux de réuissite de la pépinière",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: taux,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
                )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Nombre de platebande",
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
                  placeholder: "Entrer le nombre de platebande",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: platebande,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
                )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Surface",
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
                  placeholder: "Entrer la surface de la pépinière (ha)",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: surface,
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
                  color: ArgonColors.success,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/listepepiniere');
                    _save(widget.pepiniereEnCours);
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
