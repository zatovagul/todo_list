import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_todo_list/common/di/app_di.dart';
import 'package:test_todo_list/common/gen/localization/l10n.dart';
import 'package:test_todo_list/common/navigation/app_router.dart';
import 'package:test_todo_list/features/home/bloc/app_settings_bloc.dart';
import 'package:test_todo_list/features/home/domain/entities/app_theme_entity.dart';
import 'package:test_todo_list/features/home/ui/view/app_settings_scope.dart';
import 'package:test_todo_list/features/todo/ui/widgets/todo_list_scope.dart';

class MainApp extends StatefulWidget {
  const MainApp({required this.appDi, super.key});

  final AppDi appDi;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => widget.appDi,
      child: AppSettingsScope(
        child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
          builder: (context, state) {
            return MaterialApp.router(
              routerConfig: router.config(),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              themeMode: switch (state.mode) {
                null => ThemeMode.system,
                AppThemeEntity.light => ThemeMode.light,
                AppThemeEntity.dark => ThemeMode.dark,
                AppThemeEntity.system => ThemeMode.system,
              },
              theme: ThemeData.light(useMaterial3: true),
              darkTheme: ThemeData.dark(useMaterial3: true),
              builder: (context, child) {
                return TodoListScope(child: child ?? const SizedBox());
              },
            );
          },
        ),
      ),
    );
  }
}
