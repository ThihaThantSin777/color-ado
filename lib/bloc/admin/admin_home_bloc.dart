import 'package:color_ado/bloc/base_bloc.dart';
import 'package:color_ado/data/model/color_ado_model.dart';

class AdminHomeBloc extends BaseBloc {
  String? _userName;

  String? get getUserName => _userName;

  late final ColorAdoModel _colorAdoModel = ColorAdoModel();

  AdminHomeBloc({required String email}) {
    setLoadingState();
    _colorAdoModel.getRegisterUserNameByEmail(email).then((value) {
      _userName = value;
      setSuccessState();
    }).catchError((error) {
      setErrorState(error.toString());
    });
  }

  Future onTapLogout() {
    return _colorAdoModel.logout();
  }
}
