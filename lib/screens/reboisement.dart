import 'package:argon_flutter/helper/database_helpers.dart';
import 'package:flutter/material.dart';

import 'package:argon_flutter/constants/Theme.dart';

//widgets
import 'package:argon_flutter/widgets/navbar.dart';
import 'package:argon_flutter/widgets/drawer.dart';
import 'package:argon_flutter/widgets/input.dart';
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
  'Etranger', 'Local', 'National',
];

List<String> listeProductivite = [
  'Productivite elevee', 'Productivite haute', 'Productivite moyenne',
  'Productivite faible', 'Productivite tres faible',
];

List<String> listeTravauxSol = [
  'Labour', 'Mixte', 'Trouaisson',
];


class Reboisement extends StatefulWidget {
  @override
  _ReboisementState createState() => _ReboisementState();
}

class _ReboisementState extends State<Reboisement> {
  final _formKey = GlobalKey<FormState>();  

  String dateLabel = "Choisir la date";
  
  DateTime date = new DateTime.now(); 
  String districtChoosed;
  String agglomerationChoosed;
  String genreChoosed;
  String pareFeuxChoosed;
  String cultureChoosed;
  String provenanceSemenceChoosed;
  String productiviteChoosed;
  String travauxSolChoosed;
  
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
  bool pareFeux = false;
  bool fertilisant = false;

  DatabaseHelper helper = DatabaseHelper.instance;
  ReboisementEntity ds = new ReboisementEntity();

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

  _save() {
    ds.id = null;
    ds.date = DateFormat('dd-MM-yyyy').format(date);
    ds.district = districtChoosed;
    ds.agglomeration = agglomerationChoosed;
    ds.commune = commune.text;
    ds.agg = agg.text;
    ds.proprietaire = proprietaire.text;
    ds.genreChoosed = genreChoosed;
    ds.superficie = double.tryParse(superficie.text);
    ds.pareFeux = pareFeux;
    ds.pareFeuxChoosed = pareFeuxChoosed;
    ds.cultureChoosed = cultureChoosed;
    ds.essenceChoosed = essenceChoosed.text;
    ds.provenanceSemenceChoosed = provenanceSemenceChoosed;
    ds.productiviteChoosed = productiviteChoosed;
    ds.travauxSolChoosed = travauxSolChoosed;
    ds.anneePlantation = int.tryParse(anneePlantation.text);
    ds.densite = double.tryParse(densite.text);
    ds.tauxRemplissage = double.tryParse(tauxRemplissage.text);
    ds.fertilisant = fertilisant;
    ds.acteur = acteur.text;
    ds.type = type.text;

    if(!ds.pareFeux) {
      ds.pareFeuxChoosed=null;
    }

    helper.insert(ds).then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    helper.checkLogin().then((value) => !value?Navigator.pushNamed(context, '/onboarding'):0);
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
                    placeholder: "Entrer le nom du propriétaire",
                    borderColor: ArgonColors.white,
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
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: DropdownButton<String>(
                  style: TextStyle(
                    fontSize: 12,
                    color: ArgonColors.text,
                    backgroundColor: Colors.white
                  ),
                  value: genreChoosed,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      genreChoosed = newValue;
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
                    placeholder: "Entrer le type de reboisement",
                    borderColor: ArgonColors.white,
                    controller: type,
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
                    borderColor: ArgonColors.white,
                    controller: superficie,
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
                      child: Text("Pare-feux",
                          style: TextStyle(
                              color: ArgonColors.text,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ),
                  ),
                  Switch.adaptive(
                    value: pareFeux,
                    onChanged: (bool newValue) =>
                        setState(() => pareFeux = newValue),
                    activeColor: ArgonColors.primary,
                  ),
                ],
              ),

              Visibility(
                visible: pareFeux,
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
                visible: pareFeux,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: DropdownButton<String>(
                    style: TextStyle(
                      fontSize: 12,
                      color: ArgonColors.text,
                      backgroundColor: Colors.white
                    ),
                    value: pareFeuxChoosed,
                    isExpanded: true,
                    onChanged: (String newValue) {
                      setState(() {
                        pareFeuxChoosed = newValue;
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
                ),
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
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: DropdownButton<String>(
                  style: TextStyle(
                    fontSize: 12,
                    color: ArgonColors.text,
                    backgroundColor: Colors.white
                  ),
                  value: cultureChoosed,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      cultureChoosed = newValue;
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
                    placeholder: "Entrer les essences utilisés",
                    borderColor: ArgonColors.white,
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
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: DropdownButton<String>(
                  style: TextStyle(
                    fontSize: 12,
                    color: ArgonColors.text,
                    backgroundColor: Colors.white
                  ),
                  value: provenanceSemenceChoosed,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      provenanceSemenceChoosed = newValue;
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
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: DropdownButton<String>(
                  style: TextStyle(
                    fontSize: 12,
                    color: ArgonColors.text,
                    backgroundColor: Colors.white
                  ),
                  value: productiviteChoosed,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      productiviteChoosed = newValue;
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
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Travaux sol",
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
                  value: travauxSolChoosed,
                  isExpanded: true,
                  onChanged: (String newValue) {
                    setState(() {
                      travauxSolChoosed = newValue;
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
                    borderColor: ArgonColors.white,
                    controller: anneePlantation,
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
                    placeholder: "Entrer la densité (nbr/ha)",
                    borderColor: ArgonColors.white,
                    controller: densite,
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
                    borderColor: ArgonColors.white,
                    controller: tauxRemplissage,
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
                    value: fertilisant,
                    onChanged: (bool newValue) =>
                        setState(() => fertilisant = newValue),
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
                    placeholder: "Entrer les acteurs ou opérateurs",
                    borderColor: ArgonColors.white,
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
                    _save();
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
