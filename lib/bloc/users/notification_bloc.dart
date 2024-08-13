import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/data/vos/notification_vo/notification_vo.dart';
import 'package:color_ado/database/share_preferences_dao.dart';

class NotificationBloc extends BaseBloc {
  int? _userID;

  int? get getUserID => _userID;

  List<NotificationVO>? _notificationList;

  List<NotificationVO>? get getNotificationList => _notificationList;

  final ColorAdoModel _colorAdoModel = ColorAdoModel();

  NotificationBloc() {
    SharePreferencesDAO.getUserID().then((id) {
      _userID = id;
    });
    _colorAdoModel.getNotificationList().listen((notificationList) {
      if (notificationList.isEmpty) {
        _notificationList = [];
      } else {
        _notificationList = notificationList.reversed.toList();
      }
      notifyListeners();
    });
  }

  Future readNotificationList(int notificationID) async {
    final userID = (await SharePreferencesDAO.getUserID()) ?? 0;
    return _colorAdoModel.readNotification(userID, notificationID);
  }
}
