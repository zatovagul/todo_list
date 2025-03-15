import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_todo_list/common/extensions/context_ext.dart';
import 'package:test_todo_list/common/navigation/app_router.dart';
import 'package:test_todo_list/common/widgets/loader/load_more_loader.dart';
import 'package:test_todo_list/common/widgets/snackbar/app_snackbar.dart';
import 'package:test_todo_list/features/todo/bloc/list/todo_list_bloc.dart';
import 'package:test_todo_list/features/todo/ui/widgets/todo_item.dart';

@RoutePage()
class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.todoList)),
      body: BlocConsumer<TodoListBloc, TodoListState>(
        listenWhen: (_, state) => state is TodoListState$Deleting,
        listener: (context, state) {
          if (state is! TodoListState$Deleting) return;
          AppSnackBar.of(context).showDeleteSnackBar(
            onCancel: () {
              context.read<TodoListBloc>().add(
                TodoListEvent$CancelDelete(state.entity),
              );
            },
          );
        },
        builder: (context, state) {
          return Stack(
            children: [
              ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                itemCount: state.todos.length + (state.hasMore ? 1 : 0),
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  if (state.hasMore && index == state.todos.length) {
                    return LoadMoreLoader(
                      onLoadMore: () {
                        if (state.isLoading) return;
                        context.read<TodoListBloc>().add(
                          const TodoListEvent$Fetch(),
                        );
                      },
                    );
                  }
                  final i = state.todos[index];
                  return TodoItem(
                    todo: i,
                    onTap: () => context.router.push(TodoSaveRoute(todo: i)),
                  );
                },
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: FloatingActionButton(
                  onPressed: () {
                    context.router.push(TodoSaveRoute());
                  },
                  child: const Icon(Icons.add),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
