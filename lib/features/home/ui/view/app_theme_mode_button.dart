import 'package:flutter/material.dart';
import 'package:test_todo_list/common/extensions/context_ext.dart';
import 'package:test_todo_list/features/home/domain/entities/app_theme_entity.dart';

class AppThemeModeButton extends StatelessWidget {
  const AppThemeModeButton({
    required this.mode,
    required this.checked,
    required this.onTap,
    super.key,
  });

  final AppThemeEntity mode;
  final bool checked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final text = switch (mode) {
      AppThemeEntity.light => context.l10n.lightMode,
      AppThemeEntity.dark => context.l10n.darkMode,
      AppThemeEntity.system => context.l10n.systemMode,
    };
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          side: checked ? BorderSide(color: context.theme.colorScheme.error) : null,
        ),
        child: Text(text),
      ),
    );
  }
}
