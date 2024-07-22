import 'package:color_ado/data/vos/banner_vo/banner_vo.dart';
import 'package:color_ado/data/vos/centers_vo/centers_vo.dart';
import 'package:color_ado/data/vos/facilities_vo/facilities_vo.dart';
import 'package:color_ado/data/vos/local_and_international_relations_vo/local_and_international_relations_vo.dart';
import 'package:color_ado/data/vos/news_vo/news_vo.dart';
import 'package:color_ado/network/data_agent/color_ado_data_agents.dart';
import 'package:color_ado/network/data_agent/color_ado_data_agents_impl.dart';

class ColorAdoModel {
  ColorAdoModel._();

  static final ColorAdoModel _singleton = ColorAdoModel._();

  factory ColorAdoModel() => _singleton;

  final ColorAdoDataAgent _adoDataAgent = ColorAdoDataAgentImpl();

  Stream<List<BannerVO>> getBanners() => _adoDataAgent.getBanners();

  Stream<List<CentersVO>> getCenters() => _adoDataAgent.getCenters();

  Stream<List<FacilitiesVO>> getFacilities() => _adoDataAgent.getFacilities();

  Stream<List<LocalAndInternationalRelationsVO>> getLocalAndInternationalRelations() => _adoDataAgent.getLocalAndInternationalRelations();

  Stream<List<NewsVO>> getNews() => _adoDataAgent.getNews();
}
