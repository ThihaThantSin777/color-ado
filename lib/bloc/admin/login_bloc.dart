import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';

class LoginBloc extends BaseBloc {
  late final ColorAdoModel _colorAdoModel = ColorAdoModel();

  Future onTapLogin(String email, String password) {
    return _colorAdoModel.login(email, password);
  }
}
