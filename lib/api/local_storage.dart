import 'package:shared_preferences/shared_preferences.dart'; // rememeber to import shared_preferences: ^0.5.4+8

abstract class Storage {
  Future<String?> getItem(String itemKey);

  Future<void> setItem(String key, String value);
}

class DefaultStorage implements Storage {
  SharedPreferences? prefs;
  DefaultStorage._privateConstructor();

  DefaultStorage() {
    init();
  }
  void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static final DefaultStorage _instance = DefaultStorage._privateConstructor();
  static DefaultStorage get instance => _instance;
  @override
  Future<String?> getItem(String itemKey) async {
    return prefs?.getString(itemKey);
  }

  @override
  Future<void> setItem(String key, String value) async {
    prefs?.setString(key, value);
  }
}
