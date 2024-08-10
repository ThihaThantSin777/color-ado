import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/utils/enums.dart';

class IndexBloc extends BaseBloc {
  int _cuEventsNotificationCount = 0;

  int get getCUEventsNotificationCount => _cuEventsNotificationCount;

  int _newsNotificationCount = 0;

  int get getNewsNotificationCount => _newsNotificationCount;

  UserBottomNavigationBarIndex _activeIndex = UserBottomNavigationBarIndex.kHome;

  UserBottomNavigationBarIndex get getActiveIndex => _activeIndex;

  final ColorAdoModel _colorAdoModel = ColorAdoModel();

  IndexBloc() {
    setLoadingState();
    _colorAdoModel.createGuestUser().then((_) {
      setSuccessState();
    }).catchError((error) {
      setErrorState(error.toString());
    });

    Future.delayed(const Duration(seconds: 4), () {
      _colorAdoModel.getCuEventsNotificationCountReactiveByUserID().listen((data) {
        _cuEventsNotificationCount = data;
        notifyListeners();
      });

      _colorAdoModel.getNewsNotificationCountReactiveByUserID().listen((data) {
        _newsNotificationCount = data;
        notifyListeners();
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
