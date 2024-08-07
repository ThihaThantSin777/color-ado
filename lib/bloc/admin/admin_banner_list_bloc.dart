import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/data/vos/banner_vo/banner_vo.dart';
import 'package:color_ado/resources/strings.dart';

class AdminBannerListBloc extends BaseBloc {
  List<BannerVO>? _bannerList;

  List<BannerVO>? get getBannerList => _bannerList;

  final ColorAdoModel _colorAdoModel = ColorAdoModel();

  AdminBannerListBloc() {
    _colorAdoModel.getBanners().listen((bannerList) {
      if (bannerList.isEmpty) {
        _bannerList = [];
      } else {
        _bannerList = bannerList.reversed.toList();
      }
      notifyListeners();
    });
  }

  Future onTapDeleteBanner(int bannerID) => _colorAdoModel.deleteData(bannerID, kBannerPath);
}
