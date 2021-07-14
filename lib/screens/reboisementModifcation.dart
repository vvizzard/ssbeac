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

List<String> listeCodePareFeux = [
  'Nettoyé', 'Vert','Autre'
];

List<String> listeCulture = [
  'Monoculture', 'Multiculture'
];

List<String> listeProvenanceSemmenceCulture = [
  'Exotique', 'Local', 'National',
];

List<String> listeProductivite = [
  'Très faible (AAM de 3 à 4 m3/ha)', 'Faible (AAM de 4 à 6 m3/ha)',
  'Moyenne (AAM de 6,5 à 7,5 m3/ha)', 'Haute (AAM de 7,5 à 10 m3/ha)',
  'Elevée (AAM de 10 à 12 m3/ha)'
];

List<String> listeTravauxSol = [
  'Labour', 'Mixte', 'Trouaisson',
];

class ReboisementModification extends StatefulWidget {
  final ReboisementEntity reboisementEnCours;
  
  const ReboisementModification(
    {Key key, this.reboisementEnCours}
  ):super(key: key); 

  @override
  _ReboisementModificationState createState() => _ReboisementModificationState();
}

class _ReboisementModificationState extends State<ReboisementModification> {
  final _formKey = GlobalKey<FormState>();  

  final dateFormat = DateFormat('dd-MM-yyyy');

  String dateLabel = "Choisir la date";

  DateTime date = new DateTime.now();   
  var commune = TextEditingController();
  var agg = TextEditingController();
  var proprietaire = TextEditingController();
  var superficie = TextEditingController();
  var anneePlantation = TextEditingController();
  var densite = TextEditingController();
  var tauxRemplissage = TextEditingController();
  var essenceChoosed = TextEditingController();
  var acteur = TextEditingController();
  var type = TextEditingController();

  DatabaseHelper helper = DatabaseHelper.instance;

  
  _save(ReboisementEntity reboisementEnCours) async {
    dateFormat.format(date).compareTo(reboisementEnCours.date)!=0?reboisementEnCours.date = dateFormat.format(date):0;
    reboisementEnCours.commune = commune.text;
    reboisementEnCours.agg = agg.text;
    reboisementEnCours.proprietaire = proprietaire.text;
    reboisementEnCours.superficie = double.tryParse(superficie.text);
    reboisementEnCours.essenceChoosed = essenceChoosed.text;
    reboisementEnCours.acteur = acteur.text;
    reboisementEnCours.anneePlantation = int.tryParse(anneePlantation.text);
    reboisementEnCours.densite = double.tryParse(densite.text);
    reboisementEnCours.tauxRemplissage = double.tryParse(tauxRemplissage.text);
    reboisementEnCours.type = type.text;

    if(!reboisementEnCours.pareFeux) {
      reboisementEnCours.pareFeuxChoosed=null;
    }

    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.update(reboisementEnCours);
    print(id);
  }


