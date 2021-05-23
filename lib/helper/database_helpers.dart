import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// database table and column names
final String columnId = '_id';

// Menage
final String tableMenage = 'menage';
final String columnIdMenage = '_id';
final String columnDateMenage = 'date';
final String columnDistrictMenage = 'district';
final String columnAgglomerationMenage = 'agglomeration';
final String columnTypeMenage = 'typeMenage';
final String columnTailleMenage = 'tailleMenage';
final String columnTypeGrosConsommateur= 'typeGrosConsommateur';

// Energie de cuisson
final String tableEnergieCuisson = 'energieCuisson';
final String columnIdEnergieCuisson = '_id';
final String columnIdMenageEnergieCuisson = '_idMenage';
final String columnEnergieCuisson = 'energie';
final String columnTypeFoyerEnergieCuisson = 'type_foyer';
final String columnFrequenceFoyerEnergieCuisson = 'frequence_foyer';
final String columnPUFoyerEnergieCuisson = 'pu_foyer';
final String columnQteEnergieCuisson = 'qte';
final String columnPrixEnergieCuisson = 'prix';
final String columnSaisonEnergieCuisson = 'saison';

// Charbonnier
final String tableCharbonnier = 'charbonnier';
final String columnIdCharbonnier = '_id';
final String columnDateCharbonnier = 'date';
final String columnDistrictCharbonnier = 'district';
final String columnAgglomerationCharbonnier = 'agglomeration';
final String columnEspeceBoisCharbonnier = 'espece_bois';
final String columnAutorisationCharbonnier = 'autorisation';
/*Formation mbola mile jerena ny momba azy*/

// Meule
final String tableMeule = 'meule';
final String columnIdMeule = '_id';
final String columnIdCharbonnierMeule = 'id_charbonnier';
final String columnTypeMeule = 'type_meule';
final String columnMeule = 'meule';
final String columnLongeurMeule = 'longueur';
final String columnLargeurMeule = 'largeur';
final String columnHauteurMeule = 'hauteur';
final String columnZonePrelevementMeule = 'zone_prelevement';
final String columnDomaineMeule = 'domaine';
final String columnQteBMeule = 'qte_b';
final String columnQteCMeule = 'qte_c';

// Barriere
final String tableBarriere = 'barriere';
final String columnIdBarriere = '_id';
final String columnDateBarriere = 'date';
final String columnDistrictBarriere = 'district';
final String columnAgglomerationBarriere = 'agglomeration';
final String columnAxeBarriere = 'axe';
final String columnLatitudeBarriere = 'latitude';
final String columnLongitudeBarriere = 'longitude';
final String columnLaisserPasserBarriere = 'laisser_passer';
final String columnTransportBarriere = 'transport';
final String columnDistrictProvenanceBarriere = 'district_provenance';
final String columnDesignationProvenanceBarriere = 'designation_provenance';
final String columnDistrictArriveeBarriere = 'district_arrivee';
final String columnDesignationArriveeBarriere = 'designation_arrivee';

// Produit
final String tableProduit = 'produit';
final String columnIdProduit = '_id';
final String columnIdBarriereProduit = 'id_barriere';
final String columnTypeProduit = 'type';
final String columnProduit = 'produit';
final String columnQteProduit = 'qte';

// Données secondaires
final String tableDS = 'donnee_secondaire';
final String columnIdDS = '_id';
final String columnDistrictChoosed = 'district_ds';
final String columnAgglomerationChoosed = 'agglomeration_ds';
final String columnNbrPopulationR = 'nbr_population_r_ds';
final String columnNbrPopulationU = 'nbr_population_u_ds';
final String columnTailleMoyenneMenageR = 'nbr_taille_moyenne_m_u';
final String columnTailleMoyenneMenageU = 'nbr_taille_moyenne_m_r';
final String columnNbrCharbonnier = 'nbr_charbonnier';
final String columnNbrGrosConsommateur = 'nbr_gros_consommateur';
final String columnQteCB = 'qte_cb';

// Reboisement
final String tableReboisement = 'reboisement';
final String columnIdReboisement = '_id';
final String columnDateReboisement = 'date';
final String columnDistrictReboisement = 'district';
final String columnAgglomerationReboisement = 'agglomeration';
final String columnCommuneReboisement = 'commune';
final String columnAggReboisement = 'agg';
final String columnProprietaireReboisement = 'proprietaire';
final String columnGenreChoosedReboisement = 'genre';
final String columnSuperficieReboisement = 'superficie';
final String columnTypeReboisement = 'type';  //Ajouter
final String columnPareFeuxReboisement = 'pare_feux';
final String columnPareFeuxChoosedReboisement = 'pare_feux_choosed';
final String columnCultureChoosedReboisement = 'culture';
final String columnEssenceChoosedReboisement = 'essence';
final String columnProvenanceSemenceChoosedReboisement = 'provenance_semence';
final String columnProductiviteChoosedReboisement = 'productivite';
final String columnTravauxSolChoosedReboisement = 'travaux_sol';
final String columnAnneePlantationReboisement = 'annee_plantation';
final String columnDensiteReboisement = 'densite';
final String columnTauxRemplissageReboisement = 'taux_remplissage';
final String columnFertilisantReboisement = 'fertilisant';
final String columnActeurReboisement = 'acteur';

// Pepiniere
final String tablePepiniere = 'pepiniere';
final String columnDatePepiniere = 'date';
final String columnDistrictPepiniere = 'district';
final String columnAgglomerationPepiniere = 'agglomeration';
final String columnCommunePepiniere = 'commune';
final String columnAggPepiniere = 'agg';
final String columnLongPepiniere = 'long';
final String columnLatPepiniere = 'lat';
final String columnTypePepiniere = 'type';
final String columnProjetAppuiePepiniere = 'projet_appuie';
final String columnProprietairePepiniere = 'proprietaire';
final String columnGenreChoosedPepiniere = 'genreChoosed';
final String columnEspecesPepiniere = 'especes';
final String columnNbrPlantPepiniere = 'nbrPlant';
final String columnTauxPepiniere = 'taux'; //Ajouter

// ForetNaturel
final String tableForetNaturel = 'foret_naturel';
final String columnIdForetNaturel = '_id';
final String columnDateForetNaturel = 'date';
final String columnDistrictForetNaturel = 'district';
final String columnAgglomerationForetNaturel = 'agglomeration';
final String columnCommuneForetNaturel = 'commune';
final String columnAggForetNaturel = 'agg';
final String columnAmenagementForetNaturel = 'amenagement'; //Ajouter
final String columnSuperficieForetNaturel = 'superficie';
final String columnTypeFormationForetNaturel = 'type_formation'; //Ajouter
final String columnAuthorisationForetNaturel = 'authorisation'; //Ajouter
final String columnPareFeuxForetNaturel = 'pare_feux';
final String columnEssenceForetNaturel = 'essence';
final String columnSurfaceExploiteForetNaturel = 'surface_exploite'; //Ajouter
final String columnVolumeExploiteForetNaturel = 'volume_exploite'; //Ajouter
final String columnActeurForetNaturel = 'acteur';

// ProducteurFoyer Ajouter
final String tableProducteurF = 'producteur_foyer';
final String columnIdProducteurF = '_id';
final String columnDateProducteurF = 'date';
final String columnDistrictProducteurF = 'district';
final String columnAgglomerationProducteurF = 'agglomeration';
final String columnCommuneProducteurF = 'commune';
final String columnAggProducteurF = 'agg';
final String columnEnergieProducteurF = 'energie';
final String columnQteProducteurF = 'qte';
final String columnBiodigesteurProducteurF = 'biodigesteur';
final String columnNbrAppuieProducteurF = 'nbr_appuie';

// ProducteurEnergie Ajouter
final String tableProducteurE = 'producteur_energie';
final String columnIdProducteurE = '_id';
final String columnDateProducteurE = 'date';
final String columnDistrictProducteurE = 'district';
final String columnAgglomerationProducteurE = 'agglomeration';
final String columnCommuneProducteurE = 'commune';
final String columnAggProducteurE = 'agg';
final String columnEnergieProducteurE = 'energie';
final String columnQteProducteurE = 'qte';
final String columnQtePlusCuissonProducteurE = 'qte_total';


// Base Enity
abstract class BaseEntity {
  int id;
  String getTable();
  fromMap(Map<String, dynamic> map);
  toMap();
  toMapString();
}

// ProducteurEnergie
class ProducteurEEntity extends BaseEntity {
  String date;
  String district;
  String agglomeration;
  String commune;
  String agg;

  String energie;
  double qte;
  double qteTotal; //Pour la cuisson + autre que la cuisson ex:electricite

  ProducteurEEntity();

  @override
  getTable() {
    return tableProducteurF;
  }

