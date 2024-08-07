import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/data/vos/user_vo/user_vo.dart';

class CreateUserBloc extends BaseBloc {
  late final ColorAdoModel _colorAdoModel = ColorAdoModel();

  Future onTapRegister(String userName, String email, String password) {
    final user = UserVO(DateTime.now().microsecondsSinceEpoch, userName, email, password);
    return _colorAdoModel.createUser(user);
  }
}
