import 'package:edu_world/data/local/local_data_access.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePrefHelper implements LocalDataAccess {
  final SharedPreferences sharedPref;

  SharePrefHelper(this.sharedPref);
}
