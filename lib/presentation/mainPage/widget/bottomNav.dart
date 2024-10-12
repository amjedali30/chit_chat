import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

ValueNotifier<int> indexChangeNotifer = ValueNotifier(0);

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChangeNotifer,
      builder: (context, int newIndex, _) {
        return FlashyTabBar(
          selectedIndex: newIndex,
          showElevation: true,
          onItemSelected: (index) {
            indexChangeNotifer.value = index;
          },
          items: [
            FlashyTabBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.face),
              title: Text('Profile'),
            ),
          ],
        );
      },
    );
  }
}
