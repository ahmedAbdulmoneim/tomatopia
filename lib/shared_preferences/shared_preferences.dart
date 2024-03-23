import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    await init(); // Initialize sharedPreferences if it's null

    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    } else if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    }
    return await sharedPreferences!.setDouble(key, value);
  }

  static dynamic getData({
    required String key,
  }) async {
    await init();
    return sharedPreferences!.get(key) ?? ''; // Return an empty string if value is null or key not found
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    await init();
    return  sharedPreferences!.remove(key);
  }
}
