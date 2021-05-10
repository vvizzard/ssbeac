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

List<String> listeGenre = [
  'Homme', 'Femme','Autre'
];

List<String> listeCodePareFeux = [
  'Nettoyé', 'Vert','Autre'
];

List<String> listeCulture = [
  'Monoculture', 'Multiculture'
];

List<String> listeEssence = [
  'Eucalyptus robusta',
  'Eucalyptus robusta + acacia spp',
  'Eucalyptus camaldulensis + acacia spp',
  'Eucalyptus camaldulensis + casuarina spp',
  'Eucalyptus robusta + acacia spp + casuarina spp',
  'Eucalyptus camaldulensis  + acacia spp + casuarina spp',
  'Acacia leptocarpa + Eucalyptus spp',
  'Acacia mangium + Eucalyptus spp',
  'Eucalyptus camaldulensis',
  'Eucalyptus grandis ',
  'Acacia leptocarpa',
  'Acacia mangium',
  'Acacia auriculiformis',
  'Acacia dealbata',
  'Acacia crassicarpa',
  'Acacia holocericea ',
  'Casuarina cunninghamiana',
  'Eucalyptus spp',
  'Acacia senegaliensis',
  'Acacia spp',
  'Grevilea grandis',
  'Grevilea banksii',
];

List<String> listeProvenanceSemmenceCulture = [
  'Etranger', 'Local', 'National',
];

List<String> listeProductivite = [
  'Productivite elevee', 'Productivite haute', 'Productivite moyenne', 'Productivite faible', 'Productivite tres faible',
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

  DatabaseHelper helper = DatabaseHelper.instance;

  
  _save(ReboisementEntity reboisementEnCours) async {
    dateFormat.format(date).compareTo(reboisementEnCours.date)!=0?reboisementEnCours.date = dateFormat.format(date):0;
    // reboisementEnCours.district = ;
    // reboisementEnCours.agglomeration = ;
    reboisementEnCours.commune = commune.text;
    reboisementEnCours.agg = agg.text;
    reboisementEnCours.proprietaire = proprietaire.text;
    // reboisementEnCours.genreChoosed = ;
    reboisementEnCours.superficie = double.tryParse(superficie.text);
    // reboisementEnCours.pareFeux = ;
    // reboisementEnCours.pareFeuxChoosed = ;
    // reboisementEnCours.cultureChoosed = ;
    // reboisementEnCours.essenceChoosed = ;
    // reboisementEnCours.provenanceSemenceChoosed = ;
    // reboisementEnCours.productiviteChoosed = ;
    // reboisementEnCours.travauxSolChoosed = ;
    reboisementEnCours.anneePlantation = int.tryParse(anneePlantation.text);
    reboisementEnCours.densite = double.tryParse(densite.text);
    reboisementEnCours.tauxRemplissage = double.tryParse(tauxRemplissage.text);

    if(!reboisementEnCours.pareFeux) {
      reboisementEnCours.pareFeuxChoosed=null;
    }

    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.update(reboisementEnCours);
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
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: DropdownButton<String>(
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
              padding: const EdgeInsets.only(left: 8.0, top: 4.0),
              child: DropdownButton<String>(
                style: TextStyle(
                  fontSize: 12,
                  color: ArgonColors.text,
                  backgroundColor: Colors.white
                ),
                value: widget.reboisementEnCours.essenceChoosed,
                isExpanded: true,
                onChanged: (String newValue) {
                  setState(() {
                    widget.reboisementEnCours.essenceChoosed = newValue;
                  });
                },
                items: listeEssence
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