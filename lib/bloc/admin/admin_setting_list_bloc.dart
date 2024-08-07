import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/data/vos/setting_vo/setting_vo.dart';
import 'package:color_ado/resources/strings.dart';

class AdminSettingListBloc extends BaseBloc {
  List<SettingVO>? _settingList;

  List<SettingVO>? get getSettingList => _settingList;

  final ColorAdoModel _colorAdoModel = ColorAdoModel();

  AdminSettingListBloc() {
    _colorAdoModel.getSettingList().listen((settingList) {
      if (settingList.isEmpty) {
        _settingList = [];
      } else {
        _settingList = settingList.reversed.toList();
      }
      notifyListeners();
    });
  }

  Future onTapDeleteSetting(int id) => _colorAdoModel.deleteData(id, kBannerPath);
}
