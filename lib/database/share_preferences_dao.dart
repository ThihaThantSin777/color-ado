import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesDAO {
  static const _kUserID = 'kUserID';

  static Future saveUserID(int userID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kUserID, userID);
  }

  static Future<int?> getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kUserID);
  }
}
