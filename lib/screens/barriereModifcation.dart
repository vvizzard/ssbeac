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
List<String> listTransport = [
  'Bicyclette', 'Charette', 'Taxi-brousse', 'Camion',
  'Dos d\'homme', 'Autre'
];
List<String> listeProduits = [
  'Arbres Hors Forêts', 'Mangrove', 'Forêt Naturelle', 'Plantation/Reboisement'
];
List<String> lisetAxe = ['Fluvial', 'Routier'];

class BarriereModification extends StatefulWidget {
  final BarriereEntity barriereEnCours;
  final List<ProduitEntity> produits;

  const BarriereModification(
    {Key key, this.barriereEnCours, this.produits}
  ):super(key: key); 

  @override
  _BarriereModificationState createState() => _BarriereModificationState();
}

class _BarriereModificationState extends State<BarriereModification> {
  final _formKey = GlobalKey<FormState>();  
  
  String dateLabel = "Choisir la date";

  DateTime date = new DateTime.now(); 
  String districtChoosed;
  String agglomerationChoosed;
  String transportChoosed;
  String deplacementChoosed;
  String produitChoosed;
  String districtProvenance;
  String districtDestination;
  String axeChoosed;

  // produits
  Map<String, Map<String, String>> produits = {};

  // text field controller
  var qteProduitTemp = TextEditingController();
  var qteCBTemp = TextEditingController();
  var axe = TextEditingController();
  var longitude = TextEditingController();
  var latitude = TextEditingController();
  var provenance = TextEditingController();
  var destination = TextEditingController();
  var commune = TextEditingController();
  var agg = TextEditingController();
  var typeRoute = TextEditingController();
  var numRoute = TextEditingController();

  bool ristourne = false;

  
  _save(BarriereEntity barriereEnCours) async {
    if(produits.length == 0) return null;

    String dateString = DateFormat('dd-MM-yyyy').format(date);
    dateString.compareTo(barriereEnCours.dateBarriere)!=0?barriereEnCours.dateBarriere=dateString:0;

    barriereEnCours.agg = agg.text;
    barriereEnCours.axe = axe.text;
    barriereEnCours.latitude = latitude.text;
    barriereEnCours.longitude = longitude.text;
    barriereEnCours.designationProvenance = provenance.text;
    barriereEnCours.designationArrivee = destination.text;
    barriereEnCours.typeRoute = typeRoute.text;
    barriereEnCours.numRoute = numRoute.text;


    List<ProduitEntity> listeProduits = [];

    produits.forEach((key, value) {
      ProduitEntity produit = ProduitEntity();
      produit.produit= value['produit'];
      produit.qte = double.tryParse(value['qte']);
      produit.cb = double.tryParse(value['cb']);
      listeProduits.add(produit);
    });

    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.updateBarriere(barriereEnCours, listeProduits);
    print(id);
    
  }


