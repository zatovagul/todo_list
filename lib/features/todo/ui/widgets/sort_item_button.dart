import 'package:flutter/material.dart';
import 'package:test_todo_list/common/extensions/context_ext.dart';
import 'package:test_todo_list/features/todo/domain/entity/ordering_mode_entity.dart';

class SortItemButton extends StatelessWidget {
  const SortItemButton({
    required this.icon,
    required this.orderingMode,
    required this.onTap,
    super.key,
  });

  final Widget icon;
  final OrderingModeEntity? orderingMode;
  final ValueSetter<OrderingModeEntity?> onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: orderingMode == null ? Colors.grey : context.theme.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap:
            () => onTap(switch (orderingMode) {
              OrderingModeEntity.asc => OrderingModeEntity.desc,
              OrderingModeEntity.desc => null,
              null => OrderingModeEntity.asc,
            }),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 4),
              Icon(switch (orderingMode) {
                OrderingModeEntity.asc => Icons.arrow_downward,
                OrderingModeEntity.desc => Icons.arrow_upward,
                null => Icons.arrow_downward,
              }, color: context.theme.colorScheme.onPrimary),
            ],
          ),
        ),
      ),
    );
  }
}
