import 'package:flutter/material.dart';
import '../user_home_screen.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: UserHomeScreen.selectedIndexNotifier,
        builder: (BuildContext ctx, int updatedIndex, Widget? _) {
          return BottomNavigationBar(
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              UserHomeScreen.selectedIndexNotifier.value = newIndex;
            },
            selectedItemColor: Color(0xffdb3244),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: 'Profile'),
            ],
          );
        });
  }
}
