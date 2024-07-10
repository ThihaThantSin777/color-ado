import 'package:color_ado/data/vos/banner_vo/banner_vo.dart';
import 'package:color_ado/data/vos/centers_vo/centers_vo.dart';
import 'package:color_ado/data/vos/facilities_vo/facilities_vo.dart';
import 'package:color_ado/data/vos/local_and_international_relations_vo/local_and_international_relations_vo.dart';

abstract class ColorAdoDataAgent {
  Stream<List<BannerVO>> getBanners();

  Stream<List<CentersVO>> getCenters();

  Stream<List<FacilitiesVO>> getFacilities();

  Stream<List<LocalAndInternationalRelationsVO>> getLocalAndInternationalRelations();
}
