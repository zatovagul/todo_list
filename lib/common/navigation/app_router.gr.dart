// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsPage();
    },
  );
}

/// generated route for
/// [TodoListPage]
class TodoListRoute extends PageRouteInfo<void> {
  const TodoListRoute({List<PageRouteInfo>? children})
    : super(TodoListRoute.name, initialChildren: children);

  static const String name = 'TodoListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TodoListPage();
    },
  );
}

/// generated route for
/// [TodoSavePage]
class TodoSaveRoute extends PageRouteInfo<TodoSaveRouteArgs> {
  TodoSaveRoute({Key? key, TodoEntity? todo, List<PageRouteInfo>? children})
    : super(
        TodoSaveRoute.name,
        args: TodoSaveRouteArgs(key: key, todo: todo),
        initialChildren: children,
      );

  static const String name = 'TodoSaveRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TodoSaveRouteArgs>(
        orElse: () => const TodoSaveRouteArgs(),
      );
      return WrappedRoute(child: TodoSavePage(key: args.key, todo: args.todo));
    },
  );
}

class TodoSaveRouteArgs {
  const TodoSaveRouteArgs({this.key, this.todo});

  final Key? key;

  final TodoEntity? todo;

  @override
  String toString() {
    return 'TodoSaveRouteArgs{key: $key, todo: $todo}';
  }
}
