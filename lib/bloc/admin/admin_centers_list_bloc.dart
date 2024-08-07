import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/data/vos/centers_vo/centers_vo.dart';
import 'package:color_ado/resources/strings.dart';

class AdminCentersListBloc extends BaseBloc {
  List<CentersVO>? _centerList;

  List<CentersVO>? get getCentersList => _centerList;

  final ColorAdoModel _colorAdoModel = ColorAdoModel();

  AdminCentersListBloc() {
    _colorAdoModel.getCenters().listen((centersList) {
      if (centersList.isEmpty) {
        _centerList = [];
      } else {
        _centerList = centersList.reversed.toList();
      }
      notifyListeners();
    });
  }

  Future onTapDeleteCenters(int id) => _colorAdoModel.deleteData(id, kCentersPath);
}
