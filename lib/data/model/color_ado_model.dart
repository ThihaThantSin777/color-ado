import 'dart:io';

import 'package:color_ado/data/vos/admin/admin_vo.dart';
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

  Future createAdmin(AdminVO user, String password) => _adoDataAgent.createAdmin(
        user,
        password,
      );

  Future<String> getRegisterAdminNameByEmail(String email) async {
    final userList = await _adoDataAgent.getRegisterAdminList();
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

  Future createGuestUser() => _adoDataAgent.createGuestUser();

  Future<List<String>> getTokenList() => _adoDataAgent.getTokenList();

  Future deleteExpireFCMTokenUser() => _adoDataAgent.deleteExpireFCMTokenUser();

  Future<int> getCUEventsNotificationCountByUserID() => _adoDataAgent.getCUEventsNotificationCountByUserID();

  Future<int> getNewsNotificationCountByUserID() => _adoDataAgent.getNewsNotificationCountByUserID();

  Stream<int> getCuEventsNotificationCountReactiveByUserID() => _adoDataAgent.getCuEventsNotificationCountReactiveByUserID();

  Stream<int> getNewsNotificationCountReactiveByUserID() => _adoDataAgent.getNewsNotificationCountReactiveByUserID();

  Future setCUEventsNotificationCount(int count, {int? uID, String? fcmToken}) => _adoDataAgent.setCUEventsNotificationCount(
        count,
        uID: uID,
        fcmToken: fcmToken,
      );

  Future setNewsNotificationCount(int count, {int? uID, String? fcmToken}) => _adoDataAgent.setNewsNotificationCount(
        count,
        uID: uID,
        fcmToken: fcmToken,
      );

  Future<List<UserVO>> getGuestUserList() => _adoDataAgent.getGuestUserList();
}
