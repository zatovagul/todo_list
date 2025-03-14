import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_todo_list/features/todo/domain/entity/todo_entity.dart';
import 'package:test_todo_list/features/todo/domain/repository/todo_repository.dart';

part 'todo_list_event.dart';

part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc({required this.repository}) : super(const TodoListState$Idle()) {
    on<TodoListEvent>((event, emit) {
      return switch (event) {
        TodoListEvent$Fetch() => _fetch(event, emit),
        TodoListEvent$UpdateList() => _updateList(event, emit),
      };
    });
    add(const TodoListEvent$Fetch(force: true));
  }

  final TodoRepository repository;

  Future<void> _fetch(
    TodoListEvent$Fetch event,
    Emitter<TodoListState> emit,
  ) async {}

  Future<void> _updateList(
    TodoListEvent$UpdateList event,
    Emitter<TodoListState> emit,
  ) async {}
}
