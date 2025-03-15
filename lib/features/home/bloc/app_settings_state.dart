part of 'app_settings_bloc.dart';

class AppSettingsState extends Equatable {
  const AppSettingsState([this.mode]);

  final AppThemeEntity? mode;

  @override
  List<Object?> get props => [mode];
}