  Future<void> _selectDate(BuildContext context, ReboisementEntity b) async {
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
    dateLabel = widget.reboisementEnCours.date;
    commune.text = widget.reboisementEnCours.commune;
    agg.text = widget.reboisementEnCours.agg;
    proprietaire.text = widget.reboisementEnCours.proprietaire;
    superficie.text = widget.reboisementEnCours.superficie.toString();
    anneePlantation.text = widget.reboisementEnCours.anneePlantation.toString();
    densite.text = widget.reboisementEnCours.densite.toString();
    tauxRemplissage.text = widget.reboisementEnCours.tauxRemplissage.toString();
    essenceChoosed.text = widget.reboisementEnCours.essenceChoosed;
    acteur.text = widget.reboisementEnCours.acteur;
    type.text = widget.reboisementEnCours.type;
    
    return Scaffold(
      appBar: Navbar(
        title: "Reboisement",
        rightOptions: false,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "Reboisement"),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
        child: SafeArea(
          bottom: true,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 24),
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
                      onTap: ()=>_selectDate(context, widget.reboisementEnCours),
                      child: Input(
                        enable: false,
                        placeholder: widget.reboisementEnCours.date,
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
              padding: const EdgeInsets.only(left: 8.0, top: 4.0),
              child: DropdownButton<String>(
                style: TextStyle(
                  fontSize: 12,
                  color: ArgonColors.text,
                  backgroundColor: Colors.white
                ),
                value: widget.reboisementEnCours.district,
                isExpanded: true,
                onChanged: (String newValue) {
                  setState(() {
                    widget.reboisementEnCours.district = newValue;
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
                value: widget.reboisementEnCours.agglomeration,
                isExpanded: true,
                onChanged: (String newValue) {
                  setState(() {
                    widget.reboisementEnCours.agglomeration = newValue;
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
                          value: widget.reboisementEnCours.genreChoosed,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              widget.reboisementEnCours.genreChoosed = newValue;
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
                child: Text("Superficie",
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
                  placeholder: "Entrer la superficie",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: superficie,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
                )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Type de reboisement",
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
                  placeholder: "(ex: Agroforesterie, Arbres hors forêts, Plantation à vocation énergétique, …)",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: type,
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
                    child: Text("Existence de pare-feux",
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                ),
                Switch.adaptive(
                  value: widget.reboisementEnCours.pareFeux,
                  onChanged: (bool newValue) =>
                      setState(() => widget.reboisementEnCours.pareFeux = newValue),
                  activeColor: ArgonColors.primary,
                ),
              ],
            ),

            Visibility(
              visible: widget.reboisementEnCours.pareFeux,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Pare-feux",
                      style: TextStyle(
                          color: ArgonColors.text,
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
            ),
            Visibility(
              visible: widget.reboisementEnCours.pareFeux,
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
                          hint: Text("Choisir le pare-feux",
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
                          value: widget.reboisementEnCours.pareFeuxChoosed,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              widget.reboisementEnCours.pareFeuxChoosed = newValue;
                            });
                          },
                          items: listeCodePareFeux
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )
                  )
              )
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Type de culture",
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
                          hint: Text("Choisir le type de culture",
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
                          value: widget.reboisementEnCours.cultureChoosed,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              widget.reboisementEnCours.cultureChoosed = newValue;
                            });
                          },
                          items: listeCulture
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
                child: Text("Essences",
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
                  controller: essenceChoosed,
              )
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Provenance des semences",
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
                          hint: Text("Choisir la provenance des semences",
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
                          value: widget.reboisementEnCours.provenanceSemenceChoosed,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              widget.reboisementEnCours.provenanceSemenceChoosed = newValue;
                            });
                          },
                          items: listeProvenanceSemmenceCulture
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
                child: Text("Productivités",
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
                          hint: Text("Choisir la productivités",
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
                          value: widget.reboisementEnCours.productiviteChoosed,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              widget.reboisementEnCours.productiviteChoosed = newValue;
                            });
                          },
                          items: listeProductivite
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
                child: Text("Travail du sol",
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
                          hint: Text("Choisir le travail du sol",
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
                          value: widget.reboisementEnCours.travauxSolChoosed,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              widget.reboisementEnCours.travauxSolChoosed = newValue;
                            });
                          },
                          items: listeTravauxSol
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
                child: Text("Année de plantation",
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
                  placeholder: "Entrer l'année de plantation",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: anneePlantation,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
              )
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Densité",
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
                  placeholder: "Entrer la densité (nbr pieds/ha)",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: densite,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
              )
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Taux de remplissage",
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
                  placeholder: "Entrer le taux de remplissage (%)",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: tauxRemplissage,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
              )
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Fertilisant",
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                ),
                Switch.adaptive(
                  value: widget.reboisementEnCours.fertilisant,
                  onChanged: (bool newValue) =>
                      setState(() => widget.reboisementEnCours.fertilisant = newValue),
                  activeColor: ArgonColors.primary,
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Acteurs/Opérateurs",
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
                  placeholder: "(ex: Institution, Individuel, Communautraie, ...)",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: acteur,
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
                    Navigator.pushReplacementNamed(context, '/listereboisement');
                    _save(widget.reboisementEnCours);
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
