import 'package:test_todo_list/features/todo/data/data_source/todo_list_data_source.dart';
import 'package:test_todo_list/features/todo/data/database/database.dart';
import 'package:test_todo_list/features/todo/data/repository/todo_repository_impl.dart';
import 'package:test_todo_list/features/todo/domain/repository/todo_repository.dart';

class AppDi {
  const AppDi({
    required this.database,
    required this.todoListDataSource,
    required this.todoRepository,
  });

  final AppDatabase database;
  final TodoListDataSource todoListDataSource;
  final TodoRepository todoRepository;

  static AppDi init() {
    final database = AppDatabase();
    final dao = TodosDao(database);
    final todoListDataSource = TodoListDataSourceImpl(dao: dao);
    final todoRepository = TodoRepositoryImpl(dataSource: todoListDataSource);
    return AppDi(
      database: database,
      todoListDataSource: todoListDataSource,
      todoRepository: todoRepository,
    );
  }
}
