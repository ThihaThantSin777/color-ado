import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/data/vos/news_vo/news_vo.dart';
import 'package:color_ado/resources/strings.dart';

class AdminNewsListBloc extends BaseBloc {
  List<NewsVO>? _newsList;

  List<NewsVO>? get getNewsList => _newsList;

  final ColorAdoModel _colorAdoModel = ColorAdoModel();

  AdminNewsListBloc() {
    _colorAdoModel.getNews().listen((newsList) {
      if (newsList.isEmpty) {
        _newsList = [];
      } else {
        _newsList = newsList.reversed.toList();
      }
      notifyListeners();
    });
  }

  Future onTapDeleteNews(int id) => _colorAdoModel.deleteData(id, kNewsPath);
}
