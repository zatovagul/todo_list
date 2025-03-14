import 'package:drift/drift.dart';
import 'package:test_todo_list/features/todo/data/database/database.dart';

abstract interface class TodoListDataSource {
  Future<List<Todo>> getList({
    int page = 0,
    int? pageSize,
    OrderingMode? title,
    OrderingMode? date,
  });

  Future<void> addTodo(TodosCompanion todo);

  Future<void> updateTodo(Todo todo);

  Future<void> deleteTodo(int id);
}

class TodoListDataSourceImpl implements TodoListDataSource {
  const TodoListDataSourceImpl({required this.dao});

  final TodosDao dao;

  @override
  Future<List<Todo>> getList({
    int page = 0,
    int? pageSize,
    OrderingMode? title,
    OrderingMode? date,
  }) {
    return dao.selectList(
      page: page,
      title: title,
      date: date,
      pageSize: pageSize ?? 20,
    );
  }

  @override
  Future<void> addTodo(TodosCompanion todo) async {
    await dao.insertTodo(todo);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await dao.updateTodo(todo);
  }

  @override
  Future<void> deleteTodo(int id) async {
    await dao.deleteTodo(id);
  }
}
