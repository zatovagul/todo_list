import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_todo_list/common/extensions/context_ext.dart';
import 'package:test_todo_list/common/utils/image_util.dart';
import 'package:test_todo_list/common/widgets/input/app_field.dart';
import 'package:test_todo_list/common/widgets/input/pick_image_field.dart';
import 'package:test_todo_list/features/todo/bloc/list/todo_list_bloc.dart';
import 'package:test_todo_list/features/todo/bloc/save/todo_save_bloc.dart';
import 'package:test_todo_list/features/todo/domain/entity/todo_entity.dart';

@RoutePage()
class TodoSavePage extends StatefulWidget implements AutoRouteWrapper {
  const TodoSavePage({super.key, this.todo});

  final TodoEntity? todo;

  @override
  State<TodoSavePage> createState() => _TodoSavePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return TodoSaveBloc(context.di.todoRepository)
          ..add(TodoSaveEvent$Init(todo: todo));
      },
      child: this,
    );
  }
}

class _TodoSavePageState extends State<TodoSavePage> {
  final _formKey = GlobalKey<FormState>();
  late final _titleController = TextEditingController(text: widget.todo?.title);
  late final _descriptionController = TextEditingController(
    text: widget.todo?.description,
  );
  late String? _imageUrl = widget.todo?.imageUrl;

  Future<void> _save(TodoEntity? item) async {
    final bloc = context.read<TodoSaveBloc>();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (item?.imageUrl != _imageUrl && _imageUrl != null) {
      _imageUrl = await ImageUtil.saveFileToPermanentStorage(File(_imageUrl!));
    }
    final todo = TodoEntity(
      id: widget.todo?.id ?? -1,
      title: _titleController.text,
      description: _descriptionController.text,
      createdAt: widget.todo?.createdAt ?? DateTime.now(),
      imageUrl: _imageUrl,
    );
    bloc.add(TodoSaveEvent$Save(todo));
  }

  void _delete(TodoEntity todo) {
    context.read<TodoListBloc>().add(TodoListEvent$Delete(todo));
    context.maybePop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocConsumer<TodoSaveBloc, TodoSaveState>(
        listenWhen: (_, state) => state is TodoSaveState$Success,
        listener: (context, state) {
          context.read<TodoListBloc>().add(const TodoListEvent$UpdateList());
          context.maybePop();
        },
        builder: (context, state) {
          final todo = state.todo ?? widget.todo;
          return Scaffold(
            appBar: AppBar(title: Text(todo?.title ?? context.l10n.createTodo)),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      AppField(
                        controller: _titleController,
                        label: context.l10n.title,
                        validator: (value) {
                          if (value?.isNotEmpty ?? false) return null;
                          return context.l10n.enterThisField;
                        },
                      ),
                      const SizedBox(height: 12),
                      AppField(
                        controller: _descriptionController,
                        label: context.l10n.description,
                        maxLines: null,
                      ),
                      const SizedBox(height: 12),
                      PickImageField(
                        onFilePicked: (file) {
                          _imageUrl = file?.path;
                          setState(() {});
                        },
                        file: _imageUrl == null ? null : File(_imageUrl!),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        if (todo != null) ...[
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => _delete(todo),
                              child: Text(context.l10n.delete),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => _save(todo),
                            child:
                                state.isLoading
                                    ? const SizedBox.square(
                                      dimension: 20,
                                      child: CircularProgressIndicator(),
                                    )
                                    : Text(context.l10n.save),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
