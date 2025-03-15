import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_todo_list/common/navigation/app_router.dart';
import 'package:test_todo_list/features/home/ui/view/navigation_bottom_bar.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [TodoListRoute(), SettingsRoute()],
      builder: (context, child) {
        return Column(
          children: [
            Expanded(child: child),
            NavigationBottomBar(
              onChanged: context.tabsRouter.setActiveIndex,
              index: context.tabsRouter.activeIndex,
            ),
          ],
        );
      },
    );
  }
}
