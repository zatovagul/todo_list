import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AppSettingsStorage {
  Future<void> save(String mode);

  String? getMode();
}

class AppSettingsStorageImpl implements AppSettingsStorage {
  const AppSettingsStorageImpl(this.prefs);

  final SharedPreferences prefs;
  static const _key = 'app_theme';

  @override
  Future<void> save(String mode) async {
    await prefs.setString(_key, mode);
  }

  @override
  String? getMode() {
    return prefs.getString(_key);
  }
}
