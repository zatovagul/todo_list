part of 'todo_list_bloc.dart';

@immutable
sealed class TodoListEvent {
  const TodoListEvent();
}

final class TodoListEvent$Fetch extends TodoListEvent {
  const TodoListEvent$Fetch({this.page, this.force = false});

  final int? page;
  final bool force;
}

final class TodoListEvent$UpdateList extends TodoListEvent {
  const TodoListEvent$UpdateList();
}
