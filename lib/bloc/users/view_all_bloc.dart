import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/data/vos/banner_vo/banner_vo.dart';
import 'package:color_ado/data/vos/centers_vo/centers_vo.dart';
import 'package:color_ado/data/vos/facilities_vo/facilities_vo.dart';
import 'package:color_ado/data/vos/local_and_international_relations_vo/local_and_international_relations_vo.dart';
import 'package:color_ado/resources/strings.dart';

class ViewAllBloc extends BaseBloc {
  List<BannerVO>? _bannerList;

  List<BannerVO>? get getBannerList => _bannerList;

  List<CentersVO>? _centersList;

  List<CentersVO>? get getCentersList => _centersList;

  List<FacilitiesVO>? _facilitiesList;

  List<FacilitiesVO>? get getFacilitiesList => _facilitiesList;

  List<LocalAndInternationalRelationsVO>? _localAndInternationalRelationsList;

  List<LocalAndInternationalRelationsVO>? get getLocalAndInternationalRelationsList => _localAndInternationalRelationsList;

  final ColorAdoModel _colorAdoModel = ColorAdoModel();

  ViewAllBloc({
    required String path,
  }) {
    if (path == kFacilitiesPath) {
      _colorAdoModel.getFacilities().listen((facilitiesList) {
        if (facilitiesList.isEmpty) {
          _facilitiesList = [];
        } else {
          _facilitiesList = facilitiesList.reversed.toList();
        }
        notifyListeners();
      });
    }

    if (path == kCentersPath) {
      _colorAdoModel.getCenters().listen((centersList) {
        if (centersList.isEmpty) {
          _centersList = [];
        } else {
          _centersList = centersList.reversed.toList();
        }
        notifyListeners();
      });
    }

    if (path == kLocalAndInternationalRelationsPath) {
      _colorAdoModel.getLocalAndInternationalRelations().listen((localAndInternationalRelationsList) {
        if (localAndInternationalRelationsList.isEmpty) {
          _localAndInternationalRelationsList = [];
        } else {
          _localAndInternationalRelationsList = localAndInternationalRelationsList.reversed.toList();
        }
        notifyListeners();
      });
    }
  }
}
