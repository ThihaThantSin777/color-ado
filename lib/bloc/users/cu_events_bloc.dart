import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/data/vos/cu_events_vo/cu_events_vo.dart';
import 'package:color_ado/utils/string_extensions.dart';

class CUEventsBloc extends BaseBloc {
  List<CUEventsVO>? _storeAllCUEvents;
  List<CUEventsVO>? _cuEvents;

  List<CUEventsVO>? get getCUEvents => _cuEvents;

  int? _cuEventsCountByDate;

  int? get getCUEventsCountByDate => _cuEventsCountByDate;

  final ColorAdoModel _colorAdoModel = ColorAdoModel();

  CUEventsBloc() {
    _colorAdoModel.getCUEvents().listen((cuEvents) {
      if (cuEvents.isEmpty) {
        _cuEvents = [];
        _storeAllCUEvents = [];
        _cuEventsCountByDate = 0;
      } else {
        _storeAllCUEvents = cuEvents;
        final currentDateTime = DateTime.now().toString().getYearMonthDay;
        _cuEvents = _storeAllCUEvents?.where((data) => data.createdAt.getYearMonthDay == currentDateTime).toList();
        _cuEventsCountByDate = _cuEvents?.length;
      }
      notifyListeners();
    });
  }

  void onTapDateSelect(DateTime selectDateTime) {
    _cuEvents = _storeAllCUEvents?.where((data) => data.createdAt.getYearMonthDay == selectDateTime.toString().getYearMonthDay).toList();
    _cuEventsCountByDate = _cuEvents?.length;
    notifyListeners();
  }
}
