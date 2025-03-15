import 'package:test_todo_list/features/home/data/service/app_settings_storage.dart';

abstract interface class AppSettingsDataSource {
  Future<void> save(String mode);

  String getMode();
}

final class AppSettingsDataSourceImpl implements AppSettingsDataSource {
  const AppSettingsDataSourceImpl(this.storage);

  final AppSettingsStorage storage;

  @override
  String getMode() {
    return storage.getMode() ?? 'system';
  }

  @override
  Future<void> save(String mode) {
    return storage.save(mode);
  }
}
