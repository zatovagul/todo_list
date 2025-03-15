import 'package:test_todo_list/features/home/data/data_source/app_serttings_data_source.dart';
import 'package:test_todo_list/features/home/domain/entities/app_theme_entity.dart';
import 'package:test_todo_list/features/home/domain/repository/app_settings_repository.dart';

final class AppSettingsRepositoryImpl implements AppSettingsRepository {
  AppSettingsRepositoryImpl(this.dataSource);

  final AppSettingsDataSource dataSource;

  @override
  AppThemeEntity getMode() {
    final mode = dataSource.getMode();
    return switch (mode) {
      'light' => AppThemeEntity.light,
      'dark' => AppThemeEntity.dark,
      _ => AppThemeEntity.system,
    };
  }

  @override
  Future<void> save(AppThemeEntity mode) {
    return dataSource.save(mode.name);
  }
}
