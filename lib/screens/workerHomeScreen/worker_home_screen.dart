import 'package:flutter/material.dart';
import 'package:paniyaal/screens/workerHomeScreen/profileScreen/worker_profile_screen.dart';
import 'package:paniyaal/screens/workerHomeScreen/mainPage/worker_main_page.dart';
import 'bottomNavigation/bottom_navigation_worker.dart';

class WorkerHomeScreen extends StatefulWidget {
  const WorkerHomeScreen({super.key});
  static ValueNotifier<int> selectedIndexNotifierWorker = ValueNotifier(0);

  @override
  State<WorkerHomeScreen> createState() => _WorkerHomeScreenState();
}

class _WorkerHomeScreenState extends State<WorkerHomeScreen> {
  final _pages = [
    const WorkerMainPage(),
    const ProfileScreen(),
  ];
  @override
  void initState() {
    setState(() {
      WorkerHomeScreen.selectedIndexNotifierWorker = ValueNotifier(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigationWorker(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: WorkerHomeScreen.selectedIndexNotifierWorker,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
    );
  }
}
