import 'package:color_ado/utils/enums.dart';
import 'package:flutter/foundation.dart';

class BaseBloc extends ChangeNotifier {
  bool _dispose = false;

  LoadingState _loadingState = LoadingState.kLoading;

  LoadingState get getLoadingState => _loadingState;

  String? _errorMessage;

  String? get getErrorMessage => _errorMessage;

  void setLoadingState() {
    _loadingState = LoadingState.kLoading;
    notifyListeners();
  }

  void setSuccessState() {
    _loadingState = LoadingState.kSuccess;
    notifyListeners();
  }

  void setErrorState(String message) {
    _loadingState = LoadingState.kError;
    _errorMessage = message;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!_dispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _dispose = true;
    super.dispose();
  }
}
