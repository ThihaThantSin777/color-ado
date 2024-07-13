import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/data/vos/banner_vo/banner_vo.dart';
import 'package:color_ado/data/vos/centers_vo/centers_vo.dart';
import 'package:color_ado/data/vos/facilities_vo/facilities_vo.dart';
import 'package:color_ado/data/vos/local_and_international_relations_vo/local_and_international_relations_vo.dart';

class HomeBloc extends BaseBloc {
  List<BannerVO>? _bannerList;

  List<BannerVO>? get getBannerList => _bannerList;

  List<CentersVO>? _centersList;

  List<CentersVO>? get getCentersList => _centersList;

  List<FacilitiesVO>? _facilitiesList;

  List<FacilitiesVO>? get getFacilitiesList => _facilitiesList;

  List<LocalAndInternationalRelationsVO>? _localAndInternationalRelationsList;

  List<LocalAndInternationalRelationsVO>? get getLocalAndInternationalRelationsList => _localAndInternationalRelationsList;

  final ColorAdoModel _colorAdoModel = ColorAdoModel();

  HomeBloc() {
    _colorAdoModel.getBanners().listen((bannerList) {
      if (bannerList.isEmpty) {
        _bannerList = [];
      } else {
        _bannerList = bannerList.take(4).toList();
      }
      notifyListeners();
    });

    _colorAdoModel.getFacilities().listen((facilitiesList) {
      if (facilitiesList.isEmpty) {
        _facilitiesList = [];
      } else {
        _facilitiesList = facilitiesList.take(4).toList();
      }
      notifyListeners();
    });

    _colorAdoModel.getCenters().listen((centersList) {
      if (centersList.isEmpty) {
        _centersList = [];
      } else {
        _centersList = centersList.take(4).toList();
      }
      notifyListeners();
    });

    _colorAdoModel.getLocalAndInternationalRelations().listen((localAndInternationalRelationsList) {
      if (localAndInternationalRelationsList.isEmpty) {
        _localAndInternationalRelationsList = [];
      } else {
        _localAndInternationalRelationsList = localAndInternationalRelationsList.take(4).toList();
      }
      notifyListeners();
    });
  }
}
