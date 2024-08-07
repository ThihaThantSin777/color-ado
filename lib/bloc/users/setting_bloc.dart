import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/data/vos/setting_vo/setting_vo.dart';

class SettingBloc extends BaseBloc {
  List<SettingVO>? _settingList;

  List<SettingVO>? get getSettingList => _settingList;

  final ColorAdoModel _colorAdoModel = ColorAdoModel();

  SettingBloc() {
    _colorAdoModel.getSettingList().listen((settingList) {
      if (settingList.isEmpty) {
        _settingList = [];
      } else {
        _settingList = settingList.reversed.toList();
      }
      notifyListeners();
    });
  }
}
