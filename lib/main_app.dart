import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_todo_list/common/di/app_di.dart';
import 'package:test_todo_list/common/gen/localization/l10n.dart';
import 'package:test_todo_list/common/navigation/app_router.dart';
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
    return MaterialApp.router(
      routerConfig: router.config(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      themeMode: ThemeMode.light,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      builder: (context, child) {
        return RepositoryProvider(
          create: (context) => widget.appDi,
          child: TodoListScope(child: child ?? const SizedBox()),
        );
      },
    );
  }
}
