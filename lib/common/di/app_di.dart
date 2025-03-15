import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_todo_list/features/home/data/data_source/app_serttings_data_source.dart';
import 'package:test_todo_list/features/home/data/repository/app_settings_repository_impl.dart';
import 'package:test_todo_list/features/home/data/service/app_settings_storage.dart';
import 'package:test_todo_list/features/home/domain/repository/app_settings_repository.dart';
import 'package:test_todo_list/features/todo/data/data_source/todo_list_data_source.dart';
import 'package:test_todo_list/features/todo/data/database/database.dart';
import 'package:test_todo_list/features/todo/data/repository/todo_repository_impl.dart';
import 'package:test_todo_list/features/todo/domain/repository/todo_repository.dart';

class AppDi {
  const AppDi({
    required this.database,
    required this.todoListDataSource,
    required this.todoRepository,
    required this.prefs,
    required this.appSettingsStorage,
    required this.appSettingsDataSource,
    required this.appSettingsRepository,
  });

  final AppDatabase database;
  final TodoListDataSource todoListDataSource;
  final TodoRepository todoRepository;
  final SharedPreferences prefs;
  final AppSettingsStorage appSettingsStorage;
  final AppSettingsDataSource appSettingsDataSource;
  final AppSettingsRepository appSettingsRepository;

  static Future<AppDi> init() async {
    final database = AppDatabase();
    final dao = TodosDao(database);
    final todoListDataSource = TodoListDataSourceImpl(dao: dao);
    final todoRepository = TodoRepositoryImpl(dataSource: todoListDataSource);

    final prefs = await SharedPreferences.getInstance();

    final appSettingsStorage = AppSettingsStorageImpl(prefs);
    final appSettingsDataSource = AppSettingsDataSourceImpl(appSettingsStorage);

    final appSettingsRepository = AppSettingsRepositoryImpl(
      appSettingsDataSource,
    );
    return AppDi(
      database: database,
      todoListDataSource: todoListDataSource,
      todoRepository: todoRepository,
      prefs: prefs,
      appSettingsStorage: appSettingsStorage,
      appSettingsDataSource: appSettingsDataSource,
      appSettingsRepository: appSettingsRepository,
    );
  }
}