  ProducteurEEntity.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    date = map[columnDateProducteurF];
    district = map[columnDistrictProducteurF];
    agglomeration = map[columnAgglomerationProducteurF];
    commune = map[columnCommuneProducteurF];
    agg = map[columnAggProducteurF];
    energie = map[columnEnergieProducteurF];
    qte = map[columnQteProducteurF];
    qteTotal = map[columnQtePlusCuissonProducteurE];
  }

  @override
  fromMap(Map<String, dynamic> map) {
    ProducteurEEntity ds = ProducteurFEntity().fromMap(map);
    return ds;
  }

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnDistrictPepiniere : district,
      columnDatePepiniere : date,
      columnAgglomerationPepiniere : agglomeration,
      columnCommunePepiniere : commune,
      columnAggPepiniere : agg,
      columnEnergieProducteurF : energie,
      columnQteProducteurF : qte,
      columnQtePlusCuissonProducteurE : qteTotal
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  @override
  Map<String, dynamic> toMapString() {
    var map = <String, dynamic> {
      columnDistrictPepiniere : district,
      columnDatePepiniere : date,
      columnAgglomerationPepiniere : agglomeration,
      columnCommunePepiniere : commune,
      columnAggPepiniere : agg,
      columnEnergieProducteurF : energie,
      columnQteProducteurF : qte.toString(),
      columnQtePlusCuissonProducteurE : qteTotal.toString()
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

// ProducteurFoyer
class ProducteurFEntity extends BaseEntity {
  String date;
  String district;
  String agglomeration;
  String commune;
  String agg;

  String energie;
  double qte;
  double biodigesteur;
  int appuie;

  ProducteurFEntity();

  @override
  getTable() {
    return tableProducteurF;
  }

  ProducteurFEntity.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    date = map[columnDateProducteurF];
    district = map[columnDistrictProducteurF];
    agglomeration = map[columnAgglomerationProducteurF];
    commune = map[columnCommuneProducteurF];
    agg = map[columnAggProducteurF];
    energie = map[columnEnergieProducteurF];
    qte = map[columnQteProducteurF];
    biodigesteur = map[columnBiodigesteurProducteurF];
    appuie = map[columnNbrAppuieProducteurF];
  }

  @override
  fromMap(Map<String, dynamic> map) {
    ProducteurFEntity ds = ProducteurFEntity().fromMap(map);
    return ds;
  }

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnDistrictPepiniere : district,
      columnDatePepiniere : date,
      columnAgglomerationPepiniere : agglomeration,
      columnCommunePepiniere : commune,
      columnAggPepiniere : agg,
      columnEnergieProducteurF : energie,
      columnQteProducteurF : qte,
      columnBiodigesteurProducteurF : biodigesteur,
      columnNbrAppuieProducteurF : appuie
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  @override
  Map<String, dynamic> toMapString() {
    var map = <String, dynamic> {
      columnDistrictPepiniere : district,
      columnDatePepiniere : date,
      columnAgglomerationPepiniere : agglomeration,
      columnCommunePepiniere : commune,
      columnAggPepiniere : agg,
      columnEnergieProducteurF : energie,
      columnQteProducteurF : qte.toString(),
      columnBiodigesteurProducteurF : biodigesteur,
      columnNbrAppuieProducteurF : appuie.toString()
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

// ForetNaturel
class ForetNaturelEntity extends BaseEntity {
  String date;
  String district;
  String agglomeration;
  String commune;
  String agg;
  double superficie;
  bool pareFeux;
  String essence;
  String acteur;
  bool amenagement;
  String typeFormation;
  bool authorisation;
  double surfaceExpoite;
  double volumeExploite;

  ForetNaturelEntity();

  @override
  getTable() {
    return tableForetNaturel;
  }

  ForetNaturelEntity.fromMap(Map<String, dynamic> map) {
    id = map[columnIdForetNaturel];
    date = map[columnDateForetNaturel];
    district = map[columnDistrictForetNaturel];
    agglomeration = map[columnAgglomerationForetNaturel];
    commune = map[columnCommuneForetNaturel];
    agg = map[columnAggForetNaturel];
    superficie = map[columnSuperficieForetNaturel];
    pareFeux = map[columnPareFeuxForetNaturel]==1;
    essence = map[columnEssenceForetNaturel];
    acteur = map[columnActeurForetNaturel];
    amenagement = map[columnAmenagementForetNaturel] == 1;
    typeFormation = map[columnTypeFormationForetNaturel];
    authorisation = map[columnAuthorisationForetNaturel] == 1;
    surfaceExpoite = map[columnSurfaceExploiteForetNaturel];
    volumeExploite = map[columnVolumeExploiteForetNaturel];
  }

  @override
  fromMap(Map<String, dynamic> map) {
    ForetNaturelEntity ds = ForetNaturelEntity.fromMap(map);
    return ds;
  }
  
  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnDistrictForetNaturel : district,
      columnDateForetNaturel : date,
      columnAgglomerationForetNaturel : agglomeration,
      columnCommuneForetNaturel : commune,
      columnAggForetNaturel : agg,
      columnSuperficieForetNaturel : superficie,
      columnPareFeuxForetNaturel : pareFeux?1:0,
      columnEssenceForetNaturel : essence,
      columnActeurForetNaturel : acteur,
      columnAmenagementForetNaturel : amenagement?1:0,
      columnTypeFormationForetNaturel : typeFormation,
      columnAuthorisationForetNaturel : authorisation?1:0,
      columnSurfaceExploiteForetNaturel : surfaceExpoite,
      columnVolumeExploiteForetNaturel : volumeExploite
    };
    if (id != null) {
      map[columnIdDS] = id;
    }
    return map;
  }

  @override
  Map<String, dynamic> toMapString() {
    var map = <String, dynamic> {
      columnDistrictForetNaturel : district,
      columnDateForetNaturel : date,
      columnAgglomerationForetNaturel : agglomeration,
      columnCommuneForetNaturel : commune,
      columnAggForetNaturel : agg,
      columnSuperficieForetNaturel : superficie.toString(),
      columnPareFeuxForetNaturel : pareFeux?'1':'0',
      columnEssenceForetNaturel : essence,
      columnActeurForetNaturel : acteur,
      columnAmenagementForetNaturel : amenagement?'1':'0',
      columnTypeFormationForetNaturel : typeFormation,
      columnAuthorisationForetNaturel : authorisation?'1':'0',
      columnSurfaceExploiteForetNaturel : surfaceExpoite,
      columnVolumeExploiteForetNaturel : volumeExploite
    };
    if (id != null) {
      map[columnIdDS] = id;
    }
    return map;
  }

}

// Pepiniere
class PepiniereEntity extends BaseEntity {
  String date;
  String district;
  String agglomeration;
  String commune;
  String agg;
  String proprietaire;
  String genreChoosed;
  String type;
  String lat;
  String long;
  String projetAppuie;
  String especes;
  int nbrPlant;
  double taux;

  PepiniereEntity();

  @override
  getTable() {
    return tablePepiniere;
  }

  PepiniereEntity.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    date = map[columnDatePepiniere];
    district = map[columnDistrictPepiniere];
    agglomeration = map[columnAgglomerationPepiniere];
    commune = map[columnCommunePepiniere];
    agg = map[columnAggPepiniere];
    proprietaire = map[columnProprietairePepiniere];
    genreChoosed = map[columnGenreChoosedPepiniere];
    type = map[columnTypePepiniere];
    lat = map[columnLatPepiniere];
    long = map[columnLongPepiniere];
    projetAppuie = map[columnProjetAppuiePepiniere];
    especes = map[columnEspecesPepiniere];
    nbrPlant = map[columnNbrPlantPepiniere];
    taux = map[columnTauxPepiniere];
  }

  @override
  fromMap(Map<String, dynamic> map) {
    PepiniereEntity ds = PepiniereEntity.fromMap(map);
    return ds;
  }
  
  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnDistrictPepiniere : district,
      columnDatePepiniere : date,
      columnAgglomerationPepiniere : agglomeration,
      columnCommunePepiniere : commune,
      columnAggPepiniere : agg,
      columnProprietairePepiniere : proprietaire,
      columnGenreChoosedPepiniere : genreChoosed,
      columnTypePepiniere : type,
      columnLatPepiniere : lat,
      columnLongPepiniere : long,
      columnProjetAppuiePepiniere : projetAppuie,
      columnEspecesPepiniere : especes,
      columnNbrPlantPepiniere : nbrPlant,
      columnTauxPepiniere : taux,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  @override
  Map<String, dynamic> toMapString() {
    var map = <String, dynamic> {
      columnDistrictPepiniere : district,
      columnDatePepiniere : date,
      columnAgglomerationPepiniere : agglomeration,
      columnCommunePepiniere : commune,
      columnAggPepiniere : agg,
      columnProprietairePepiniere : proprietaire,
      columnGenreChoosedPepiniere : genreChoosed,
      columnTypePepiniere : type,
      columnLatPepiniere : lat,
      columnLongPepiniere : long,
      columnProjetAppuiePepiniere : projetAppuie,
      columnEspecesPepiniere : especes,
      columnNbrPlantPepiniere : nbrPlant.toString(),
      columnTauxPepiniere : taux.toString(),
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

// Reboisement
class ReboisementEntity extends BaseEntity {
  String date;
  String district;
  String agglomeration;
  String commune;
  String agg;
  String type;
  String proprietaire;
  String genreChoosed;
  double superficie;
  bool pareFeux;
  bool fertilisant;
  String pareFeuxChoosed;
  String cultureChoosed;
  String essenceChoosed;
  String provenanceSemenceChoosed;
  String productiviteChoosed;
  String travauxSolChoosed;
  int anneePlantation;
  double densite;
  double tauxRemplissage;
  String acteur;

  ReboisementEntity();

  @override
  getTable() {
    return tableReboisement;
  }

  ReboisementEntity.fromMap(Map<String, dynamic> map) {
    id = map[columnIdReboisement];
    date = map[columnDateReboisement];
    district = map[columnDistrictReboisement];
    agglomeration = map[columnAgglomerationReboisement];
    commune = map[columnCommuneReboisement];
    agg = map[columnAggReboisement];
    type = map[columnTypeReboisement];
    proprietaire = map[columnProprietaireReboisement];
    genreChoosed = map[columnGenreChoosedReboisement];
    superficie = map[columnSuperficieReboisement];
    pareFeux = map[columnPareFeuxReboisement]==1;
    fertilisant = map[columnFertilisantReboisement]==1;
    pareFeuxChoosed = map[columnPareFeuxChoosedReboisement];
    cultureChoosed = map[columnCultureChoosedReboisement];
    essenceChoosed = map[columnEssenceChoosedReboisement];
    provenanceSemenceChoosed = map[columnProvenanceSemenceChoosedReboisement];
    productiviteChoosed = map[columnProductiviteChoosedReboisement];
    travauxSolChoosed = map[columnTravauxSolChoosedReboisement];
    anneePlantation = map[columnAnneePlantationReboisement];
    densite = map[columnDensiteReboisement];
    tauxRemplissage = map[columnTauxRemplissageReboisement];
    acteur = map[columnActeurReboisement];
  }

  @override
  fromMap(Map<String, dynamic> map) {
    ReboisementEntity ds = ReboisementEntity.fromMap(map);
    return ds;
  }
  
  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnDistrictReboisement : district,
      columnDateReboisement : date,
      columnAgglomerationReboisement : agglomeration,
      columnCommuneReboisement : commune,
      columnAggReboisement : agg,
      columnTypeReboisement : type,
      columnProprietaireReboisement : proprietaire,
      columnGenreChoosedReboisement : genreChoosed,
      columnSuperficieReboisement : superficie,
      columnPareFeuxReboisement : pareFeux?1:0,
      columnFertilisantReboisement : fertilisant?1:0,
      columnPareFeuxChoosedReboisement : pareFeuxChoosed,
      columnCultureChoosedReboisement : cultureChoosed,
      columnEssenceChoosedReboisement : essenceChoosed,
      columnProvenanceSemenceChoosedReboisement : provenanceSemenceChoosed,
      columnProductiviteChoosedReboisement : productiviteChoosed,
      columnTravauxSolChoosedReboisement : travauxSolChoosed,
      columnAnneePlantationReboisement : anneePlantation,
      columnDensiteReboisement : densite,
      columnTauxRemplissageReboisement : tauxRemplissage,
      columnActeurReboisement : acteur,
    };
    if (id != null) {
      map[columnIdDS] = id;
    }
    return map;
  }

  @override
  Map<String, dynamic> toMapString() {
    var map = <String, dynamic> {
      columnDistrictReboisement : district,
      columnDateReboisement : date,
      columnAgglomerationReboisement : agglomeration,
      columnCommuneReboisement : commune,
      columnAggReboisement : agg,
      columnTypeReboisement : type,
      columnProprietaireReboisement : proprietaire,
      columnGenreChoosedReboisement : genreChoosed,
      columnSuperficieReboisement : superficie.toString(),
      columnPareFeuxReboisement : pareFeux?'1':'0',
      columnFertilisantReboisement : fertilisant?'1':'0',
      columnPareFeuxChoosedReboisement : pareFeuxChoosed,
      columnCultureChoosedReboisement : cultureChoosed,
      columnEssenceChoosedReboisement : essenceChoosed,
      columnProvenanceSemenceChoosedReboisement : provenanceSemenceChoosed,
      columnProductiviteChoosedReboisement : productiviteChoosed,
      columnTravauxSolChoosedReboisement : travauxSolChoosed,
      columnAnneePlantationReboisement : anneePlantation.toString(),
      columnDensiteReboisement : densite.toString(),
      columnTauxRemplissageReboisement : tauxRemplissage.toString(),
      columnActeurReboisement : acteur,
    };
    if (id != null) {
      map[columnIdDS] = id;
    }
    return map;
  }

}

// Données secondaires
class DonneeSecondaireEntity extends BaseEntity {
  // int id;
  String district;
  String agglomeration;
  int nbrPopulationR; 
  int nbrPopulationU; 
  int tailleMoyenneMenageR; 
  int tailleMoyenneMenageU;
  int nbrCharbonnier;
  int nbrGrosConsommateur;
  double qteCB; 

  DonneeSecondaireEntity();

  @override
  getTable() {
    return tableDS;
  }

  DonneeSecondaireEntity.fromMap(Map<String, dynamic> map) {
    id = map[columnIdDS];
    district = map[columnDistrictChoosed];
    agglomeration = map[columnAgglomerationChoosed];
    nbrPopulationR = map[columnNbrPopulationR];
    nbrPopulationU = map[columnNbrPopulationU];
    tailleMoyenneMenageR = map[columnTailleMoyenneMenageR];
    tailleMoyenneMenageU = map[columnTailleMoyenneMenageU];
    nbrCharbonnier = map[columnNbrCharbonnier];
    nbrGrosConsommateur = map[columnNbrGrosConsommateur];
    qteCB = map[columnQteCB];
  }

  @override
  fromMap(Map<String, dynamic> map) {
    DonneeSecondaireEntity ds = DonneeSecondaireEntity.fromMap(map);
    return ds;
  }
  
  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnDistrictChoosed : district,
      columnAgglomerationChoosed : agglomeration,
      columnNbrPopulationR : nbrPopulationR,
      columnNbrPopulationU : nbrPopulationU,
      columnTailleMoyenneMenageR : tailleMoyenneMenageR,
      columnTailleMoyenneMenageU : tailleMoyenneMenageU,
      columnNbrCharbonnier : nbrCharbonnier,
      columnNbrGrosConsommateur : nbrGrosConsommateur,
      columnQteCB : qteCB
    };
    if (id != null) {
      map[columnIdDS] = id;
    }
    return map;
  }

  @override
  Map<String, String> toMapString() {
    var map = <String, String> {
      columnDistrictChoosed : district,
      columnAgglomerationChoosed : agglomeration,
      columnNbrPopulationR : nbrPopulationR.toString(),
      columnNbrPopulationU : nbrPopulationU.toString(),
      columnTailleMoyenneMenageR : tailleMoyenneMenageR.toString(),
      columnTailleMoyenneMenageU : tailleMoyenneMenageU.toString(),
      columnNbrCharbonnier : nbrCharbonnier.toString(),
      columnNbrGrosConsommateur : nbrGrosConsommateur.toString(),
      columnQteCB : qteCB.toString()
    };
    if (id != null) {
      map[columnIdDS] = id.toString();
    }
    return map;
  }
}