  Future<void> _selectDate(BuildContext context, BarriereEntity b) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2018, 1),
      lastDate: DateTime(2101));
      if (picked != null && picked != date)
        setState(() {
          date = picked;
          dateLabel = DateFormat('dd-MM-yyyy').format(picked);
          b.dateBarriere = dateLabel;
        });
  } 

  @override
  Widget build(BuildContext context) {
    dateLabel = widget.barriereEnCours.dateBarriere;
    commune.text = widget.barriereEnCours.commune;
    agg.text = widget.barriereEnCours.agg;
    axe.text = widget.barriereEnCours.axe;
    longitude.text = widget.barriereEnCours.longitude;
    latitude.text = widget.barriereEnCours.latitude;
    provenance.text = widget.barriereEnCours.designationProvenance;
    destination.text = widget.barriereEnCours.designationArrivee;
    typeRoute.text = widget.barriereEnCours.typeRoute;
    numRoute.text = widget.barriereEnCours.numRoute;

    if(widget.barriereEnCours.axe!='') axeChoosed = widget.barriereEnCours.axe;
    // print("Modification barrière");
    // print(widget.barriereEnCours.axe=='');
    if(widget.barriereEnCours.transport!='') transportChoosed = widget.barriereEnCours.transport;
    if(widget.barriereEnCours.districtProvenance!='') districtProvenance = widget.barriereEnCours.districtProvenance;
    if(widget.barriereEnCours.districtArrivee!='') districtDestination = widget.barriereEnCours.districtArrivee;

    for (var i = 0; i < widget.produits.length; i++) {
      produits.putIfAbsent(widget.produits[i].typeProduit, () => {
        // "type": widget.produits[i].typeProduit,
        "produit": widget.produits[i].produit,
        "qte": widget.produits[i].qte.toString(),
        "cb": widget.produits[i].cb.toString(),
        "index": i.toString()
      });
    }

    // print('produits');
    // print(widget.produits[0].typeProduit);
    
    return Scaffold(
        appBar: Navbar(
          title: "Barrière",
          rightOptions: false,
        ),
        backgroundColor: ArgonColors.white,
        drawer: ArgonDrawer(currentPage: "Menage"),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
          child: SafeArea(
            bottom: true,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16),
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
                        onTap: ()=>_selectDate(context, widget.barriereEnCours),
                        child: Input(
                          enable: false,
                          placeholder: widget.barriereEnCours.dateBarriere,
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
                          value: widget.barriereEnCours.districtBarriere,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              widget.barriereEnCours.districtBarriere = newValue;
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
                          value: widget.barriereEnCours.agglomerationBarriere,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              widget.barriereEnCours.agglomerationBarriere = newValue;
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
                      placeholder: "Entrer ici la longitude de la situation de la barrière",
                      borderColor: Color.fromRGBO(223, 225, 229, 1),
                      controller: longitude,
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
                      placeholder: "Entrer ici la latitude de la situation de la barrière",
                      borderColor: Color.fromRGBO(223, 225, 229, 1),
                      controller: latitude,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Axe",
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
                          hint: Text("Choisir l'axe de la barrière",
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
                          value: axeChoosed,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              axeChoosed = newValue;
                              widget.barriereEnCours.axe = axeChoosed;
                            });
                          },
                          items: lisetAxe
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
              Visibility(
                  visible: widget.barriereEnCours.axe == "Routier",
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Type de route",
                          style: TextStyle(
                              color: ArgonColors.text,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                    ),
                  )
              ),
              Visibility(
                visible: widget.barriereEnCours.axe == "Routier",
                child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Input(
                      enable: true,
                      placeholder: "Entrer ici le type de route",
                      borderColor: Color.fromRGBO(223, 225, 229, 1),
                      controller: typeRoute,
                    )
                ),
              ),
              Visibility(
                visible: widget.barriereEnCours.axe == "Routier",
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Numéro de la route",
                        style: TextStyle(
                            color: ArgonColors.text,
                            fontWeight: FontWeight.w500,
                            fontSize: 12)),
                  ),
                ),
              ),
              Visibility(
                visible: widget.barriereEnCours.axe == "Routier",
                child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Input(
                      enable: true,
                      placeholder: "Entrer ici le numéro de la route",
                      borderColor: Color.fromRGBO(223, 225, 229, 1),
                      controller: numRoute,
                    )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Laisser-passer",
                      style: TextStyle(color: ArgonColors.text, fontSize: 12)),
                  Switch.adaptive(
                    value: widget.barriereEnCours.laisserPasser,
                    onChanged: (bool newValue) =>
                        setState(() => widget.barriereEnCours.laisserPasser = newValue),
                    activeColor: ArgonColors.primary,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Quittance de paiement de ristourne",
                      style: TextStyle(color: ArgonColors.text, fontSize: 12)),
                  Switch.adaptive(
                    value: widget.barriereEnCours.ristourne,
                    onChanged: (bool newValue) =>
                        setState(() => widget.barriereEnCours.ristourne = newValue),
                    activeColor: ArgonColors.primary,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Provenance du produit",
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
                          hint: Text("Choisir le district de provenance",
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
                          value: districtProvenance,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              districtProvenance = newValue;
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
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Input(
                    enable: true,
                    placeholder: "Entrer ici la localité de provenance",
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: provenance,
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Destination du produit",
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
                          hint: Text("Choisir le district de destination",
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
                          value: districtDestination,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              districtDestination = newValue;
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
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Désignation",
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
                    placeholder: "Entrer ici la localité de déstination",
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: destination,
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Moyen de transport",
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
                          hint: Text("Choisir le moyen transport utilisé",
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
                          value: transportChoosed,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              transportChoosed = newValue;
                            });
                          },
                          items: listTransport
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
              // Produits
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Formation de prélèvement de matières premières",
                    style: TextStyle(
                      color: ArgonColors.text,
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    )
                  ),
                ),
              ),

              Column(children: produits.entries.map((e) {
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(e.value['produit'], 
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
                              TableRow(
                                children: <Widget>[
                                  Text("Quantité de Bois de Chauffe (kg) :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['qte']!=null?e.value['qte']:'', 
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
                                  Text("Quantité de Charbon de bois (kg) :", style: TextStyle(
                                      color: ArgonColors.text,
                                      fontSize: 12
                                  )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(e.value['qte']!=null?e.value['cb']:'',
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
                                widget.produits.removeAt(int.tryParse(e.value['index']));
                                produits.remove(e.key);
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
                padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Formation",
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
                          hint: Text("Choisir le type de formation",
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
                          value: produitChoosed,
                          isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              produitChoosed = newValue;
                            });
                          },
                          items: listeProduits
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
                  child: Text("Quantité de Bois de Chauffe",
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
                    placeholder: "Entrer la quantité de Bois de Chauffe (kg)",
                    borderColor: Color.fromRGBO(223, 225, 229, 1),
                    controller: qteProduitTemp,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow((RegExp("[.0-9]")))]
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Quantité de Charbon de Bois",
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
                      placeholder: "Entrer la quantité de Charbon de Bois (kg)",
                      borderColor: Color.fromRGBO(223, 225, 229, 1),
                      controller: qteProduitTemp,
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
                        produits.putIfAbsent(produitChoosed, () => {
                          "produit": produitChoosed,
                          "qte": qteProduitTemp.text,
                          "cb": qteCBTemp.text,
                          // "type": typeChoosed
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

            SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8),
                child: RaisedButton(
                  textColor: ArgonColors.text,
                  color: ArgonColors.success,
                  onPressed: () {
                    _save(widget.barriereEnCours);
                    Navigator.pushReplacementNamed(context, '/listebarriere');
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
