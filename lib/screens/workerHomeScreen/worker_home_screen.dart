import 'package:flutter/material.dart';
import 'package:paniyaal/screens/workerHomeScreen/profileScreen/worker_profile_screen.dart';
import 'package:paniyaal/screens/workerHomeScreen/mainPage/worker_main_page.dart';
import 'bottomNavigation/bottom_navigation_worker.dart';

class WorkerHomeScreen extends StatelessWidget {
  WorkerHomeScreen({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifierWorker = ValueNotifier(0);

  final _pages = [
    WorkerMainPage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationWorker(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifierWorker,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
    );
  }
}