// Produit
class ProduitEntity extends BaseEntity {
  // int id;
  int idBarriere;
  String typeProduit;
  String produit;
  double qte;

  ProduitEntity();

  @override
  getTable() {
    return tableProduit;
  }

  ProduitEntity.fromMap(Map<String, dynamic> map) {
    id = map[columnIdProduit];
    idBarriere = map[columnIdBarriereProduit];
    typeProduit = map[columnTypeProduit];
    produit = map[columnProduit];
    qte = map[columnQteProduit];
  }

  @override
  fromMap(Map<String, dynamic> map) {
    ProduitEntity ds = ProduitEntity.fromMap(map);
    return ds;
  }
  
  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnIdBarriereProduit : idBarriere,
      columnTypeProduit : typeProduit,
      columnProduit : produit,
      columnQteProduit : qte
    };
    if (id != null) {
      map[columnIdBarriere] = id;
    }
    return map;
  }

  @override
  Map<String, String> toMapString() {
    var map = <String, String> {
      columnIdBarriereProduit : idBarriere.toString(),
      columnTypeProduit : typeProduit,
      columnProduit : produit,
      columnQteProduit : qte.toString()
    };
    if (id != null) {
      map[columnIdBarriere] = id.toString();
    }
    return map;
  }
}

// BarriereEntity
class BarriereEntity extends BaseEntity {
  // int id;
  String dateBarriere;
  String districtBarriere;
  String agglomerationBarriere;
  String axe;
  String latitude;
  String longitude;
  bool laisserPasser;
  String transport;
  String districtProvenance;
  String designationProvenance;
  String districtArrivee;
  String designationArrivee;

  BarriereEntity();

  @override
  getTable() {
    return tableBarriere;
  }

  // convenience constructor to create a Barriere object
  BarriereEntity.fromMap(Map<String, dynamic> map) {
    id =  map[columnIdBarriere];
    dateBarriere =  map[columnDateBarriere];
    districtBarriere =  map[columnDistrictBarriere];
    agglomerationBarriere =  map[columnAgglomerationBarriere];
    axe =  map[columnAxeBarriere];
    latitude =  map[columnLatitudeBarriere];
    longitude =  map[columnLongitudeBarriere];
    laisserPasser =  map[columnLaisserPasserBarriere]==1;
    transport =  map[columnTransportBarriere];
    districtProvenance =  map[columnDistrictProvenanceBarriere];
    designationProvenance =  map[columnDesignationProvenanceBarriere];
    districtArrivee =  map[columnDistrictArriveeBarriere];
    designationArrivee =  map[columnDesignationArriveeBarriere];
  }

  @override
  fromMap(Map<String, dynamic> map) {
    BarriereEntity ds = BarriereEntity.fromMap(map);
    return ds;
  }

  // convenience method to create a Barriere from this Word object
  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnDateBarriere : dateBarriere,
      columnDistrictBarriere : districtBarriere,
      columnAgglomerationBarriere : agglomerationBarriere,
      columnAxeBarriere : axe,
      columnLatitudeBarriere : latitude,
      columnLongitudeBarriere : longitude,
      columnLaisserPasserBarriere : laisserPasser?1:0,
      columnTransportBarriere : transport,
      columnDistrictProvenanceBarriere : districtProvenance,
      columnDesignationProvenanceBarriere : designationProvenance,
      columnDistrictArriveeBarriere : districtArrivee,
      columnDesignationArriveeBarriere : designationArrivee
    };
    if (id != null) {
      map[columnIdBarriere] = id;
    }
    return map;
  }

  @override
  Map<String, String> toMapString() {
    var map = <String, String> {
      columnDateBarriere : dateBarriere,
      columnDistrictBarriere : districtBarriere,
      columnAgglomerationBarriere : agglomerationBarriere,
      columnAxeBarriere : axe,
      columnLatitudeBarriere : latitude,
      columnLongitudeBarriere : longitude,
      columnLaisserPasserBarriere : laisserPasser?'1':'0',
      columnTransportBarriere : transport,
      columnDistrictProvenanceBarriere : districtProvenance,
      columnDesignationProvenanceBarriere : designationProvenance,
      columnDistrictArriveeBarriere : districtArrivee,
      columnDesignationArriveeBarriere : designationArrivee
    };
    if (id != null) {
      map[columnIdBarriere] = id.toString();
    }
    return map;
  }
}

// MeuleEntity
class MeuleEntity extends BaseEntity {
  // int id;
  int idCharbonnier;
  String typeMeule;
  String meule;
  String zonePrelevement;
  String domaine;
  double longueur;
  double largeur;
  double hauteur;
  double qteB;
  double qteC;

  MeuleEntity();

  @override
  getTable() {
    return tableMeule;
  }

