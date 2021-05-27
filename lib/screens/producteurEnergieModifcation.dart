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
  'Biogaz', 'Gaz', 'Bioéthanol', 'Briquette/Charbon Vert'
];

class ProducteurEnergieModification extends StatefulWidget {
  final ProducteurEEntity productionEnergieEnCours;
  
  const ProducteurEnergieModification(
    {Key key, this.productionEnergieEnCours}
  ):super(key: key); 

  @override
  _ProducteurEnergieModificationState createState() => _ProducteurEnergieModificationState();
}

class _ProducteurEnergieModificationState extends State<ProducteurEnergieModification> {
  final _formKey = GlobalKey<FormState>();  

  final dateFormat = DateFormat('dd-MM-yyyy');

  // bool showQteTotal = false;
  String unite = '(kg)';
  String dateLabel = "Choisir la date";
  DateTime date = new DateTime.now();
  String productionLabel = "Quantité de production";
  bool showBiodigesteur = false;
  
  var commune = TextEditingController();
  var agg = TextEditingController();
  var qte = TextEditingController();
  var biodigesteur = TextEditingController();
  // var qteTotal = TextEditingController();

  DatabaseHelper helper = DatabaseHelper.instance;

  
  _save(ProducteurEEntity productionEnergieEnCours) async {
    dateFormat.format(date).compareTo(productionEnergieEnCours.date)!=0?productionEnergieEnCours.date = dateFormat.format(date):0;
    productionEnergieEnCours.commune = commune.text;
    productionEnergieEnCours.agg = agg.text;
    productionEnergieEnCours.qte = double.tryParse(qte.text);
    productionEnergieEnCours.biodigesteur = double.tryParse(biodigesteur.text);

    // productionEnergieEnCours.qteTotal = double.tryParse(qteTotal.text);

    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.update(productionEnergieEnCours);
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
    dateLabel = widget.productionEnergieEnCours.date;
    commune.text = widget.productionEnergieEnCours.commune;
    agg.text = widget.productionEnergieEnCours.agg;
    qte.text = widget.productionEnergieEnCours.qte.toString();
    if(widget.productionEnergieEnCours.biodigesteur!=null
        && widget.productionEnergieEnCours.biodigesteur>0) {
      showBiodigesteur = true;
    }
    // qteTotal.text = widget.productionEnergieEnCours.qteTotal.toString();
    /*if(widget.productionEnergieEnCours.qteTotal!=null
        && widget.productionEnergieEnCours.qteTotal>0) {
      showQteTotal = true;
    }*/
    
    return Scaffold(
      appBar: Navbar(
        title: "Producteur Energie",
        rightOptions: false,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "ProducteurEnergie"),
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
                value: widget.productionEnergieEnCours.district,
                isExpanded: true,
                onChanged: (String newValue) {
                  setState(() {
                    widget.productionEnergieEnCours.district = newValue;
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
                value: widget.productionEnergieEnCours.agglomeration,
                isExpanded: true,
                onChanged: (String newValue) {
                  setState(() {
                    widget.productionEnergieEnCours.agglomeration = newValue;
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
                child: Text("Energie",
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
                value: widget.productionEnergieEnCours.energie,
                isExpanded: true,
                onChanged: (String nValue) {
                  setState(() {
                    widget.productionEnergieEnCours.energie = nValue;
                    /*if(widget.productionEnergieEnCours.energie.compareTo('Pétrole')==0
                        || widget.productionEnergieEnCours.energie.compareTo('Electricité') == 0) {
                      // showQteTotal = true;
                      productionLabel = "Quantité produit pour la cuisson";
                    } else {
                      // showQteTotal = false;
                      productionLabel = "Quantité de production";
                    }*/
                    if(widget.productionEnergieEnCours.energie.contains('Biogaz')) {
                      showBiodigesteur = true;
                    } else showBiodigesteur = false;
                    if(widget.productionEnergieEnCours.energie.contains('Biogaz')){
                      unite = '(m³)';
                    } else if(widget.productionEnergieEnCours.energie.contains('Bioéthanol')) {
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

            /*Visibility(
                visible: showQteTotal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Quantité de production ",
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                )
            ),
            Visibility(
              visible: showQteTotal,
              child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Input(
                    enable: true,
                    placeholder: "Entrer la quantité de production",
                    borderColor: ArgonColors.white,
                    controller: qteTotal,
                  )
              ),
            ),*/

            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Quantité annuelle produite',
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
                  placeholder: "Entrer la quantité annuelle produite "+unite,
                  borderColor: ArgonColors.white,
                  controller: qte,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]
                )
            ),

            Visibility(
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
                    Navigator.pushReplacementNamed(context, '/listeProductionEnergie');
                    _save(widget.productionEnergieEnCours);
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
