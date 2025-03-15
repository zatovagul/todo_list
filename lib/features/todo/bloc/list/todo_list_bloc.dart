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
        TodoListEvent$Delete() => _delete(event, emit),
        TodoListEvent$CancelDelete() => _cancelDelete(event, emit),
      };
    });
    add(const TodoListEvent$Fetch(force: true));
  }

  final TodoRepository repository;

  final List<int> _deletingTodos = [];

  @override
  Future<void> close() async {
    if(_deletingTodos.isNotEmpty){
      for(final i in _deletingTodos) {
        await repository.deleteTodo(i);
      }
    }
    return super.close();
  }

  Future<void> _fetch(
    TodoListEvent$Fetch event,
    Emitter<TodoListState> emit,
  ) async {
    emit(TodoListState$Loading(todos: state.todos, hasMore: state.hasMore));
    var page = event.page;
    if (event.force) page = 0;
    if (!event.force && page == null) {
      final count = state.todos.length;
      page = count ~/ 20;
    }

    final list = event.force ? <TodoEntity>[] : [...state.todos];
    final todos = await repository.getList(page: page ?? 0);
    list.addAll(todos);
    final count = await repository.todosCount();
    final hasMore = count > list.length;
    emit(TodoListState$Idle(todos: list, hasMore: hasMore));
  }

  Future<void> _updateList(
    TodoListEvent$UpdateList event,
    Emitter<TodoListState> emit,
  ) async {
    emit(TodoListState$Loading(todos: state.todos, hasMore: state.hasMore));
    final todos = await repository.getList(pageSize: state.todos.length + 1);
    final count = await repository.todosCount();
    final hasMore = count > todos.length;
    emit(TodoListState$Idle(todos: todos, hasMore: hasMore));
  }

  Future<void> _delete(
    TodoListEvent$Delete event,
    Emitter<TodoListState> emit,
  ) async {
    _deletingTodos.add(event.entity.id);
    final list = state.todos.toList()..remove(event.entity);
    emit(
      TodoListState$Deleting(event.entity, todos: list, hasMore: state.hasMore),
    );
    await Future<void>.delayed(const Duration(seconds: 5));
    if (!_deletingTodos.contains(event.entity.id)) {
      return;
    }

    await repository.deleteTodo(event.entity.id);
    add(const TodoListEvent$UpdateList());
  }

  Future<void> _cancelDelete(
    TodoListEvent$CancelDelete event,
    Emitter<TodoListState> emit,
  ) async {
    _deletingTodos.remove(event.entity.id);
    add(const TodoListEvent$UpdateList());
  }
}
