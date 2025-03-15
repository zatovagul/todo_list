part of 'todo_save_bloc.dart';

@immutable
sealed class TodoSaveEvent {
  const TodoSaveEvent();
}

final class TodoSaveEvent$Init extends TodoSaveEvent {
  const TodoSaveEvent$Init({this.todo});

  final TodoEntity? todo;
}

final class TodoSaveEvent$Save extends TodoSaveEvent {
  const TodoSaveEvent$Save(this.todo);

  final TodoEntity todo;
}

