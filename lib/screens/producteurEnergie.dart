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

class ProducteurEnergie extends StatefulWidget {
  @override
  _ProducteurEnergieState createState() => _ProducteurEnergieState();
}

class _ProducteurEnergieState extends State<ProducteurEnergie> {
  final _formKey = GlobalKey<FormState>();

  // bool showQteTotal = false;

  String dateLabel = "Choisir la date";
  String productionLabel = "Quantité de production";
  String unite = '(kg)';
  bool showBiodigesteur = false;
  
  DateTime date = new DateTime.now(); 
  String districtChoosed;
  String agglomerationChoosed;
  String energieChoosed;
  var commune = TextEditingController();
  var agg = TextEditingController();
  var qte = TextEditingController();
  var biodigesteur = TextEditingController();

  DatabaseHelper helper = DatabaseHelper.instance;
  ProducteurEEntity ds = new ProducteurEEntity();

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
    ds.energie = energieChoosed;
    ds.qte = double.tryParse(qte.text);
    ds.biodigesteur = double.tryParse(biodigesteur.text);
    // ds.qteTotal = double.tryParse(qteTotal.text);

    helper.insert(ds).then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    helper.checkLogin().then((value) => !value?Navigator.pushNamed(context, '/onboarding'):0);
    return Scaffold(
        appBar: Navbar(
          title: "Producteur foyer",
          rightOptions: false,
        ),
        backgroundColor: ArgonColors.white,
        drawer: ArgonDrawer(currentPage: "ProducteurEnergie"),
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
                        onTap: ()=>_selectDate(context),
                        child: Input(
                          enable: false,
                          placeholder: dateLabel,
                          onTap: ()=>_selectDate(context),
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
                  child: Text("Type d'énergie",
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
                          value: energieChoosed,
                          isExpanded: true,
                          onChanged: (String nValue) {
                            setState(() {
                              energieChoosed = nValue;
                              /*if(energieChoosed.compareTo('Pétrole')==0
                          || energieChoosed.compareTo('Electricité') == 0) {
                        // showQteTotal = true;
                        productionLabel = "Quantité produit pour la cuisson";
                      } else {
                        // showQteTotal = false;
                        productionLabel = "Quantité de production";
                      }*/
                              if(energieChoosed.contains('Biogaz')) {
                                showBiodigesteur = true;
                              } else showBiodigesteur = false;
                              if(energieChoosed.contains('Biogaz')){
                                unite = '(m³)';
                              } else if(energieChoosed.contains('Bioéthanol')) {
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

              // Visibility(
              //     visible: showQteTotal,
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 8.0, top: 8),
              //       child: Align(
              //         alignment: Alignment.centerLeft,
              //         child: Text("Quantité de production ",
              //             style: TextStyle(
              //                 color: ArgonColors.text,
              //                 fontWeight: FontWeight.w500,
              //                 fontSize: 12)),
              //       ),
              //     )
              // ),
              // Visibility(
              //   visible: showQteTotal,
              //   child: Padding(
              //       padding: const EdgeInsets.only(top: 4.0),
              //       child: Input(
              //         enable: true,
              //         placeholder: "Entrer la quantité de production",
              //         borderColor: Color.fromRGBO(223, 225, 229, 1),
              //         controller: qteTotal,
              //       )
              //   ),
              // ),

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
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
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
                        borderColor: Color.fromRGBO(223, 225, 229, 1),
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
