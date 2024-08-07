import 'dart:io';

import 'package:color_ado/data/vos/banner_vo/banner_vo.dart';
import 'package:color_ado/data/vos/centers_vo/centers_vo.dart';
import 'package:color_ado/data/vos/cu_events_vo/cu_events_vo.dart';
import 'package:color_ado/data/vos/facilities_vo/facilities_vo.dart';
import 'package:color_ado/data/vos/local_and_international_relations_vo/local_and_international_relations_vo.dart';
import 'package:color_ado/data/vos/news_vo/news_vo.dart';
import 'package:color_ado/data/vos/setting_vo/setting_vo.dart';
import 'package:color_ado/data/vos/user_vo/user_vo.dart';

abstract class ColorAdoDataAgent {
  Stream<List<BannerVO>> getBanners();

  Future addEditData(int id, Map<String, dynamic> json, String path);

  Future deleteData(int id, String path);

  Stream<List<SettingVO>> getSettingList();

  Stream<List<CentersVO>> getCenters();

  Stream<List<FacilitiesVO>> getFacilities();

  Stream<List<LocalAndInternationalRelationsVO>> getLocalAndInternationalRelations();

  Stream<List<NewsVO>> getNews();

  Stream<List<CUEventsVO>> getCUEvents();

  Future createUser(UserVO user);

  Future logout();

  Future<List<UserVO>> getRegisterUserList();

  Future<String> uploadFileToFireStore(
    File image,
    String path,
  );

  Future login(String email, String password);
}
