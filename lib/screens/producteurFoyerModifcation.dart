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

List<String> listeEnergieCuisson = [
  'Bois de Chauffe', 'Charbon de Bois', 'Biogaz', 'Gaz', 'Bioéthanol',
  'Résidus agricoles/Sous-produits', 'Electricité', 'Briquette/Charbon Vert',
  'Pétrole'
];

List<String> listeType = [
  'Traditionnelle', 'Améliorée'
];

class ProducteurFoyerModification extends StatefulWidget {
  final ProducteurFEntity productionFoyerEnCours;
  
  const ProducteurFoyerModification(
    {Key key, this.productionFoyerEnCours}
  ):super(key: key); 

  @override
  _ProducteurFoyerModificationState createState() => _ProducteurFoyerModificationState();
}

class _ProducteurFoyerModificationState extends State<ProducteurFoyerModification> {
  final _formKey = GlobalKey<FormState>();  

  final dateFormat = DateFormat('dd-MM-yyyy');

  // bool showBiodigesteur = false;
  String unite = '(kg)';

  String dateLabel = "Choisir la date";
  DateTime date = new DateTime.now(); 
  
  var commune = TextEditingController();
  var agg = TextEditingController();
  var qte = TextEditingController();
  var biodigesteur = TextEditingController();
  // var appuie = TextEditingController();

  DatabaseHelper helper = DatabaseHelper.instance;

  
  _save(ProducteurFEntity productionFoyerEnCours) async {
    dateFormat.format(date).compareTo(productionFoyerEnCours.date)!=0?productionFoyerEnCours.date = dateFormat.format(date):0;
    productionFoyerEnCours.commune = commune.text;
    productionFoyerEnCours.agg = agg.text;
    productionFoyerEnCours.qte = double.tryParse(qte.text);
    productionFoyerEnCours.biodigesteur = double.tryParse(biodigesteur.text);
    // productionFoyerEnCours.appuie = int.tryParse(appuie.text);

    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.update(productionFoyerEnCours);
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
    dateLabel = widget.productionFoyerEnCours.date;
    commune.text = widget.productionFoyerEnCours.commune;
    agg.text = widget.productionFoyerEnCours.agg;
    qte.text = widget.productionFoyerEnCours.qte.toString();
    biodigesteur.text = widget.productionFoyerEnCours.biodigesteur.toString();
    // appuie.text = widget.productionFoyerEnCours.appuie.toString();
    // if(widget.productionFoyerEnCours.biodigesteur!=null
    //     && widget.productionFoyerEnCours.biodigesteur>0) {
    //   showBiodigesteur = true;
    // }
    
    return Scaffold(
      appBar: Navbar(
        title: "Producteur Foyer",
        rightOptions: false,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "ProducteurFoyer"),
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
                value: widget.productionFoyerEnCours.district,
                isExpanded: true,
                onChanged: (String newValue) {
                  setState(() {
                    widget.productionFoyerEnCours.district = newValue;
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
                value: widget.productionFoyerEnCours.agglomeration,
                isExpanded: true,
                onChanged: (String newValue) {
                  setState(() {
                    widget.productionFoyerEnCours.agglomeration = newValue;
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
              padding: const EdgeInsets.only(left: 8.0, top: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Type d'énergie de cuisson",
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
                value: widget.productionFoyerEnCours.energie,
                isExpanded: true,
                onChanged: (String nValue) {
                  setState(() {
                    widget.productionFoyerEnCours.energie = nValue;
                    if(widget.productionFoyerEnCours.energie.compareTo('Biogaz')==0) {
                      // showBiodigesteur = true;
                      unite = '(m³)';
                    } //else showBiodigesteur = false;
                    if(widget.productionFoyerEnCours.energie.contains('Electricite')) {
                      unite = '(kWh)';
                    } else if(widget.productionFoyerEnCours.energie.contains('Bioéthanol')
                        ||widget.productionFoyerEnCours.energie.contains('Pétrol')) {
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
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 32),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Type de foyers produits",
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
                value: widget.productionFoyerEnCours.type,
                isExpanded: true,
                onChanged: (String newValue) {
                  setState(() {
                    widget.productionFoyerEnCours.type = newValue;
                  });
                },
                items: listeType
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
                child: Text("Production annuel totale",
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
                  placeholder: "Entrer la production annuel totale "+unite,
                  borderColor: ArgonColors.white,
                  controller: qte,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]
                )
            ),

            /*Visibility(
                visible: showBiodigesteur,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Capacité biodigesteur ",
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                )
            ),
            Visibility(
              visible: showBiodigesteur,
              child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Input(
                    enable: true,
                    placeholder: "Entrer la capacité du biodigesteur (m³)",
                    borderColor: ArgonColors.white,
                    controller: biodigesteur,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly]
                  )
              ),
            ),*/

            SizedBox(height: 8.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Existence d'appuie à la production",
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                ),
                Switch.adaptive(
                  value: widget.productionFoyerEnCours.appuie,
                  onChanged: (bool newValue) =>
                      setState(() => widget.productionFoyerEnCours.appuie = newValue),
                  activeColor: ArgonColors.primary,
                ),
              ],
            ),

            // Padding(
            //   padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Text("Nombre d'appuie à la production",
            //         style: TextStyle(
            //             color: ArgonColors.text,
            //             fontWeight: FontWeight.w500,
            //             fontSize: 12)),
            //   ),
            // ),
            // Padding(
            //     padding: const EdgeInsets.only(top: 4.0),
            //     child: Input(
            //       enable: true,
            //       placeholder: "Existence d'appuie à la production",
            //       borderColor: ArgonColors.white,
            //       controller: appuie,
            //     )
            // ),

          SizedBox(
            width: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8),
              child: RaisedButton(
                textColor: ArgonColors.text,
                color: ArgonColors.success,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/listeProductionFoyer');
                  _save(widget.productionFoyerEnCours);
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
