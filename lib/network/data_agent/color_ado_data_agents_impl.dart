import 'dart:io';

import 'package:color_ado/data/vos/admin/admin_vo.dart';
import 'package:color_ado/data/vos/banner_vo/banner_vo.dart';
import 'package:color_ado/data/vos/centers_vo/centers_vo.dart';
import 'package:color_ado/data/vos/cu_events_vo/cu_events_vo.dart';
import 'package:color_ado/data/vos/facilities_vo/facilities_vo.dart';
import 'package:color_ado/data/vos/local_and_international_relations_vo/local_and_international_relations_vo.dart';
import 'package:color_ado/data/vos/news_vo/news_vo.dart';
import 'package:color_ado/data/vos/notification_vo/notification_vo.dart';
import 'package:color_ado/data/vos/setting_vo/setting_vo.dart';
import 'package:color_ado/data/vos/user_vo/user_vo.dart';
import 'package:color_ado/database/share_preferences_dao.dart';
import 'package:color_ado/network/data_agent/color_ado_data_agents.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:color_ado/service/fcm_service.dart';
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
  Future createAdmin(AdminVO user, String password) async {
    await auth.createUserWithEmailAndPassword(email: user.email, password: password);
    return databaseRef.child(kAdminPath).child(user.id.toString()).set(user.toJson());
  }

  @override
  Future logout() => auth.signOut();

  @override
  Future<List<AdminVO>> getRegisterAdminList() async {
    final rawData = await databaseRef.child(kAdminPath).get();
    final rawMap = rawData.value as Map<Object?, Object?>;

    return rawMap.values.toList().map((element) {
      Map<Object?, Object?> originalData = element as Map<Object?, Object?>;

      Map<String, dynamic> convertedMap = originalData.map((key, value) {
        return MapEntry(key.toString(), value);
      });
      return AdminVO.fromJson(convertedMap);
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
  Future login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future setCUEventsNotificationCount(int count, {int? uID, String? fcmToken}) async {
    final token = fcmToken ?? FcmService.fcmToken;
    final id = uID ?? (await SharePreferencesDAO.getUserID() ?? 0);
    final newsNotificationCount = await getNewsNotificationCountByUserID();
    UserVO userVO = UserVO(id, token, count, newsNotificationCount, DateTime.now().toString());

    return databaseRef.child(kUserPath).child(id.toString()).set(userVO.toJson());
  }

  @override
  Future setNewsNotificationCount(int count, {int? uID, String? fcmToken}) async {
    final token = fcmToken ?? FcmService.fcmToken;
    final id = uID ?? (await SharePreferencesDAO.getUserID() ?? 0);
    final cuEventsNotificationCount = await getCUEventsNotificationCountByUserID();
    UserVO userVO = UserVO(id, token, cuEventsNotificationCount, count, DateTime.now().toString());
    return databaseRef.child(kUserPath).child(id.toString()).set(userVO.toJson());
  }

  @override
  Future createGuestUser() async {
    final fcmToken = FcmService.fcmToken;
    final uID = await SharePreferencesDAO.getUserID();
    if (uID != null) {
      final cuEventsNotificationCount = await getCUEventsNotificationCountByUserID();
      final newsNotificationCount = await getNewsNotificationCountByUserID();
      UserVO userVO = UserVO(uID, fcmToken, cuEventsNotificationCount, newsNotificationCount, DateTime.now().toString());
      return databaseRef.child(kUserPath).child(uID.toString()).set(userVO.toJson());
    }
    final id = DateTime.now().microsecondsSinceEpoch;
    await SharePreferencesDAO.saveUserID(id);
    UserVO userVO = UserVO(id, fcmToken, 0, 0, DateTime.now().toString());
    return databaseRef.child(kUserPath).child(id.toString()).set(userVO.toJson());
  }

  @override
  Future<List<String>> getTokenList() async {
    final rawData = await databaseRef.child(kUserPath).get();
    final rawMap = rawData.value as Map<Object?, Object?>;

    final userDataList = rawMap.values.toList().map((element) {
      Map<Object?, Object?> originalData = element as Map<Object?, Object?>;

      Map<String, dynamic> convertedMap = originalData.map((key, value) {
        return MapEntry(key.toString(), value);
      });
      return UserVO.fromJson(convertedMap);
    }).toList();
    return userDataList.map((element) => element.fcmToken).toList();
  }

  @override
  Future<int> getCUEventsNotificationCountByUserID() async {
    final id = await SharePreferencesDAO.getUserID();
    final rawData = await databaseRef.child(kUserPath).child(id.toString()).get();
    final rawMap = rawData.value as Map<Object?, Object?>;

    Map<String, dynamic> convertedMap = rawMap.map((key, value) {
      return MapEntry(key.toString(), value);
    });
    return UserVO.fromJson(convertedMap).cuEventNotificationCount;
  }

  @override
  Future<int> getNewsNotificationCountByUserID() async {
    final id = await SharePreferencesDAO.getUserID();
    final rawData = await databaseRef.child(kUserPath).child(id.toString()).get();
    final rawMap = rawData.value as Map<Object?, Object?>;

    Map<String, dynamic> convertedMap = rawMap.map((key, value) {
      return MapEntry(key.toString(), value);
    });
    return UserVO.fromJson(convertedMap).newsNotificationCount;
  }

  @override
  Future deleteExpireFCMTokenUser() async {
    final rawData = await databaseRef.child(kUserPath).get();
    final rawMap = rawData.value as Map<Object?, Object?>;

    final userDataList = rawMap.values.toList().map((element) {
      Map<Object?, Object?> originalData = element as Map<Object?, Object?>;

      Map<String, dynamic> convertedMap = originalData.map((key, value) {
        return MapEntry(key.toString(), value);
      });
      return UserVO.fromJson(convertedMap);
    }).toList();

    final needToDeleteUserList = userDataList
        .where((element) {
          final timeStamp = DateTime.parse(element.timeStamp);
          return _isWithinSixMonths(timeStamp);
        })
        .map((element) => element)
        .toList();

    if (needToDeleteUserList.isNotEmpty) {
      for (var data in needToDeleteUserList) {
        await databaseRef.child(data.id.toString()).remove();
      }
    }

    return Future.value();
  }

  bool _isWithinSixMonths(DateTime date) {
    DateTime currentDate = DateTime.now();
    DateTime sixMonthsAgo = DateTime(
      currentDate.year,
      currentDate.month - 6,
      currentDate.day,
    );

    DateTime sixMonthsAhead = DateTime(
      currentDate.year,
      currentDate.month + 6,
      currentDate.day,
    );

    return !(date.isAfter(sixMonthsAgo) && date.isBefore(sixMonthsAhead));
  }

  @override
  Stream<int> getCuEventsNotificationCountReactiveByUserID(int id) {
    return databaseRef.child(kUserPath).child(id.toString()).onValue.map((event) {
      final rawData = event.snapshot.value as Map<Object?, Object?>;
      final convertedMap = rawData.map((key, value) {
        return MapEntry(key.toString(), value);
      });
      final user = UserVO.fromJson(Map<String, dynamic>.from(convertedMap));
      return user.cuEventNotificationCount;
    });
  }

  @override
  Stream<int> getNewsNotificationCountReactiveByUserID(int id) {
    return databaseRef.child(kUserPath).child(id.toString()).onValue.map((event) {
      final rawData = event.snapshot.value as Map<Object?, Object?>;
      final convertedMap = rawData.map((key, value) {
        return MapEntry(key.toString(), value);
      });
      final user = UserVO.fromJson(Map<String, dynamic>.from(convertedMap));
      return user.newsNotificationCount;
    });
  }

  @override
  Future<List<UserVO>> getGuestUserList() async {
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
  Future saveNotificationData(NotificationVO notification) {
    return databaseRef.child(kNotificationPath).child(notification.notificationID.toString()).set(notification.toJson());
  }

  @override
  Future readNotification(int userID, int notificationID) async {
    final rawData = await databaseRef.child(kNotificationPath).child(notificationID.toString()).get();
    final rawMap = rawData.value as Map<Object?, Object?>;

    Map<String, dynamic> convertedMap = rawMap.map((key, value) {
      return MapEntry(key.toString(), value);
    });

    NotificationVO? notificationByID = NotificationVO.fromJson(convertedMap);

    List<int> readNotificationList = notificationByID.readNotificationUserList ?? [];
    readNotificationList.add(userID);
    notificationByID.readNotificationUserList = readNotificationList;
    return databaseRef.child(kNotificationPath).child(notificationByID.notificationID.toString()).set(notificationByID.toJson());
  }

  @override
  Stream<List<NotificationVO>> getNotificationList() {
    return databaseRef.child(kNotificationPath).onValue.map((event) {
      return event.snapshot.children.map<NotificationVO>((snapshot) {
        return NotificationVO.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
      }).toList();
    });
  }
}
