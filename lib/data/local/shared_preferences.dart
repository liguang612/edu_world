import 'package:edu_world/data/constants.dart';
import 'package:edu_world/data/local/local_data_access.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePrefHelper implements LocalDataAccess {
  final SharedPreferences sharedPref;

  SharePrefHelper(this.sharedPref);

  // Clear
  @override
  void clearAccessToken() => sharedPref.remove(SharedPreferenceKeys.accessToken);

  @override
  void clearUserId() => sharedPref.remove(SharedPreferenceKeys.userId);

  // Getter
  @override
  String? getAccessToken() => sharedPref.getString(SharedPreferenceKeys.accessToken);

  @override
  String? getUserId() => sharedPref.getString(SharedPreferenceKeys.userId);

  // Setter
  @override
  void setAccessToken(String accessToken) => sharedPref.setString(SharedPreferenceKeys.accessToken, accessToken);

  @override
  void setUserId(String userId) => sharedPref.setString(SharedPreferenceKeys.userId, userId);
}
