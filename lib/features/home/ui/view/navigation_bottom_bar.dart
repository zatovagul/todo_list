import 'package:flutter/material.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar({
    required this.index,
    required this.onChanged,
    super.key,
  });

  final int index;
  final ValueSetter<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: onChanged,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
