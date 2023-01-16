
import 'package:flutter/material.dart';

import 'package:paniyaal/screens/workerHomeScreen/profile_screen.dart';
import 'package:paniyaal/screens/workerHomeScreen/worker_main_page.dart';

import 'bottomNavifgation/bottom_navigation_worker.dart';

class WorkerHomeScreen extends StatelessWidget {
   WorkerHomeScreen({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifierWorker = ValueNotifier(0);

   final _pages =  [
     WorkerMainPage(),
     ProfileScreen(),
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  BottomNavigationWorker(),
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
