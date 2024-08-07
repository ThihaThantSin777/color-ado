import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/data/vos/local_and_international_relations_vo/local_and_international_relations_vo.dart';
import 'package:color_ado/resources/strings.dart';

class AdminLocalAndInternationalRelationsListBloc extends BaseBloc {
  List<LocalAndInternationalRelationsVO>? _localAndInternationalRelationList;

  List<LocalAndInternationalRelationsVO>? get getLocalAndInternationalRelationList => _localAndInternationalRelationList;

  final ColorAdoModel _colorAdoModel = ColorAdoModel();

  AdminLocalAndInternationalRelationsListBloc() {
    _colorAdoModel.getLocalAndInternationalRelations().listen((list) {
      if (list.isEmpty) {
        _localAndInternationalRelationList = [];
      } else {
        _localAndInternationalRelationList = list.reversed.toList();
      }
      notifyListeners();
    });
  }

  Future onTapDeleteLocalAndInternationalRelations(int id) => _colorAdoModel.deleteData(
        id,
        kLocalAndInternationalRelationsPath,
      );
}
