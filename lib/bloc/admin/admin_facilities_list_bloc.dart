import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/data/vos/facilities_vo/facilities_vo.dart';
import 'package:color_ado/resources/strings.dart';

class AdminFacilitiesListBloc extends BaseBloc {
  List<FacilitiesVO>? _facilitiesList;

  List<FacilitiesVO>? get getFacilitiesList => _facilitiesList;

  final ColorAdoModel _colorAdoModel = ColorAdoModel();

  AdminFacilitiesListBloc() {
    _colorAdoModel.getFacilities().listen((facilitiesList) {
      if (facilitiesList.isEmpty) {
        _facilitiesList = [];
      } else {
        _facilitiesList = facilitiesList.reversed.toList();
      }
      notifyListeners();
    });
  }

  Future onTapDeleteFacilities(int id) => _colorAdoModel.deleteData(id, kFacilitiesPath);
}
