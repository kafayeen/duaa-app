import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? share;
  static Future<SharedPreferences> init() async {
    return share = await SharedPreferences.getInstance();
  }

  static Future<dynamic> putData(String key, value) async {
    if (value is bool) {
      return await share!.setBool(key, value);
    } else if (value is String) {
      return await share!.setString(key, value);
    } else if (value is int) {
      return await share!.setInt(key, value);
    } else {
      return await share!.setDouble(key, value);
    }
  }

  static getData(String key) {
    return share!.get(key);
  }

  static Future<bool> deleteData(String key) async {
    return await share!.remove(key);
  }
}
