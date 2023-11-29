import 'package:flutter/material.dart';
import 'package:paniyaal/screens/workerHomeScreen/worker_home_screen.dart';

class BottomNavigationWorker extends StatelessWidget {
  const BottomNavigationWorker({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: WorkerHomeScreen.selectedIndexNotifierWorker,
        builder: (BuildContext ctx, int updatedIndex, Widget? _) {
          return BottomNavigationBar(
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              WorkerHomeScreen.selectedIndexNotifierWorker.value = newIndex;
            },
            selectedItemColor: const Color(0xffdb3244),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
            ],
          );
        });
  }
}
