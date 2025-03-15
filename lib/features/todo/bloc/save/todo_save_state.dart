part of 'todo_save_bloc.dart';

@immutable
sealed class TodoSaveState {
  const TodoSaveState({this.todo});

  final TodoEntity? todo;

  bool get isLoading => this is TodoSaveState$Loading;
}

final class TodoSaveState$Initial extends TodoSaveState {
  const TodoSaveState$Initial({super.todo});
}

final class TodoSaveState$Loading extends TodoSaveState {
  const TodoSaveState$Loading({super.todo});
}

final class TodoSaveState$Success extends TodoSaveState {
  const TodoSaveState$Success({super.todo});
}
