import 'package:flutter/foundation.dart';

class BaseBloc extends ChangeNotifier {
  bool _dispose = false;

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