  MeuleEntity.fromMap(Map<String, dynamic> map) {
    id = map[columnIdMeule];
    idCharbonnier = map[columnIdCharbonnierMeule];
    typeMeule = map[columnTypeMeule];
    meule = map[columnMeule];
    zonePrelevement = map[columnZonePrelevementMeule];
    domaine = map[columnDomaineMeule];
    longueur = map[columnLongeurMeule];
    largeur = map[columnLargeurMeule];
    hauteur = map[columnHauteurMeule];
    qteB = map[columnQteBMeule];
    qteC = map[columnQteCMeule];
  }

  @override
  fromMap(Map<String, dynamic> map) {
    MeuleEntity ds = MeuleEntity.fromMap(map);
    return ds;
  }
  
  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnIdCharbonnierMeule : idCharbonnier,
      columnTypeMeule : typeMeule,
      columnMeule : meule,
      columnZonePrelevementMeule : zonePrelevement,
      columnDomaineMeule : domaine,
      columnLongeurMeule : longueur,
      columnLargeurMeule : largeur,
      columnHauteurMeule : hauteur,
      columnQteBMeule : qteB,
      columnQteCMeule : qteC
    };
    if (id != null) {
      map[columnIdMeule] = id;
    }
    return map;
  }

  @override
  Map<String, String> toMapString() {
    var map = <String, String> {
      columnIdCharbonnierMeule : idCharbonnier.toString(),
      columnTypeMeule : typeMeule,
      columnMeule : meule!=null?meule:'',
      columnZonePrelevementMeule : zonePrelevement,
      columnDomaineMeule : domaine,
      columnLongeurMeule : longueur.toString(),
      columnLargeurMeule : largeur.toString(),
      columnHauteurMeule : hauteur.toString(),
      columnQteBMeule : qteB.toString(),
      columnQteCMeule : qteC.toString()
    };
    if (id != null) {
      map[columnIdMeule] = id.toString();
    }
    return map;
  }
}

// CharbonnierEntity
class CharbonnierEntity extends BaseEntity {
  // int id;
  String dateCharbonnier;
  String districtCharbonnier;
  String agglomerationCharbonnier;
  String especeBoisCharbonnier;
  // String zonePrelevelementCharbonnier;
  // String domainePrelevelementCharbonnier;
  bool autorisationCharbonnier;
  // double qteBoisCharbonnier;
  // double qteCharbonCharbonnier;

  CharbonnierEntity();

  @override
  getTable() {
    return tableCharbonnier;
  }

  // convenience constructor to create a Charbonnier object
  CharbonnierEntity.fromMap(Map<String, dynamic> map) {
    id = map[columnIdCharbonnier];
    dateCharbonnier = map[columnDateCharbonnier];
    districtCharbonnier = map[columnDistrictCharbonnier];
    agglomerationCharbonnier = map[columnAgglomerationCharbonnier];
    especeBoisCharbonnier = map[columnEspeceBoisCharbonnier];
    map[columnAutorisationCharbonnier]==0?autorisationCharbonnier = false:autorisationCharbonnier = true;
    // qteBoisCharbonnier = map[columnQteBoisCharbonnier];
    // qteCharbonCharbonnier = map[columnQteCharbonCharbonnier];
  }

  @override
  fromMap(Map<String, dynamic> map) {
    CharbonnierEntity ds = CharbonnierEntity.fromMap(map);
    return ds;
  }

  // convenience method to create a Charbonnier from this Word object
  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnDateCharbonnier : dateCharbonnier,
      columnDistrictCharbonnier : districtCharbonnier,
      columnAgglomerationCharbonnier : agglomerationCharbonnier,
      columnEspeceBoisCharbonnier : especeBoisCharbonnier,
      columnAutorisationCharbonnier : autorisationCharbonnier?1:0,
      // columnQteBoisCharbonnier : qteBoisCharbonnier,
      // columnQteCharbonCharbonnier : qteCharbonCharbonnier
    };
    if (id != null) {
      map[columnIdCharbonnier] = id;
    }
    return map;
  }

  @override
  Map<String, String> toMapString() {
    var map = <String, String> {
      columnDateCharbonnier : dateCharbonnier,
      columnDistrictCharbonnier : districtCharbonnier,
      columnAgglomerationCharbonnier : agglomerationCharbonnier!=null?agglomerationCharbonnier:'',
      columnEspeceBoisCharbonnier : especeBoisCharbonnier,
      columnAutorisationCharbonnier : autorisationCharbonnier?'1':'0',
      // columnQteBoisCharbonnier : qteBoisCharbonnier.toString(),
      // columnQteCharbonCharbonnier : qteCharbonCharbonnier.toString()
    };
    if (id != null) {
      map[columnIdCharbonnier] = id.toString();
    }
    return map;
  }
}

// EnergieCuisson
class EnergieCuissonEntity extends BaseEntity {

  // int id;
  int idMenage;
  String energieCuisson;
  // String autreEnergieCuisson;
  String typeFoyer;
  double frequenceFoyer;
  double puFoyer;
  int qte;
  int prix;
  String saison;

  EnergieCuissonEntity();

  @override
  getTable() {
    return tableEnergieCuisson;
  }

  // convenience constructor to create a Word object
  EnergieCuissonEntity.fromMap(Map<String, dynamic> map) {
    id = map[columnIdEnergieCuisson];
    idMenage = map[columnIdMenageEnergieCuisson];
    energieCuisson = map[columnEnergieCuisson];
    typeFoyer = map[columnTypeFoyerEnergieCuisson];
    frequenceFoyer = map[columnFrequenceFoyerEnergieCuisson];
    puFoyer = map[columnPUFoyerEnergieCuisson];
    qte = map[columnQteEnergieCuisson];
    prix = map[columnPrixEnergieCuisson];
    saison = map[columnSaisonEnergieCuisson];
  }

  @override
  fromMap(Map<String, dynamic> map) {
    EnergieCuissonEntity ds = EnergieCuissonEntity.fromMap(map);
    return ds;
  }

  // convenience method to create a Map from this Word object
  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnIdMenageEnergieCuisson : idMenage,
      columnEnergieCuisson : energieCuisson,
      // columnAutreEnergieCuisson : autreEnergieCuisson,
      columnTypeFoyerEnergieCuisson : typeFoyer,
      columnFrequenceFoyerEnergieCuisson : frequenceFoyer,
      columnPUFoyerEnergieCuisson : puFoyer,
      columnQteEnergieCuisson : qte,
      columnPrixEnergieCuisson : prix,
      columnSaisonEnergieCuisson : saison
    };
    if (id != null) {
      map[columnIdEnergieCuisson] = id;
    }
    return map;
  }

  // convenience method to create a Map from this Word object
  @override
  Map<String, String> toMapString() {
    var map = <String, String>{
      columnIdMenageEnergieCuisson : idMenage.toString(),
      columnEnergieCuisson : energieCuisson,
      // columnAutreEnergieCuisson : autreEnergieCuisson,
      columnTypeFoyerEnergieCuisson : typeFoyer,
      columnFrequenceFoyerEnergieCuisson : frequenceFoyer.toString(),
      columnPUFoyerEnergieCuisson : puFoyer.toString(),
      columnQteEnergieCuisson : qte.toString(),
      columnPrixEnergieCuisson : prix.toString(),
      columnSaisonEnergieCuisson : saison
    };
    if (id != null) {
      map[columnIdEnergieCuisson] = id.toString();
    }
    return map;
  }

}

// menageEntity
class MenageEntity extends BaseEntity {

  // int id;
  String dateMenage;
  String districtMenage;
  String agglomerationMenage;
  String typeMenage;
  int tailleMenage;
  String typeGrosConsommateur;

  MenageEntity();

  @override
  getTable() {
    return tableMenage;
  }

  // convenience constructor to create a Word object
  MenageEntity.fromMap(Map<String, dynamic> map) {
    // print('map');
    // print(map);
    id = map[columnIdMenage];
    dateMenage = map[columnDateMenage];
    districtMenage = map[columnDistrictMenage];
    agglomerationMenage = map[columnAgglomerationMenage];
    typeMenage = map[columnTypeMenage];
    tailleMenage = map[columnTailleMenage];
    typeGrosConsommateur = map[columnTypeGrosConsommateur];
  }

  @override
  fromMap(Map<String, dynamic> map) {
    MenageEntity ds = MenageEntity.fromMap(map);
    return ds;
  }

  // convenience method to create a Map from this Word object
  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnDateMenage : dateMenage,
      columnDistrictMenage : districtMenage,
      columnAgglomerationMenage : agglomerationMenage,
      columnTypeMenage : typeMenage,
      columnTailleMenage : tailleMenage,
      columnTypeGrosConsommateur : typeGrosConsommateur
    };
    if (id != null) {
      map[columnIdMenage] = id;
    }
    return map;
  }

  @override
  Map<String, String> toMapString() {
    var map = <String, String>{
      columnDateMenage : dateMenage,
      columnDistrictMenage : districtMenage,
      columnAgglomerationMenage : agglomerationMenage,
      columnTypeMenage : typeMenage,
      columnTailleMenage : tailleMenage.toString(),
      columnTypeGrosConsommateur : typeGrosConsommateur
    };
    if (id != null) {
      map[columnIdMenage] = id.toString();
    }
    return map;
  }
}



// singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "ssbeac.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    return await openDatabase (
      join(await getDatabasesPath(), _databaseName),
      version: _databaseVersion,
      onCreate: _onCreate
    );
  }

  // SQL string to create the database 
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableMenage (
            $columnIdMenage INTEGER PRIMARY KEY,
            $columnDateMenage TEXT NOT NULL,
            $columnDistrictMenage  TEXT,
            $columnAgglomerationMenage TEXT,
            $columnTypeMenage TEXT,
            $columnTailleMenage INTEGER,
            $columnTypeGrosConsommateur TEXT
          );
          ''');
    await db.execute('''
          CREATE TABLE $tableEnergieCuisson (
            $columnIdEnergieCuisson INTEGER PRIMARY KEY,
            $columnIdMenageEnergieCuisson INTEGER,
            $columnEnergieCuisson TEXT,
            $columnTypeFoyerEnergieCuisson TEXT,
            $columnFrequenceFoyerEnergieCuisson REAL,
            $columnPUFoyerEnergieCuisson REAL,
            $columnQteEnergieCuisson INTEGER,
            $columnPrixEnergieCuisson INTEGER,
            $columnSaisonEnergieCuisson TEXT
          );
    ''');
    await db.execute('''
          CREATE TABLE $tableMeule (
            $columnIdMeule INTEGER PRIMARY KEY,
            $columnIdCharbonnierMeule INTEGER,
            $columnTypeMeule TEXT,
            $columnMeule TEXT,
            $columnZonePrelevementMeule TEXT,
            $columnDomaineMeule TEXT,
            $columnLongeurMeule REAL,
            $columnLargeurMeule REAL,
            $columnHauteurMeule REAL,
            $columnQteBMeule REAL,
            $columnQteCMeule REAL
          );
    ''');
    await db.execute('''
          CREATE TABLE $tableCharbonnier (
            $columnIdCharbonnier INTEGER PRIMARY KEY,
            $columnDateCharbonnier TEXT,
            $columnDistrictCharbonnier TEXT,
            $columnAgglomerationCharbonnier TEXT,
            $columnEspeceBoisCharbonnier TEXT,
            $columnAutorisationCharbonnier INTEGER
          );
    ''');
    await db.execute('''
          CREATE TABLE $tableBarriere (
            $columnIdBarriere INTEGER PRIMARY KEY,
            $columnDateBarriere TEXT,
            $columnDistrictBarriere TEXT,
            $columnAgglomerationBarriere TEXT,
            $columnAxeBarriere TEXT,
            $columnLatitudeBarriere TEXT,
            $columnLongitudeBarriere TEXT,
            $columnLaisserPasserBarriere INTEGER,
            $columnTransportBarriere TEXT,
            $columnDistrictProvenanceBarriere TEXT,
            $columnDesignationProvenanceBarriere TEXT,
            $columnDistrictArriveeBarriere TEXT,
            $columnDesignationArriveeBarriere TEXT
          );
    ''');
    await db.execute('''
          CREATE TABLE $tableProduit (
            $columnIdProduit INTEGER PRIMARY KEY,
            $columnIdBarriereProduit INTEGER,
            $columnTypeProduit TEXT,
            $columnProduit TEXT,
            $columnQteProduit REAL
          );
    ''');
    await db.execute('''
          CREATE TABLE $tableDS (
            $columnIdDS INTEGER PRIMARY KEY,
            $columnDistrictChoosed TEXT,
            $columnAgglomerationChoosed TEXT,
            $columnNbrPopulationR INTEGER,
            $columnNbrPopulationU INTEGER,
            $columnTailleMoyenneMenageR INTEGER,
            $columnTailleMoyenneMenageU INTEGER,
            $columnNbrCharbonnier INTEGER,
            $columnNbrGrosConsommateur INTEGER,
            $columnQteCB REAL
          );
    ''');
    await db.execute('''
          CREATE TABLE $tableReboisement (
            $columnIdReboisement INTEGER PRIMARY KEY,
            $columnDateReboisement TEXT,
            $columnDistrictReboisement TEXT,
            $columnAgglomerationReboisement TEXT,
            $columnCommuneReboisement TEXT,
            $columnAggReboisement TEXT,
            $columnTypeReboisement TEXT,
            $columnProprietaireReboisement TEXT,
            $columnGenreChoosedReboisement TEXT,
            $columnSuperficieReboisement REAL,
            $columnPareFeuxReboisement INTEGER,
            $columnPareFeuxChoosedReboisement TEXT,
            $columnCultureChoosedReboisement TEXT,
            $columnFertilisantReboisement INTEGER,
            $columnEssenceChoosedReboisement TEXT,
            $columnProvenanceSemenceChoosedReboisement TEXT,
            $columnProductiviteChoosedReboisement TEXT,
            $columnTravauxSolChoosedReboisement TEXT,
            $columnAnneePlantationReboisement INTEGER,
            $columnDensiteReboisement REAL,
            $columnTauxRemplissageReboisement REAL,
            $columnActeurReboisement TEXT
          );
    ''');

    await db.execute('''
          CREATE TABLE $tablePepiniere (
            $columnId INTEGER PRIMARY KEY,
            $columnDatePepiniere TEXT,
            $columnDistrictPepiniere TEXT,
            $columnAgglomerationPepiniere TEXT,
            $columnCommunePepiniere TEXT,
            $columnAggPepiniere TEXT,
            $columnProprietairePepiniere TEXT,
            $columnGenreChoosedPepiniere TEXT,
            $columnTypePepiniere TEXT,
            $columnLatPepiniere TEXT,
            $columnLongPepiniere TEXT,
            $columnProjetAppuiePepiniere TEXT,
            $columnEspecesPepiniere TEXT,
            $columnNbrPlantPepiniere INTEGER,
            $columnTauxPepiniere REAL
          );
    ''');

    await db.execute('''
          CREATE TABLE $tableForetNaturel (
            $columnIdForetNaturel INTEGER PRIMARY KEY,
            $columnDateForetNaturel TEXT,
            $columnDistrictForetNaturel TEXT,
            $columnAgglomerationForetNaturel TEXT,
            $columnCommuneForetNaturel TEXT,
            $columnAggForetNaturel TEXT,
            $columnSuperficieForetNaturel REAL,
            $columnPareFeuxForetNaturel INTEGER,
            $columnEssenceForetNaturel TEXT,
            $columnActeurForetNaturel TEXT,
            $columnAmenagementForetNaturel INTEGER,
            $columnTypeFormationForetNaturel TEXT,
            $columnAuthorisationForetNaturel INTEGER,
            $columnSurfaceExploiteForetNaturel TEXT,
            $columnVolumeExploiteForetNaturel TEXT,
          );
    ''');

    await db.execute('''
          CREATE TABLE $tableProducteurF (
            $columnIdProducteurF INTEGER PRIMARY KEY,
            $columnDateProducteurF TEXT,
            $columnDistrictProducteurF TEXT,
            $columnAgglomerationProducteurF TEXT,
            $columnCommuneProducteurF TEXT,
            $columnAggProducteurF TEXT,
            $columnEnergieProducteurF TEXT,
            $columnQteProducteurF REAL,
            $columnBiodigesteurProducteurF REAL,
            $columnNbrAppuieProducteurF INTEGER
          );
    ''');

    await db.execute('''
          CREATE TABLE $tableProducteurE (
            $columnIdProducteurE INTEGER PRIMARY KEY,
            $columnDateProducteurE TEXT,
            $columnDistrictProducteurE TEXT,
            $columnAgglomerationProducteurE TEXT,
            $columnCommuneProducteurE TEXT,
            $columnAggProducteurE TEXT,
            $columnEnergieProducteurE TEXT,
            $columnQteProducteurE REAL,
            $columnQtePlusCuissonProducteurE REAL
          );
    ''');

    await db.execute('''
          CREATE TABLE connexion (
            id INTEGER PRIMARY KEY,
            etat INTEGER
          );
    ''');
  }

  // Database helper methods:
  
  // Insert specific for all
  Future<int> insert(BaseEntity base) async {
    Database db = await database;
    int id = await db.transaction((txn) async {
      print(base.toMapString());
      int idBase = await txn.insert(base.getTable(), base.toMap());
      base.id = int.tryParse(idBase.toString() + DateTime.now().millisecond.toString());
      return await txn.update(base.getTable(), base.toMap(), where: '''$columnIdMenage = ?''', whereArgs: [idBase]);
    });
    return id;
  }
  
  // Update specific for all
  Future<int> update(BaseEntity ds) async {
    Database db = await database;
    int id = await db.transaction((txn) async {
      int dsId = ds.id;
      ds.id = null;
      int idBase = await txn.update(ds.getTable(), ds.toMap(), where: '''$columnId = ?''', whereArgs: [dsId]);
      return idBase;
    });
    return id;
  }


  // Login
  Future<int> log(int idu) async {
    Database db = await database;
    int id = await db.insert('connexion', {'etat':idu});
    return id;
  }

  Future<int> deco() async {
    Database db = await database;
    int id = await db.insert('connexion', {'etat':0});
    return id;
  }

  Future<bool> checkLogin() async {
    Database db = await database;
    List<Map> map = await db.query(
      'connexion',
      columns: [
        'etat'
      ]);
    return map.last['etat']!=0;
  }

  // Menage et EC

  Future<int> insertMenage(MenageEntity menage, List<EnergieCuissonEntity> energie) async {
    Database db = await database;
    int id = await db.transaction((txn) async {
      int idMenage = await txn.insert(tableMenage, menage.toMap());
      for (var s in energie) {
        s.idMenage = idMenage;
        txn.insert(tableEnergieCuisson, s.toMap());
      }
      return idMenage;
    });
    return id;
  }

  Future<int> updateMenage(MenageEntity menage, List<EnergieCuissonEntity> energie) async {
    Database db = await database;
    int id = await db.transaction((txn) async {
      int menageId = menage.id;
      menage.id = null;
      int idMenage = await txn.update(tableMenage, menage.toMap(), where: '''$columnIdMenage = ?''', whereArgs: [menageId]);
      txn.delete(
        tableEnergieCuisson,
        where: '''$columnIdMenageEnergieCuisson = ?''',
        whereArgs: [idMenage]
      ).then((value) => {
          for (var s in energie) {
            s.idMenage = idMenage,
            txn.insert(tableEnergieCuisson, s.toMap())
          }
      });
      return idMenage;
    });
    return id;
  }

  Future<int> insertEnergieCuisson(EnergieCuissonEntity energieCuisson) async {
    Database db = await database;
    int id = await db.insert(tableEnergieCuisson, energieCuisson.toMap());
    return id;
  }

  

  Future<MenageEntity> queryMenage(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(
      tableMenage,
      columns: [
        columnIdMenage,
        columnDateMenage,
        columnDistrictMenage,
        columnAgglomerationMenage,
        columnTypeMenage,
        columnTailleMenage,
        columnTypeGrosConsommateur
      ],
        where: '$columnIdMenage = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return MenageEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Map>> queryAllMenage() async {
    Database db = await database;
    return await db.query(
      tableMenage,
      columns: [
        columnIdMenage,
        columnDateMenage,
        columnDistrictMenage,
        columnAgglomerationMenage,
        columnTypeMenage,
        columnTailleMenage,
        columnTypeGrosConsommateur
      ],
      where: '1=1');
  }

  Future<List<MenageEntity>> queryAllMenageEntity() async {
    Database db = await database;
    List<MenageEntity> valiny = [];
    List<Map> map = await db.query(
      tableMenage,
      columns: [
        columnIdMenage,
        columnDateMenage,
        columnDistrictMenage,
        columnAgglomerationMenage,
        columnTypeMenage,
        columnTailleMenage,
        columnTypeGrosConsommateur
      ],
      where: '1=1');
      for (var m in map) {
      valiny.add(MenageEntity.fromMap(m));
    }
    return valiny;
  }

  Future<List<Map>> queryAllMenageString() async {
    Database db = await database;
    List<Map> valiny = [];
    List<Map> map = await db.query(
      tableMenage,
      columns: [
        columnIdMenage,
        columnDateMenage,
        columnDistrictMenage,
        columnAgglomerationMenage,
        columnTypeMenage,
        columnTailleMenage,
        columnTypeGrosConsommateur
      ],
      where: '1=1');
      for (var m in map) {
      valiny.add(MenageEntity.fromMap(m).toMapString());
    }
    return valiny;
  }

  Future<List<EnergieCuissonEntity>> queryAllEnergieCuissonByMenage(int idMenage) async {
    Database db = await database;
    List<EnergieCuissonEntity> valiny = [];
    List<Map> map = await db.query(
      tableEnergieCuisson,
      columns: [
        columnIdEnergieCuisson,
        columnIdMenageEnergieCuisson,
        columnEnergieCuisson,
        columnTypeFoyerEnergieCuisson,
        columnFrequenceFoyerEnergieCuisson,
        columnPUFoyerEnergieCuisson,
        columnQteEnergieCuisson,
        columnPrixEnergieCuisson,
        columnSaisonEnergieCuisson
      ],
      where: '$columnIdMenageEnergieCuisson = ?',
      whereArgs: [idMenage]
    );
    for (var m in map) {
      valiny.add(EnergieCuissonEntity.fromMap(m));
    }
    return valiny;
  }

  Future<List<EnergieCuissonEntity>> queryAllEnergieCuisson() async {
    Database db = await database;
    List<EnergieCuissonEntity> valiny = [];
    List<Map> map = await db.query(
      tableEnergieCuisson,
      columns: [
        columnIdEnergieCuisson,
        columnIdMenageEnergieCuisson,
        columnEnergieCuisson,
        columnTypeFoyerEnergieCuisson,
        columnFrequenceFoyerEnergieCuisson,
        columnPUFoyerEnergieCuisson,
        columnQteEnergieCuisson,
        columnPrixEnergieCuisson,
        columnSaisonEnergieCuisson
      ]
    );
    for (var m in map) {
      valiny.add(EnergieCuissonEntity.fromMap(m));
    }
    return valiny;
  }

  Future<List<Map>> queryAllEnergieCuissonString() async {
    Database db = await database;
    List<Map> valiny = [];
    List<Map> map = await db.query(
      tableEnergieCuisson,
      columns: [
        columnIdEnergieCuisson,
        columnIdMenageEnergieCuisson,
        columnEnergieCuisson,
        columnTypeFoyerEnergieCuisson,
        columnFrequenceFoyerEnergieCuisson,
        columnPUFoyerEnergieCuisson,
        columnQteEnergieCuisson,
        columnPrixEnergieCuisson,
        columnSaisonEnergieCuisson
      ]
    );
    for (var m in map) {
      valiny.add(EnergieCuissonEntity.fromMap(m).toMapString());
    }
    return valiny;
  }

  Future<List<Map>> queryAllEnergieCuissonMap() async {
    Database db = await database;
    List<EnergieCuissonEntity> valiny = [];
    return await db.query(
      tableEnergieCuisson,
      columns: [
        columnIdEnergieCuisson,
        columnIdMenageEnergieCuisson,
        columnEnergieCuisson,
        columnTypeFoyerEnergieCuisson,
        columnFrequenceFoyerEnergieCuisson,
        columnPUFoyerEnergieCuisson,
        columnQteEnergieCuisson,
        columnPrixEnergieCuisson,
        columnSaisonEnergieCuisson
      ]
    );
    // for (var m in map) {
    //   valiny.add(EnergieCuissonEntity.fromMap(m));
    // }
    // return valiny;
  }


  // Barriere et produit
  Future<int> insertProduit(ProduitEntity meule) async {
    Database db = await database;
    int id = await db.insert(tableProduit, meule.toMap());
    return id;
  }

  Future<int> insertBarriere(BarriereEntity charbonnier, List<ProduitEntity> meule) async {
    Database db = await database;
    int id = await db.transaction((txn) async {
      int idBarriere = await txn.insert(tableBarriere, charbonnier.toMap());
      for (var s in meule) {
        s.idBarriere = idBarriere;
        txn.insert(tableProduit, s.toMap());
      }
      return idBarriere;
    });
    return id;
  }

  Future<int> updateBarriere(BarriereEntity charbonnier, List<ProduitEntity> meule) async {
    Database db = await database;
    int id = await db.transaction((txn) async {
      int charbonnierId = charbonnier.id;
      charbonnier.id = null;
      int idBarriere = await txn.update(tableBarriere, charbonnier.toMap(), where: '''$columnIdBarriere = ?''', whereArgs: [charbonnierId]);
      txn.delete(
        tableProduit,
        where: '''$columnIdBarriereProduit = ?''',
        whereArgs: [idBarriere]
      ).then((value) => {
          for (var s in meule) {
            s.idBarriere = idBarriere,
            txn.insert(tableProduit, s.toMap())
          }
      });
      return idBarriere;
    });
    return id;
  }

  Future<List<BarriereEntity>> queryAllBarriereEntity() async {
    Database db = await database;
    List<BarriereEntity> valiny = [];
    List<Map> map = await db.query(
      tableBarriere,
      columns: [
        columnIdBarriere,
        columnDateBarriere,
        columnDistrictBarriere,
        columnAgglomerationBarriere,
        columnAxeBarriere,
        columnLatitudeBarriere,
        columnLongitudeBarriere,
        columnLaisserPasserBarriere,
        columnTransportBarriere,
        columnDistrictProvenanceBarriere,
        columnDesignationProvenanceBarriere,
        columnDistrictArriveeBarriere,
        columnDesignationArriveeBarriere
      ],
      where: '1=1');
    for (var c in map) {
      valiny.add(BarriereEntity.fromMap(c));
    }
    return valiny;
  }

  Future<List<Map>> queryAllBarriereString() async {
    Database db = await database;
    List<Map> valiny = [];
    List<Map> map = await db.query(
      tableBarriere,
      columns: [
        columnIdBarriere,
        columnDateBarriere,
        columnDistrictBarriere,
        columnAgglomerationBarriere,
        columnAxeBarriere,
        columnLatitudeBarriere,
        columnLongitudeBarriere,
        columnLaisserPasserBarriere,
        columnTransportBarriere,
        columnDistrictProvenanceBarriere,
        columnDesignationProvenanceBarriere,
        columnDistrictArriveeBarriere,
        columnDesignationArriveeBarriere
      ],
      where: '1=1');
    for (var c in map) {
      valiny.add(BarriereEntity.fromMap(c).toMapString());
    }
    return valiny;
  }

  Future<List<Map>> queryAllBarriere() async {
    Database db = await database;
    return await db.query(
      tableBarriere,
      columns: [
        columnIdBarriere,
        columnDateBarriere,
        columnDistrictBarriere,
        columnAgglomerationBarriere,
        columnAxeBarriere,
        columnLatitudeBarriere,
        columnLongitudeBarriere,
        columnLaisserPasserBarriere,
        columnTransportBarriere,
        columnDistrictProvenanceBarriere,
        columnDesignationProvenanceBarriere,
        columnDistrictArriveeBarriere,
        columnDesignationArriveeBarriere
      ],
      where: '1=1');
  }

  Future<List<ProduitEntity>> queryAllProduitByBarriere(int idBarriere) async {
    Database db = await database;
    List<ProduitEntity> valiny = [];
    List<Map> map = await db.query(
      tableProduit,
      columns: [
        columnIdProduit,
        columnIdBarriereProduit,
        columnTypeProduit,
        columnProduit,
        columnQteProduit
      ],
      where: '$columnIdBarriereProduit = ?',
      whereArgs: [idBarriere]);
    for (var m in map) {
      valiny.add(ProduitEntity.fromMap(m));
    }
    return valiny;
  }

  Future<List<ProduitEntity>> queryAllProduit() async {
    Database db = await database;
    List<ProduitEntity> valiny = [];
    List<Map> map = await db.query(
      tableProduit,
      columns: [
        columnIdProduit,
        columnIdBarriereProduit,
        columnTypeProduit,
        columnProduit,
        columnQteProduit
      ]);
    for (var m in map) {
      valiny.add(ProduitEntity.fromMap(m));
    }
    return valiny;
  }

  Future<List<Map>> queryAllProduitString() async {
    Database db = await database;
    List<Map> valiny = [];
    List<Map> map = await db.query(
      tableProduit,
      columns: [
        columnIdProduit,
        columnIdBarriereProduit,
        columnTypeProduit,
        columnProduit,
        columnQteProduit
      ]);
    for (var m in map) {
      valiny.add(ProduitEntity.fromMap(m).toMapString());
    }
    return valiny;
  }

  // Meule
   Future<int> insertMeule(MeuleEntity meule) async {
    Database db = await database;
    int id = await db.insert(tableMeule, meule.toMap());
    return id;
  }

  Future<List<MeuleEntity>> queryAllMeule() async {
    Database db = await database;
    List<MeuleEntity> valiny = [];
    List<Map> map = await db.query(
      tableMeule,
      columns: [
        columnIdMeule,
        columnIdCharbonnierMeule,
        columnTypeMeule,
        columnMeule,
        columnZonePrelevementMeule,
        columnDomaineMeule,
        columnLongeurMeule,
        columnLargeurMeule,
        columnHauteurMeule,
        columnQteBMeule,
        columnQteCMeule
      ]);
    for (var m in map) {
      valiny.add(MeuleEntity.fromMap(m));
    }
    return valiny;
  }

  Future<List<Map>> queryAllMeuleString() async {
    Database db = await database;
    List<Map> valiny = [];
    List<Map> map = await db.query(
      tableMeule,
      columns: [
        columnIdMeule,
        columnIdCharbonnierMeule,
        columnTypeMeule,
        columnMeule,
        columnZonePrelevementMeule,
        columnDomaineMeule,
        columnLongeurMeule,
        columnLargeurMeule,
        columnHauteurMeule,
        columnQteBMeule,
        columnQteCMeule
    ]);
    print('__________________________________________');
    print('database: meule');
    print(map);
    print('__________________________________________');  
    for (var m in map) {
      Map ms = MeuleEntity.fromMap(m).toMapString();
      print(ms);
      valiny.add(ms);
    }
    return valiny;
  }

  Future<List<MeuleEntity>> queryAllMeuleByCharbonnier(int idCharbonnier) async {
    Database db = await database;
    List<MeuleEntity> valiny = [];
    List<Map> map = await db.query(
      tableMeule,
      columns: [
        columnIdMeule,
        columnIdCharbonnierMeule,
        columnTypeMeule,
        columnMeule,
        columnZonePrelevementMeule,
        columnDomaineMeule,
        columnLongeurMeule,
        columnLargeurMeule,
        columnHauteurMeule,
        columnQteBMeule,
        columnQteCMeule
      ],
      where: '$columnIdCharbonnierMeule = ?',
      whereArgs: [idCharbonnier]);
    for (var m in map) {
      valiny.add(MeuleEntity.fromMap(m));
    }
    return valiny;
  }


  // Charbonnier
  Future<int> insertCharbonnier(CharbonnierEntity charbonnier, List<MeuleEntity> meule) async {
    Database db = await database;
    int id = await db.transaction((txn) async {
      int idCharbonnier = await txn.insert(tableCharbonnier, charbonnier.toMap());
      for (var s in meule) {
        s.idCharbonnier = idCharbonnier;
        txn.insert(tableMeule, s.toMap());
      }
      return idCharbonnier;
    });
    return id;
  }

  Future<int> updateCharbonnier(CharbonnierEntity charbonnier, List<MeuleEntity> meule) async {
    Database db = await database;
    int id = await db.transaction((txn) async {
      int charbonnierId = charbonnier.id;
      charbonnier.id = null;
      int idCharbonnier = await txn.update(tableCharbonnier, charbonnier.toMap(), where: '''$columnIdCharbonnier = ?''', whereArgs: [charbonnierId]);
      txn.delete(
        tableMeule,
        where: '''$columnIdCharbonnierMeule = ?''',
        whereArgs: [idCharbonnier]
      ).then((value) => {
          for (var s in meule) {
            s.idCharbonnier = idCharbonnier,
            txn.insert(tableMeule, s.toMap())
          }
      });
      return idCharbonnier;
    });
    return id;
  }

  Future<List<CharbonnierEntity>> queryAllCharbonnierEntity() async {
    Database db = await database;
    List<CharbonnierEntity> valiny = [];
    List<Map> map = await db.query(
      tableCharbonnier,
      columns: [
        columnIdCharbonnier,
        columnDateCharbonnier,
        columnDistrictCharbonnier,
        columnAgglomerationCharbonnier,
        columnEspeceBoisCharbonnier,
        columnAutorisationCharbonnier,
        // columnQteBoisCharbonnier,
        // columnQteCharbonCharbonnier
      ],
      where: '1=1');
    for (var c in map) {
      valiny.add(CharbonnierEntity.fromMap(c));
    }
    return valiny;
  }

  Future<List<Map>> queryAllCharbonnierString() async {
    Database db = await database;
    List<Map> valiny = [];
    List<Map> map = await db.query(
      tableCharbonnier,
      columns: [
        columnIdCharbonnier,
        columnDateCharbonnier,
        columnDistrictCharbonnier,
        columnAgglomerationCharbonnier,
        columnEspeceBoisCharbonnier,
        columnAutorisationCharbonnier,
        // columnQteBoisCharbonnier,
        // columnQteCharbonCharbonnier
      ],
      where: '1=1');
    for (var c in map) {
      Map cc = CharbonnierEntity.fromMap(c).toMapString();
      print('database: Charbonnier_________________________________________');
      print(cc);
      print('_________________________________________');
      valiny.add(cc);
    }
    return valiny;
  }

  Future<List<Map>> queryAllCharbonnier() async {
    Database db = await database;
    return await db.query(
      tableCharbonnier,
      columns: [
        columnIdCharbonnier,
        columnDateCharbonnier,
        columnDistrictCharbonnier,
        columnAgglomerationCharbonnier,
        columnEspeceBoisCharbonnier,
        columnAutorisationCharbonnier,
        // columnQteBoisCharbonnier,
        // columnQteCharbonCharbonnier
      ],
      where: '1=1');
  }
  

  // Données secondaires
  Future<int> insertDonneeSecondaire(DonneeSecondaireEntity ds) async {
    Database db = await database;
    int id = await db.transaction((txn) async {
      int idDonneeSecondaire = await txn.insert(tableDS, ds.toMap());
      return idDonneeSecondaire;
    });
    return id;
  }

  Future<int> updateDonneeSecondaire(DonneeSecondaireEntity ds) async {
    Database db = await database;
    int id = await db.transaction((txn) async {
      int dsId = ds.id;
      ds.id = null;
      int idDonneeSecondaire = await txn.update(tableDS, ds.toMap(), where: '''$columnIdDS = ?''', whereArgs: [dsId]);
      return idDonneeSecondaire;
    });
    return id;
  }

  Future<List<DonneeSecondaireEntity>> queryAllDonneeSecondaireEntity() async {
    Database db = await database;
    List<DonneeSecondaireEntity> valiny = [];
    List<Map> map = await db.query(
      tableDS,
      columns: [
        columnIdDS,
        columnDistrictChoosed,
        columnAgglomerationChoosed,
        columnNbrPopulationR,
        columnNbrPopulationU,
        columnTailleMoyenneMenageR,
        columnTailleMoyenneMenageU,
        columnNbrCharbonnier,
        columnNbrGrosConsommateur,
        columnQteCB
      ],
      where: '1=1');
    for (var c in map) {
      valiny.add(DonneeSecondaireEntity.fromMap(c));
    }
    return valiny;
  }

  Future<List<Map>> queryAllDonneeSecondaireString() async {
    Database db = await database;
    List<Map> valiny = [];
    List<Map> map = await db.query(
      tableDS,
      columns: [
        columnIdDS,
        columnDistrictChoosed,
        columnAgglomerationChoosed,
        columnNbrPopulationR,
        columnNbrPopulationU,
        columnTailleMoyenneMenageR,
        columnTailleMoyenneMenageU,
        columnNbrCharbonnier,
        columnNbrGrosConsommateur,
        columnQteCB
      ],
      where: '1=1');
    for (var c in map) {
      valiny.add(DonneeSecondaireEntity.fromMap(c).toMapString());
    }
    return valiny;
  }

  Future<List<Map>> queryAllDonneeSecondaire() async {
    Database db = await database;
    return await db.query(
      tableDS,
      columns: [
        columnIdDS,
        columnDistrictChoosed,
        columnAgglomerationChoosed,
        columnNbrPopulationR,
        columnNbrPopulationU,
        columnTailleMoyenneMenageR,
        columnTailleMoyenneMenageU,
        columnNbrCharbonnier,
        columnNbrGrosConsommateur,
        columnQteCB
      ],
      where: '1=1');
  }

  // Reboisement
  Future<List<ReboisementEntity>> queryAllReboisementEntity() async {
    Database db = await database;
    List<ReboisementEntity> valiny = [];
    List<Map> map = await db.query(
      tableReboisement,
      columns: [
        columnIdReboisement,
        columnDateReboisement,
        columnDistrictReboisement,
        columnAgglomerationReboisement,
        columnCommuneReboisement,
        columnAggReboisement,
        columnTypeReboisement,
        columnProprietaireReboisement,
        columnGenreChoosedReboisement,
        columnSuperficieReboisement,
        columnPareFeuxReboisement,
        columnFertilisantReboisement,
        columnPareFeuxChoosedReboisement,
        columnCultureChoosedReboisement,
        columnEssenceChoosedReboisement,
        columnProvenanceSemenceChoosedReboisement,
        columnProductiviteChoosedReboisement,
        columnTravauxSolChoosedReboisement,
        columnAnneePlantationReboisement,
        columnDensiteReboisement,
        columnTauxRemplissageReboisement,
        columnActeurReboisement,
      ],
      where: '1=1');
    for (var c in map) {
      valiny.add(ReboisementEntity.fromMap(c));
    }
    return valiny;
  }

  Future<List<Map>> queryAllReboisementString() async {
    Database db = await database;
    List<Map> valiny = [];
    List<Map> map = await db.query(
      tableReboisement,
      columns: [
        columnIdReboisement,
        columnDateReboisement,
        columnDistrictReboisement,
        columnAgglomerationReboisement,
        columnCommuneReboisement,
        columnAggReboisement,
        columnTypeReboisement,
        columnProprietaireReboisement,
        columnGenreChoosedReboisement,
        columnSuperficieReboisement,
        columnPareFeuxReboisement,
        columnFertilisantReboisement,
        columnPareFeuxChoosedReboisement,
        columnCultureChoosedReboisement,
        columnEssenceChoosedReboisement,
        columnProvenanceSemenceChoosedReboisement,
        columnProductiviteChoosedReboisement,
        columnTravauxSolChoosedReboisement,
        columnAnneePlantationReboisement,
        columnDensiteReboisement,
        columnTauxRemplissageReboisement,
        columnActeurReboisement,
      ],
      where: '1=1');
    for (var c in map) {
      valiny.add(ReboisementEntity.fromMap(c).toMapString());
    }
    return valiny;
  }

  Future<List<Map>> queryAllReboisement() async {
    Database db = await database;
    return await db.query(
      tableReboisement,
      columns: [
        columnIdReboisement,
        columnDateReboisement,
        columnDistrictReboisement,
        columnAgglomerationReboisement,
        columnCommuneReboisement,
        columnAggReboisement,
        columnTypeReboisement,
        columnProprietaireReboisement,
        columnGenreChoosedReboisement,
        columnSuperficieReboisement,
        columnPareFeuxReboisement,
        columnFertilisantReboisement,
        columnPareFeuxChoosedReboisement,
        columnCultureChoosedReboisement,
        columnEssenceChoosedReboisement,
        columnProvenanceSemenceChoosedReboisement,
        columnProductiviteChoosedReboisement,
        columnTravauxSolChoosedReboisement,
        columnAnneePlantationReboisement,
        columnDensiteReboisement,
        columnTauxRemplissageReboisement,
        columnActeurReboisement,
      ],
      where: '1=1');
  }

  // Pepiniere
  Future<List<PepiniereEntity>> queryAllPepiniereEntity() async {
    Database db = await database;
    List<PepiniereEntity> valiny = [];
    List<Map> map = await db.query(
      tablePepiniere,
      columns: [
        columnId,
        columnDatePepiniere,
        columnDistrictPepiniere,
        columnAgglomerationPepiniere,
        columnCommunePepiniere,
        columnAggPepiniere,
        columnProprietairePepiniere,
        columnGenreChoosedPepiniere,
        columnTypePepiniere,
        columnLatPepiniere,
        columnLongPepiniere,
        columnProjetAppuiePepiniere,
        columnEspecesPepiniere,
        columnNbrPlantPepiniere,
        columnTauxPepiniere
      ],
      where: '1=1');
    for (var c in map) {
      valiny.add(PepiniereEntity.fromMap(c));
    }
    return valiny;
  }

  Future<List<Map>> queryAllPepiniereString() async {
    Database db = await database;
    List<Map> valiny = [];
    List<Map> map = await db.query(
      tablePepiniere,
      columns: [
        columnId,
        columnDatePepiniere,
        columnDistrictPepiniere,
        columnAgglomerationPepiniere,
        columnCommunePepiniere,
        columnAggPepiniere,
        columnProprietairePepiniere,
        columnGenreChoosedPepiniere,
        columnTypePepiniere,
        columnLatPepiniere,
        columnLongPepiniere,
        columnProjetAppuiePepiniere,
        columnEspecesPepiniere,
        columnNbrPlantPepiniere,
        columnTauxPepiniere
      ],
      where: '1=1');
    for (var c in map) {
      valiny.add(PepiniereEntity.fromMap(c).toMapString());
    }
    return valiny;
  }

  Future<List<Map>> queryAllPepiniere() async {
    Database db = await database;
    return await db.query(
      tablePepiniere,
      columns: [
        columnId,
        columnDatePepiniere,
        columnDistrictPepiniere,
        columnAgglomerationPepiniere,
        columnCommunePepiniere,
        columnAggPepiniere,
        columnProprietairePepiniere,
        columnGenreChoosedPepiniere,
        columnTypePepiniere,
        columnLatPepiniere,
        columnLongPepiniere,
        columnProjetAppuiePepiniere,
        columnEspecesPepiniere,
        columnNbrPlantPepiniere,
        columnTauxPepiniere
      ],
      where: '1=1');
  }

  // ForetNaturel
  Future<List<ForetNaturelEntity>> queryAllForetNaturelEntity() async {
    Database db = await database;
    List<ForetNaturelEntity> valiny = [];
    List<Map> map = await db.query(
      tableForetNaturel,
      columns: [
        columnIdForetNaturel,
        columnDateForetNaturel,
        columnDistrictForetNaturel,
        columnAgglomerationForetNaturel,
        columnCommuneForetNaturel,
        columnAggForetNaturel,
        columnSuperficieForetNaturel,
        columnPareFeuxForetNaturel,
        columnEssenceForetNaturel,
        columnActeurForetNaturel,
        columnAmenagementForetNaturel,
        columnTypeFormationForetNaturel,
        columnAuthorisationForetNaturel,
        columnSurfaceExploiteForetNaturel,
        columnVolumeExploiteForetNaturel,
      ],
      where: '1=1');
    for (var c in map) {
      valiny.add(ForetNaturelEntity.fromMap(c));
    }
    return valiny;
  }

  Future<List<Map>> queryAllForetNaturelString() async {
    Database db = await database;
    List<Map> valiny = [];
    List<Map> map = await db.query(
      tableForetNaturel,
      columns: [
        columnIdForetNaturel,
        columnDateForetNaturel,
        columnDistrictForetNaturel,
        columnAgglomerationForetNaturel,
        columnCommuneForetNaturel,
        columnAggForetNaturel,
        columnSuperficieForetNaturel,
        columnPareFeuxForetNaturel,
        columnEssenceForetNaturel,
        columnActeurForetNaturel,
        columnAmenagementForetNaturel,
        columnTypeFormationForetNaturel,
        columnAuthorisationForetNaturel,
        columnSurfaceExploiteForetNaturel,
        columnVolumeExploiteForetNaturel,
      ],
      where: '1=1');
    for (var c in map) {
      valiny.add(ForetNaturelEntity.fromMap(c).toMapString());
    }
    return valiny;
  }

  Future<List<Map>> queryAllForetNaturel() async {
    Database db = await database;
    return await db.query(
      tableForetNaturel,
      columns: [
        columnIdForetNaturel,
        columnDateForetNaturel,
        columnDistrictForetNaturel,
        columnAgglomerationForetNaturel,
        columnCommuneForetNaturel,
        columnAggForetNaturel,
        columnSuperficieForetNaturel,
        columnPareFeuxForetNaturel,
        columnEssenceForetNaturel,
        columnActeurForetNaturel,
        columnAmenagementForetNaturel,
        columnTypeFormationForetNaturel,
        columnAuthorisationForetNaturel,
        columnSurfaceExploiteForetNaturel,
        columnVolumeExploiteForetNaturel,
      ],
      where: '1=1');
  }

// Producteur foyer
  Future<List<ProducteurFEntity>> queryAllProducteurFEntity() async {
    Database db = await database;
    List<ProducteurFEntity> valiny = [];
    List<Map> map = await db.query(
        tablePepiniere,
        columns: [
          columnIdProducteurF,
          columnDateProducteurF,
          columnDistrictProducteurF,
          columnAgglomerationProducteurF,
          columnCommuneProducteurF,
          columnAggProducteurF,
          columnEnergieProducteurF,
          columnQteProducteurF,
          columnBiodigesteurProducteurF,
          columnNbrAppuieProducteurF
        ],
        where: '1=1');
    for (var c in map) {
      valiny.add(ProducteurFEntity.fromMap(c));
    }
    return valiny;
  }

  Future<List<Map>> queryAllProducteurFString() async {
    Database db = await database;
    List<Map> valiny = [];
    List<Map> map = await db.query(
        tablePepiniere,
        columns: [
          columnIdProducteurF,
          columnDateProducteurF,
          columnDistrictProducteurF,
          columnAgglomerationProducteurF,
          columnCommuneProducteurF,
          columnAggProducteurF,
          columnEnergieProducteurF,
          columnQteProducteurF,
          columnBiodigesteurProducteurF,
          columnNbrAppuieProducteurF
        ],
        where: '1=1');
    for (var c in map) {
      valiny.add(ProducteurFEntity.fromMap(c).toMapString());
    }
    return valiny;
  }

  Future<List<Map>> queryAllProducteurF() async {
    Database db = await database;
    return await db.query(
        tablePepiniere,
        columns: [
          columnIdProducteurF,
          columnDateProducteurF,
          columnDistrictProducteurF,
          columnAgglomerationProducteurF,
          columnCommuneProducteurF,
          columnAggProducteurF,
          columnEnergieProducteurF,
          columnQteProducteurF,
          columnBiodigesteurProducteurF,
          columnNbrAppuieProducteurF
        ],
        where: '1=1');
  }

  // Producteur energie
  Future<List<ProducteurFEntity>> queryAllProducteurEEntity() async {
    Database db = await database;
    List<ProducteurFEntity> valiny = [];
    List<Map> map = await db.query(
        tablePepiniere,
        columns: [
          columnIdProducteurE,
          columnDateProducteurE,
          columnDistrictProducteurE,
          columnAgglomerationProducteurE,
          columnCommuneProducteurE,
          columnAggProducteurE,
          columnEnergieProducteurE,
          columnQtePlusCuissonProducteurE
        ],
        where: '1=1');
    for (var c in map) {
      valiny.add(ProducteurFEntity.fromMap(c));
    }
    return valiny;
  }

  Future<List<Map>> queryAllProducteurEString() async {
    Database db = await database;
    List<Map> valiny = [];
    List<Map> map = await db.query(
        tablePepiniere,
        columns: [
          columnIdProducteurE,
          columnDateProducteurE,
          columnDistrictProducteurE,
          columnAgglomerationProducteurE,
          columnCommuneProducteurE,
          columnAggProducteurE,
          columnEnergieProducteurE,
          columnQtePlusCuissonProducteurE
        ],
        where: '1=1');
    for (var c in map) {
      valiny.add(ProducteurFEntity.fromMap(c).toMapString());
    }
    return valiny;
  }

  Future<List<Map>> queryAllProducteurE() async {
    Database db = await database;
    return await db.query(
        tablePepiniere,
        columns: [
          columnIdProducteurE,
          columnDateProducteurE,
          columnDistrictProducteurE,
          columnAgglomerationProducteurE,
          columnCommuneProducteurE,
          columnAggProducteurE,
          columnEnergieProducteurE,
          columnQteProducteurE,
          columnQtePlusCuissonProducteurE
        ],
        where: '1=1');
  }

  // TODO: delete(int id)
  // TODO: update(Word word)
}