import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesService {
  Future<bool> add(String key, String value);
  Future<bool> remove(String key);
  Future<String?> getString(String key);
}

class SharedPreferencesServiceImpl implements SharedPreferencesService {
  SharedPreferences? _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> add(String key, String value) async {
    await init();
    return await _sharedPreferences!.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    await init();
    return _sharedPreferences!.getString(key);
  }

  @override
  Future<bool> remove(String key) async {
    await init();
    return await _sharedPreferences!.remove(key);
  }
}
