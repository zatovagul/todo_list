import 'package:flutter/material.dart';
import 'package:test_todo_list/common/extensions/context_ext.dart';

class AppSnackBar {
  const AppSnackBar.of(this.context);

  final BuildContext context;

  List<BoxShadow> _contentShadows() {
    return [
      BoxShadow(
        color: Theme.of(context).primaryColor.withOpacity(.1),
        blurRadius: 20,
        offset: const Offset(0, 4),
      ),
      BoxShadow(
        color: Colors.black.withOpacity(.08),
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
    ];
  }

  void showDeleteSnackBar({required VoidCallback onCancel}) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final content = _buildSnackBar(
      Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
          boxShadow: _contentShadows(),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(seconds: 5),
          builder: (context, value, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(child: Text(context.l10n.deleting)),
                      InkWell(
                        onTap: () {
                          onCancel();
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },

                        child: Text(context.l10n.cancel),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: LinearProgressIndicator(
                    value: value,
                    color: Theme.of(context).colorScheme.onPrimary,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(content);
  }

  SnackBar _buildSnackBar(Widget content) {
    return SnackBar(
      elevation: 0,
      margin: const EdgeInsets.fromLTRB(28, 0, 28, 4),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 5),
      dismissDirection: DismissDirection.endToStart,
      content: content,
    );
  }
}
