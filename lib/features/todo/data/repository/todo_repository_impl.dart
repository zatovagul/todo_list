import 'package:drift/drift.dart';
import 'package:test_todo_list/features/todo/data/data_source/todo_list_data_source.dart';
import 'package:test_todo_list/features/todo/data/database/database.dart';
import 'package:test_todo_list/features/todo/domain/entity/ordering_mode_entity.dart';
import 'package:test_todo_list/features/todo/domain/entity/todo_entity.dart';
import 'package:test_todo_list/features/todo/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({required this.dataSource});

  final TodoListDataSource dataSource;

  @override
  Future<int> todosCount() => dataSource.todosCount();

  @override
  Future<List<TodoEntity>> getList({
    int page = 0,
    int? pageSize,
    OrderingModeEntity? title,
    OrderingModeEntity? date,
  }) async {
    final items = await dataSource.getList(
      page: page,
      title: title?.toData(),
      date: date?.toData(),
    );
    return items.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> addTodo(TodoEntity todo) async {
    await dataSource.addTodo(
      TodosCompanion(
        title: Value(todo.title),
        description: Value(todo.description),
        createdAt: Value(todo.createdAt),
        imagePaths: Value(todo.imageUrl),
      ),
    );
  }

  @override
  Future<void> deleteTodo(int id) async {
    await dataSource.deleteTodo(id);
  }

  @override
  Future<void> updateTodo(TodoEntity todo) async {
    await dataSource.updateTodo(
      Todo(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        createdAt: todo.createdAt,
        imagePaths: todo.imageUrl,
      ),
    );
  }
}

extension on OrderingModeEntity {
  OrderingMode toData() {
    return switch (this) {
      OrderingModeEntity.asc => OrderingMode.asc,
      OrderingModeEntity.desc => OrderingMode.desc,
    };
  }
}

extension on Todo {
  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      title: title,
      description: description,
      createdAt: createdAt,
      imageUrl: imagePaths,
    );
  }
}
