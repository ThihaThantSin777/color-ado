import 'dart:io';

import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/data/vos/banner_vo/banner_vo.dart';
import 'package:color_ado/data/vos/centers_vo/centers_vo.dart';
import 'package:color_ado/data/vos/cu_events_vo/cu_events_vo.dart';
import 'package:color_ado/data/vos/facilities_vo/facilities_vo.dart';
import 'package:color_ado/data/vos/local_and_international_relations_vo/local_and_international_relations_vo.dart';
import 'package:color_ado/data/vos/news_vo/news_vo.dart';
import 'package:color_ado/data/vos/setting_vo/setting_vo.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:color_ado/utils/string_extensions.dart';

class CreateEditBloc extends BaseBloc {
  String? _userSelectImage;

  String? get getUserSelectImage => _userSelectImage;

  String? _title;

  String? get getTitle => _title;

  String? _description;

  String? get getDescription => _description;

  String _path = '';

  String? _pdfName;

  String? get getPDFName => _pdfName;

  String? _pdfURL;

  String? get getPDFUrl => _pdfURL;

  bool _btnDisable = true;

  bool get isBtnDisable => _btnDisable;

  late final ColorAdoModel _colorAdoModel = ColorAdoModel();

  CreateEditBloc(
      {String? userSelectImage, String? userTitle, String? userDescription, String? pdfName, String? pdfURL, required String path}) {
    _path = path;
    if (userSelectImage?.isNotEmpty ?? false) {
      setUserSelectImage(userSelectImage ?? '');
    }

    if (userTitle?.isNotEmpty ?? false) {
      setTitle(userTitle ?? '');
    }

    if (userDescription?.isNotEmpty ?? false) {
      setDescription(userDescription ?? '');
    }

    if (pdfName?.isEmpty ?? false) {
      setPDFName(pdfName ?? '');
    }
    if (pdfURL?.isEmpty ?? false) {
      setPDFUrl(pdfURL ?? '');
    }
  }

  void setPDFName(String pdfName) {
    _pdfName = pdfName;
    _validBTNCase();
  }

  void clearPDFURL() {
    _pdfURL = null;
    _validBTNCase();
  }

  void setPDFUrl(String filePath) {
    _pdfURL = filePath;
    notifyListeners();
    _validBTNCase();
  }

  void setTitle(String title) {
    _title = title;
    _validBTNCase();
  }

  void setDescription(String description) {
    _description = description;
    _validBTNCase();
  }

  void setClearUserSelectImage() {
    _userSelectImage = null;
    notifyListeners();
    _validBTNCase();
  }

  void setUserSelectImage(String image) {
    _userSelectImage = image;
    notifyListeners();
    _validBTNCase();
  }

  void _validBTNCase() {
    if (_path == kBannerPath) {
      _btnDisable = (_userSelectImage ?? '').isEmpty;
      notifyListeners();
    }

    if (_path == kCUEventsPath) {
      _btnDisable = (_title ?? '').isEmpty || (_description ?? '').isEmpty;
      notifyListeners();
    }

    if (_path == kNewsPath) {
      _btnDisable = (_title ?? '').isEmpty || (_description ?? '').isEmpty || (_userSelectImage ?? '').isEmpty;
      notifyListeners();
    }

    if (_path == kFacilitiesPath || _path == kLocalAndInternationalRelationsPath || _path == kCentersPath) {
      if ((_pdfName ?? '').isNotEmpty || (_pdfURL ?? '').isNotEmpty) {
        _btnDisable = (_userSelectImage ?? '').isEmpty ||
            (_title ?? '').isEmpty ||
            (_description ?? '').isEmpty ||
            (_pdfURL ?? '').isEmpty ||
            (_pdfName ?? '').isEmpty;
      } else {
        _btnDisable = (_userSelectImage ?? '').isEmpty || (_title ?? '').isEmpty || (_description ?? '').isEmpty;
      }
      notifyListeners();
    }

    if (_path == kSettingPath) {
      _btnDisable = (_title ?? '').isEmpty || (_description ?? '').isEmpty;
      notifyListeners();
    }
  }

  Future onTapSave(int id) async {
    if (_pdfURL?.isNotEmpty ?? false) {
      _pdfURL = await _colorAdoModel.uploadFileToFireStore(
        File(
          _pdfURL ?? '',
        ),
        kPDFPath,
      );
    }
    if (_userSelectImage?.isNotEmpty ?? false) {
      if ((_userSelectImage ?? '').isFileImage) {
        _userSelectImage = await _colorAdoModel.uploadFileToFireStore(
          File(
            _userSelectImage ?? '',
          ),
          _path,
        );
      }
    }

    if (_path == kBannerPath) {
      BannerVO bannerVO = BannerVO(id: id, url: _userSelectImage ?? '');
      return _colorAdoModel.addEditData(bannerVO.id, kBannerPath, bannerVO.toJson());
    }

    if (_path == kCentersPath) {
      CentersVO centersVO = CentersVO(
        id: id,
        title: _title ?? '',
        description: _description ?? '',
        url: _userSelectImage ?? '',
        pdfName: _pdfName ?? '',
        pdfURL: _pdfURL ?? '',
      );
      return _colorAdoModel.addEditData(centersVO.id, kCentersPath, centersVO.toJson());
    }

    if (_path == kCUEventsPath) {
      CUEventsVO cuEventsVO = CUEventsVO(id, _title ?? '', _description ?? '', DateTime.now().toString());
      return _colorAdoModel.addEditData(cuEventsVO.id, kCUEventsPath, cuEventsVO.toJson());
    }

    if (_path == kFacilitiesPath) {
      FacilitiesVO facilitiesVO = FacilitiesVO(
          id: id,
          title: _title ?? '',
          description: _description ?? '',
          url: _userSelectImage ?? '',
          pdfName: _pdfName ?? '',
          pdfURL: _pdfURL ?? '');
      return _colorAdoModel.addEditData(facilitiesVO.id, kFacilitiesPath, facilitiesVO.toJson());
    }

    if (_path == kLocalAndInternationalRelationsPath) {
      LocalAndInternationalRelationsVO localAndInternationalRelationsVO = LocalAndInternationalRelationsVO(
        id: id,
        title: _title ?? '',
        description: _description ?? '',
        url: _userSelectImage ?? '',
        pdfName: _pdfName ?? '',
        pdfURL: _pdfURL ?? '',
      );
      return _colorAdoModel.addEditData(
          localAndInternationalRelationsVO.id, kLocalAndInternationalRelationsPath, localAndInternationalRelationsVO.toJson());
    }

    if (_path == kNewsPath) {
      NewsVO newsVO = NewsVO(id, _title ?? '', _description ?? '', DateTime.now().toString(), _userSelectImage ?? '');
      return _colorAdoModel.addEditData(newsVO.id, kNewsPath, newsVO.toJson());
    }

    if (_path == kSettingPath) {
      SettingVO settingVO = SettingVO(id, _title ?? '', _description ?? '');
      return _colorAdoModel.addEditData(settingVO.id, kSettingPath, settingVO.toJson());
    }

    return Future.value();
  }
}
