import 'dart:io';

import 'package:color_ado/data/vos/banner_vo/banner_vo.dart';
import 'package:color_ado/data/vos/centers_vo/centers_vo.dart';
import 'package:color_ado/data/vos/cu_events_vo/cu_events_vo.dart';
import 'package:color_ado/data/vos/facilities_vo/facilities_vo.dart';
import 'package:color_ado/data/vos/local_and_international_relations_vo/local_and_international_relations_vo.dart';
import 'package:color_ado/data/vos/news_vo/news_vo.dart';
import 'package:color_ado/data/vos/setting_vo/setting_vo.dart';
import 'package:color_ado/data/vos/user_vo/user_vo.dart';
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

  Stream<List<CUEventsVO>> getCUEvents() => _adoDataAgent.getCUEvents();

  Future createUser(UserVO user) => _adoDataAgent.createUser(user);

  Future<List<UserVO>> getRegisterUserList() => _adoDataAgent.getRegisterUserList();

  Future<String> getRegisterUserNameByEmail(String email) async {
    final userList = await _adoDataAgent.getRegisterUserList();
    final userName = userList.where((element) => element.email == email).firstOrNull;
    if (userName == null) {
      return Future.error('User Name Cannot find');
    }
    return userName.userName;
  }

  Future logout() => _adoDataAgent.logout();

  Future addEditData(int id, String path, Map<String, dynamic> json) => _adoDataAgent.addEditData(id, json, path);

  Future deleteData(
    int id,
    String path,
  ) =>
      _adoDataAgent.deleteData(id, path);

  Future<String> uploadFileToFireStore(
    File image,
    String path,
  ) =>
      _adoDataAgent.uploadFileToFireStore(
        image,
        path,
      );

  Stream<List<SettingVO>> getSettingList() => _adoDataAgent.getSettingList();

  Future login(String email, String password) => _adoDataAgent.login(email, password);

  Future createToken(String token) => _adoDataAgent.createToken(token);

  Future<List<String>> getTokenList() => _adoDataAgent.getTokenList();
}
