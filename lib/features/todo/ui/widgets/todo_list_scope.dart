import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_todo_list/common/extensions/context_ext.dart';
import 'package:test_todo_list/features/todo/bloc/list/todo_list_bloc.dart';

class TodoListScope extends StatelessWidget {
  const TodoListScope({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoListBloc(repository: context.di.todoRepository),
      child: child,
    );
  }
}
