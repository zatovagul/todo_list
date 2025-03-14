import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_todo_list/common/extensions/context_ext.dart';
import 'package:test_todo_list/common/navigation/app_router.dart';

@RoutePage()
class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.todoList)),
      body: ListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(const TodoSaveRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
