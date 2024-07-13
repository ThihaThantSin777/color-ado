import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/utils/enums.dart';

class IndexBloc extends BaseBloc {
  UserBottomNavigationBarIndex _activeIndex = UserBottomNavigationBarIndex.kHome;

  UserBottomNavigationBarIndex get getActiveIndex => _activeIndex;

  set setActiveIndex(UserBottomNavigationBarIndex index) {
    _activeIndex = index;
    notifyListeners();
  }
}
