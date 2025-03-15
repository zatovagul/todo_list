import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_todo_list/features/todo/domain/entity/todo_entity.dart';
import 'package:test_todo_list/features/todo/domain/repository/todo_repository.dart';

part 'todo_save_event.dart';

part 'todo_save_state.dart';

class TodoSaveBloc extends Bloc<TodoSaveEvent, TodoSaveState> {
  TodoSaveBloc(this.repository) : super(const TodoSaveState$Initial()) {
    on<TodoSaveEvent>((event, emit) {
      return switch (event) {
        TodoSaveEvent$Init() => _init(event, emit),
        TodoSaveEvent$Save() => _update(event, emit),
      };
    });
  }

  final TodoRepository repository;

  Future<void> _init(
    TodoSaveEvent$Init event,
    Emitter<TodoSaveState> emit,
  ) async {
    emit(TodoSaveState$Initial(todo: event.todo));
  }

  Future<void> _update(
    TodoSaveEvent$Save event,
    Emitter<TodoSaveState> emit,
  ) async {
    emit(TodoSaveState$Loading(todo: state.todo));
    final todo = state.todo;
    if (todo == null) {
      await repository.addTodo(event.todo);
    } else {
      await repository.updateTodo(event.todo);
    }
    emit(TodoSaveState$Success(todo: event.todo));
  }
}
