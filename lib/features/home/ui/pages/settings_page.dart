import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_todo_list/common/extensions/context_ext.dart';
import 'package:test_todo_list/features/home/bloc/app_settings_bloc.dart';
import 'package:test_todo_list/features/home/domain/entities/app_theme_entity.dart';
import 'package:test_todo_list/features/home/ui/view/app_theme_mode_button.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settings)),
      body: BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                for (final i in AppThemeEntity.values)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AppThemeModeButton(
                      mode: i,
                      checked: state.mode == i,
                      onTap: () {
                        context.read<AppSettingsBloc>().add(
                          AppSettingsEvent$SetTheme(i),
                        );
                      },
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
