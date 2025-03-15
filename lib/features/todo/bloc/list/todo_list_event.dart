part of 'todo_list_bloc.dart';

@immutable
sealed class TodoListEvent {
  const TodoListEvent();
}

final class TodoListEvent$Fetch extends TodoListEvent {
  const TodoListEvent$Fetch({this.page, this.force = false, this.filter});

  final int? page;
  final bool force;
  final TodoFilterEntity? filter;
}

final class TodoListEvent$UpdateList extends TodoListEvent {
  const TodoListEvent$UpdateList();
}

final class TodoListEvent$Delete extends TodoListEvent {
  const TodoListEvent$Delete(this.entity);

  final TodoEntity entity;
}

final class TodoListEvent$CancelDelete extends TodoListEvent {
  const TodoListEvent$CancelDelete(this.entity);

  final TodoEntity entity;
}
