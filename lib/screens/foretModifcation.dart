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

class ForetModification extends StatefulWidget {
  final ForetNaturelEntity foretNaturelleEnCours;
  
  const ForetModification(
    {Key key, this.foretNaturelleEnCours}
  ):super(key: key); 

  @override
  _ForetModificationState createState() => _ForetModificationState();
}

class _ForetModificationState extends State<ForetModification> {
  final _formKey = GlobalKey<FormState>();  

  final dateFormat = DateFormat('dd-MM-yyyy');

  String dateLabel = "Choisir la date";

  DateTime date = new DateTime.now();
  var commune = TextEditingController();
  var agg = TextEditingController();
  var superficie = TextEditingController();
  var essenceChoosed = TextEditingController();
  var acteur = TextEditingController();
  var typeFormation = TextEditingController();
  var surfaceBrule = TextEditingController();
  var controle = TextEditingController();

  DatabaseHelper helper = DatabaseHelper.instance;

  
  _save(ForetNaturelEntity foretNaturelleEnCours) async {
    dateFormat.format(date).compareTo(foretNaturelleEnCours.date)!=0?foretNaturelleEnCours.date = dateFormat.format(date):0;
    foretNaturelleEnCours.commune = commune.text;
    foretNaturelleEnCours.agg = agg.text;
    foretNaturelleEnCours.superficie = double.tryParse(superficie.text);
    foretNaturelleEnCours.essence = essenceChoosed.text;
    foretNaturelleEnCours.acteur = acteur.text;
    foretNaturelleEnCours.typeFormation = typeFormation.text;
    foretNaturelleEnCours.surfaceDetruite = double.tryParse(surfaceBrule.text);
    foretNaturelleEnCours.controle = double.tryParse(controle.text);

    if(!foretNaturelleEnCours.pareFeux) {
      foretNaturelleEnCours.pareFeux=null;
    }
    if(!foretNaturelleEnCours.amenagement) {
      foretNaturelleEnCours.amenagement=null;
    }
    if(!foretNaturelleEnCours.authorisation) {
      foretNaturelleEnCours.authorisation=null;
    }

    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.update(foretNaturelleEnCours);
    print(id);
  }


  Future<void> _selectDate(BuildContext context, ForetNaturelEntity b) async {
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
    dateLabel = widget.foretNaturelleEnCours.date;
    commune.text = widget.foretNaturelleEnCours.commune;
    agg.text = widget.foretNaturelleEnCours.agg;
    superficie.text = widget.foretNaturelleEnCours.superficie.toString();
    essenceChoosed.text = widget.foretNaturelleEnCours.essence;
    acteur.text = widget.foretNaturelleEnCours.acteur;
    typeFormation.text = widget.foretNaturelleEnCours.typeFormation;
    surfaceBrule.text = widget.foretNaturelleEnCours.surfaceDetruite.toString();
    controle.text = widget.foretNaturelleEnCours.controle.toString();

    
    return Scaffold(
      appBar: Navbar(
        title: "Forêt Naturelle",
        rightOptions: false,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "ForetNaturel"),
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
                      onTap: ()=>_selectDate(context, widget.foretNaturelleEnCours),
                      child: Input(
                        enable: false,
                        placeholder: widget.foretNaturelleEnCours.date,
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
                value: widget.foretNaturelleEnCours.district,
                isExpanded: true,
                onChanged: (String newValue) {
                  setState(() {
                    widget.foretNaturelleEnCours.district = newValue;
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
                value: widget.foretNaturelleEnCours.agglomeration,
                isExpanded: true,
                onChanged: (String newValue) {
                  setState(() {
                    widget.foretNaturelleEnCours.agglomeration = newValue;
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
                child: Text("Localité",
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
                  placeholder: "Entrer le nom de la localité",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: agg,
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
                    child: Text("Existence de plan d'aménagement",
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                ),
                Switch.adaptive(
                  value: widget.foretNaturelleEnCours.amenagement,
                  onChanged: (bool newValue) =>
                      setState(() => widget.foretNaturelleEnCours.amenagement = newValue),
                  activeColor: ArgonColors.primary,
                ),
              ],
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
                  placeholder: "(ex: Institution, TG, ...)",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: acteur,
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
                    child: Text("Existence d'authorisation",
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                ),
                Switch.adaptive(
                  value: widget.foretNaturelleEnCours.authorisation,
                  onChanged: (bool newValue) =>
                      setState(() => widget.foretNaturelleEnCours.authorisation = newValue),
                  activeColor: ArgonColors.primary,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Type de formation",
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
                  placeholder: "(ex: Mangroves, Fourrés, Forêts ripicoles, ...)",
                  borderColor: Color.fromRGBO(223, 225, 229, 1),
                  controller: typeFormation,
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
                    child: Text("Existence de système de protection",
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                ),
                Switch.adaptive(
                  value: widget.foretNaturelleEnCours.pareFeux,
                  onChanged: (bool newValue) =>
                      setState(() => widget.foretNaturelleEnCours.pareFeux = newValue),
                  activeColor: ArgonColors.primary,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Surface de forêts détruites",
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
                    placeholder: "Entrer la superficie (ha)",
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: surfaceBrule,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
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
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Nombre de contrôle et suivi effectué par l'administration forestière par an",
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
                    placeholder: "Entrer le nombre de controle (hj)",
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: controle,
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
                    Navigator.pushReplacementNamed(context, '/listeforetnaturel');
                    _save(widget.foretNaturelleEnCours);
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
