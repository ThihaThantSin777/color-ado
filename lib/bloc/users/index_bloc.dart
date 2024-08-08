import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/service/fcm_service.dart';
import 'package:color_ado/utils/enums.dart';

class IndexBloc extends BaseBloc {
  UserBottomNavigationBarIndex _activeIndex = UserBottomNavigationBarIndex.kHome;

  UserBottomNavigationBarIndex get getActiveIndex => _activeIndex;

  IndexBloc() {
    ColorAdoModel().createToken(FcmService.fcmToken);
  }

  set setActiveIndex(UserBottomNavigationBarIndex index) {
    _activeIndex = index;
    notifyListeners();
  }
}
