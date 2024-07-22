import 'package:color_ado/data/vos/banner_vo/banner_vo.dart';
import 'package:color_ado/data/vos/centers_vo/centers_vo.dart';
import 'package:color_ado/data/vos/facilities_vo/facilities_vo.dart';
import 'package:color_ado/data/vos/local_and_international_relations_vo/local_and_international_relations_vo.dart';
import 'package:color_ado/data/vos/news_vo/news_vo.dart';
import 'package:color_ado/network/data_agent/color_ado_data_agents.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:firebase_database/firebase_database.dart';

class ColorAdoDataAgentImpl extends ColorAdoDataAgent {
  ColorAdoDataAgentImpl._();

  static final ColorAdoDataAgentImpl _singleton = ColorAdoDataAgentImpl._();

  factory ColorAdoDataAgentImpl() => _singleton;
  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Stream<List<BannerVO>> getBanners() {
    return databaseRef.child(kBannerPath).onValue.map((event) {
      return event.snapshot.children.map<BannerVO>((snapshot) {
        return BannerVO.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
      }).toList();
    });
  }

  @override
  Stream<List<CentersVO>> getCenters() {
    return databaseRef.child(kCentersPath).onValue.map((event) {
      return event.snapshot.children.map<CentersVO>((snapshot) {
        return CentersVO.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
      }).toList();
    });
  }

  @override
  Stream<List<FacilitiesVO>> getFacilities() {
    return databaseRef.child(kFacilitiesPath).onValue.map((event) {
      return event.snapshot.children.map<FacilitiesVO>((snapshot) {
        return FacilitiesVO.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
      }).toList();
    });
  }

  @override
  Stream<List<LocalAndInternationalRelationsVO>> getLocalAndInternationalRelations() {
    return databaseRef.child(kLocalAndInternationalRelationsPath).onValue.map((event) {
      return event.snapshot.children.map<LocalAndInternationalRelationsVO>((snapshot) {
        return LocalAndInternationalRelationsVO.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
      }).toList();
    });
  }

  @override
  Stream<List<NewsVO>> getNews() {
    return databaseRef.child(kNewsPath).onValue.map((event) {
      return event.snapshot.children.map<NewsVO>((snapshot) {
        return NewsVO.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
      }).toList();
    });
  }
}
