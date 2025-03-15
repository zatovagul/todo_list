part of 'app_settings_bloc.dart';

@immutable
sealed class AppSettingsEvent {
  const AppSettingsEvent();
}

final class AppSettingsEvent$Init extends AppSettingsEvent {
  const AppSettingsEvent$Init();
}

final class AppSettingsEvent$SetTheme extends AppSettingsEvent {
  const AppSettingsEvent$SetTheme(this.mode);

  final AppThemeEntity mode;
}
