import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/data/vos/cu_events_vo/cu_events_vo.dart';
import 'package:color_ado/resources/strings.dart';

class AdminCUEventsListBloc extends BaseBloc {
  List<CUEventsVO>? _cuEventsList;

  List<CUEventsVO>? get getCUEventList => _cuEventsList;

  final ColorAdoModel _colorAdoModel = ColorAdoModel();

  AdminCUEventsListBloc() {
    _colorAdoModel.getCUEvents().listen((cuEventsList) {
      if (cuEventsList.isEmpty) {
        _cuEventsList = [];
      } else {
        _cuEventsList = cuEventsList.reversed.toList();
      }
      notifyListeners();
    });
  }

  Future onTapDeleteCUEvents(int id) => _colorAdoModel.deleteData(id, kCUEventsPath);
}
