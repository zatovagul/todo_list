import 'package:test_todo_list/features/todo/domain/entity/ordering_mode_entity.dart';
import 'package:test_todo_list/features/todo/domain/entity/todo_entity.dart';

abstract interface class TodoRepository {
  Future<int> todosCount();

  Future<List<TodoEntity>> getList({
    int page = 0,
    int? pageSize,
    OrderingModeEntity? title,
    OrderingModeEntity? date,
  });

  Future<void> addTodo(TodoEntity todo);

  Future<void> updateTodo(TodoEntity todo);

  Future<void> deleteTodo(int id);
}
