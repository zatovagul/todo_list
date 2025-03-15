import 'package:test_todo_list/features/home/domain/entities/app_theme_entity.dart';

abstract interface class AppSettingsRepository {
  Future<void> save(AppThemeEntity mode);

  AppThemeEntity getMode();
}
