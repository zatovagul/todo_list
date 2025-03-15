import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_todo_list/features/home/domain/entities/app_theme_entity.dart';
import 'package:test_todo_list/features/home/domain/repository/app_settings_repository.dart';

part 'app_settings_event.dart';

part 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc(this.repository) : super(const AppSettingsState()) {
    on<AppSettingsEvent>((event, emit) {
      return switch (event) {
        AppSettingsEvent$Init() => _init(event, emit),
        AppSettingsEvent$SetTheme() => _setTheme(event, emit),
      };
    });
    add(const AppSettingsEvent$Init());
  }

  final AppSettingsRepository repository;

  Future<void> _init(
    AppSettingsEvent$Init event,
    Emitter<AppSettingsState> emit,
  ) async {
    final mode = repository.getMode();
    emit(AppSettingsState(mode));
  }

  Future<void> _setTheme(
    AppSettingsEvent$SetTheme event,
    Emitter<AppSettingsState> emit,
  ) async {
    await repository.save(event.mode);
    emit(AppSettingsState(event.mode));
  }
}
