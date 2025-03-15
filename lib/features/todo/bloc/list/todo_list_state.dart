part of 'todo_list_bloc.dart';

@immutable
sealed class TodoListState {
  const TodoListState({
    this.todos = const [],
    this.hasMore = false,
    this.filter = const TodoFilterEntity(),
  });

  final List<TodoEntity> todos;
  final bool hasMore;
  final TodoFilterEntity filter;

  bool get isLoading => this is TodoListState$Loading;
}

class TodoListState$Idle extends TodoListState {
  const TodoListState$Idle({super.todos, super.hasMore, super.filter});
}

class TodoListState$Loading extends TodoListState {
  const TodoListState$Loading({super.todos, super.hasMore, super.filter});
}

final class TodoListState$Deleting extends TodoListState {
  const TodoListState$Deleting(
    this.entity, {
    super.todos,
    super.hasMore,
    super.filter,
  });

  final TodoEntity entity;
}
