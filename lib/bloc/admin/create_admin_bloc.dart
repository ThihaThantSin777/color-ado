import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';
import 'package:color_ado/data/vos/admin/admin_vo.dart';

class CreateAdminBloc extends BaseBloc {
  late final ColorAdoModel _colorAdoModel = ColorAdoModel();

  Future onTapRegister(String userName, String email, String password) {
    final user = AdminVO(DateTime.now().microsecondsSinceEpoch, userName, email);
    return _colorAdoModel.createAdmin(user, password);
  }
}
