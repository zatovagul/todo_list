import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:test_todo_list/features/home/ui/pages/home_page.dart';
import 'package:test_todo_list/features/home/ui/pages/settings_page.dart';
import 'package:test_todo_list/features/todo/domain/entity/todo_entity.dart';
import 'package:test_todo_list/features/todo/ui/pages/todo_list_page.dart';
import 'package:test_todo_list/features/todo/ui/pages/todo_save_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      initial: true,
      children: [
        AutoRoute(page: TodoListRoute.page, initial: true),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
    AutoRoute(page: TodoSaveRoute.page),
  ];
}
