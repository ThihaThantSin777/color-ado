import 'package:color_ado/bloc/base_bloc.dart';

class IndexBloc extends BaseBloc {
  int _activeIndex = 0;

  int get getActiveIndex => _activeIndex;

  set setActiveIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }
}
