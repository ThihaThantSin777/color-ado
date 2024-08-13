import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/database/share_preferences_dao.dart';
import 'package:color_ado/utils/enums.dart';

class IndexBloc extends BaseBloc {
  int _cuEventsNotificationCount = 0;

  int get getCUEventsNotificationCount => _cuEventsNotificationCount;

  int _newsNotificationCount = 0;

  int get getNewsNotificationCount => _newsNotificationCount;

  UserBottomNavigationBarIndex _activeIndex = UserBottomNavigationBarIndex.kHome;

  UserBottomNavigationBarIndex get getActiveIndex => _activeIndex;

  int? _totalNotificationCount;

  int? get getTotalNotificationCount => _totalNotificationCount;
  final ColorAdoModel _colorAdoModel = ColorAdoModel();

  IndexBloc() {
    setLoadingState();
    _colorAdoModel.createGuestUser().then((_) {
      setSuccessState();
    }).catchError((error) {
      setErrorState(error.toString());
    });

    Future.delayed(const Duration(seconds: 4), () {
      SharePreferencesDAO.getUserID().then((id) {
        _colorAdoModel.getCuEventsNotificationCountReactiveByUserID(id ?? 0).listen((data) {
          _cuEventsNotificationCount = data;
          _totalNotificationCount = _cuEventsNotificationCount + _newsNotificationCount;
          notifyListeners();
        });

        _colorAdoModel.getNewsNotificationCountReactiveByUserID(id ?? 0).listen((data) {
          _newsNotificationCount = data;
          _totalNotificationCount = _newsNotificationCount + _cuEventsNotificationCount;
          notifyListeners();
        });
      });
    });
  }

  void setActiveIndex(UserBottomNavigationBarIndex index) {
    _activeIndex = index;
    notifyListeners();
  }

  void setCUEventsNotificationRead() {
    _colorAdoModel.setCUEventsNotificationCount(0);
  }

  void setNewsNotificationRead() {
    _colorAdoModel.setNewsNotificationCount(0);
  }
}
