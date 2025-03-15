import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_todo_list/common/extensions/context_ext.dart';
import 'package:test_todo_list/features/home/bloc/app_settings_bloc.dart';

class AppSettingsScope extends StatelessWidget {
  const AppSettingsScope({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppSettingsBloc(context.di.appSettingsRepository),
      child: child,
    );
  }
}
