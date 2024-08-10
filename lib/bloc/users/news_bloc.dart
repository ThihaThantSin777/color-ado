import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/data/vos/news_vo/news_vo.dart';

class NewsBloc extends BaseBloc {
  List<NewsVO>? _news;

  List<NewsVO>? get getNews => _news;

  final ColorAdoModel _colorAdoModel = ColorAdoModel();

  NewsBloc() {
    _colorAdoModel.getNews().listen((news) {
      if (news.isEmpty) {
        _news = [];
      } else {
        _news = news.reversed.toList();
      }
      notifyListeners();
    });
  }
}
