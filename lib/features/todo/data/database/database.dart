import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DataClassName('Todo')
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get description => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get imagePaths => text().nullable()();
}

@DriftAccessor(tables: [Todos])
class TodosDao extends DatabaseAccessor<AppDatabase> with _$TodosDaoMixin {
  TodosDao(super.db);

  Future<List<Todo>> selectList({
    int page = 0,
    int pageSize = 20,
    OrderingMode? date,
    OrderingMode? title,
  }) async {
    select(todos)
      ..orderBy([
        if (title != null)
          (t) => OrderingTerm(expression: t.title, mode: title),
        if (date != null)
          (t) => OrderingTerm(expression: t.createdAt, mode: date),
      ])
      ..limit(pageSize, offset: page * pageSize);
    return [];
  }

  Future<Todo> getById(int id){
    return (select(todos)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<int> insertTodo(TodosCompanion todo) {
    return into(todos).insert(todo);
  }

  Future<bool> updateTodo(Todo todo) {
    return update(todos).replace(todo);
  }

  Future<int> deleteTodo(int id) {
    return (delete(todos)..where((t) => t.id.equals(id))).go();
  }
}

@DriftDatabase(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
