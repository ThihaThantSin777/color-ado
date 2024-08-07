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
import 'package:color_ado/resources/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ColorAdoDataAgentImpl extends ColorAdoDataAgent {
  ColorAdoDataAgentImpl._();

  static final ColorAdoDataAgentImpl _singleton = ColorAdoDataAgentImpl._();

  factory ColorAdoDataAgentImpl() => _singleton;
  final databaseRef = FirebaseDatabase.instance.ref();
  final auth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instanceFor(bucket: 'gs://color-ado-334c0.appspot.com');

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

  @override
  Stream<List<CUEventsVO>> getCUEvents() {
    return databaseRef.child(kCUEventsPath).onValue.map((event) {
      return event.snapshot.children.map<CUEventsVO>((snapshot) {
        return CUEventsVO.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
      }).toList();
    });
  }

  @override
  Future createUser(UserVO user) async {
    await auth.createUserWithEmailAndPassword(email: user.email, password: user.password);
    return databaseRef.child(kUserPath).child(user.id.toString()).set(user.toJson());
  }

  @override
  Future logout() => auth.signOut();

  @override
  Future<List<UserVO>> getRegisterUserList() async {
    final rawData = await databaseRef.child(kUserPath).get();
    final rawMap = rawData.value as Map<Object?, Object?>;

    return rawMap.values.toList().map((element) {
      Map<Object?, Object?> originalData = element as Map<Object?, Object?>;

      Map<String, dynamic> convertedMap = originalData.map((key, value) {
        return MapEntry(key.toString(), value);
      });
      return UserVO.fromJson(convertedMap);
    }).toList();
  }

  @override
  Future addEditData(int id, Map<String, dynamic> json, String path) {
    return databaseRef.child(path).child(id.toString()).set(json);
  }

  @override
  Future deleteData(int id, String path) {
    return databaseRef.child(path).child(id.toString()).remove();
  }

  @override
  Future<String> uploadFileToFireStore(File image, String path) {
    int id = DateTime.now().millisecondsSinceEpoch;
    return firebaseStorage.ref(path).child(id.toString()).putFile(image).then((takeSnapShot) {
      return takeSnapShot.ref.getDownloadURL().then((value) {
        return value;
      });
    });
  }

  @override
  Stream<List<SettingVO>> getSettingList() {
    return databaseRef.child(kSettingPath).onValue.map((event) {
      return event.snapshot.children.map<SettingVO>((snapshot) {
        return SettingVO.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
      }).toList();
    });
  }

  @override
  Future login(String email, String password) => auth.signInWithEmailAndPassword(email: email, password: password);
}
