part of 'todo_list_bloc.dart';

@immutable
sealed class TodoListState {
  const TodoListState({this.todos = const [], this.hasMore = false});

  final List<TodoEntity> todos;
  final bool hasMore;
}

class TodoListState$Idle extends TodoListState {
  const TodoListState$Idle({super.todos, super.hasMore});
}

class TodoListState$Loading extends TodoListState {
  const TodoListState$Loading({super.todos, super.hasMore});
}
