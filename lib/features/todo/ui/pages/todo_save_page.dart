import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:test_todo_list/features/todo/domain/entity/todo_entity.dart';

@RoutePage()
class TodoSavePage extends StatelessWidget {
  const TodoSavePage({super.key, this.todo});

  final TodoEntity? todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
