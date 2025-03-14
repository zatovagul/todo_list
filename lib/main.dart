import 'package:flutter/material.dart';
import 'package:test_todo_list/common/di/app_di.dart';
import 'package:test_todo_list/main_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final di = AppDi.init();
  runApp(MainApp(appDi: di));
}
