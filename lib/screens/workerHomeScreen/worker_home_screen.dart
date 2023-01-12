import 'package:flutter/material.dart';

import 'bottomNavifgation/bottom_navigation_worker.dart';

class WorkerHomeScreen extends StatelessWidget {
  const WorkerHomeScreen({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifierWorker = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationWorker(),
      appBar: AppBar(
        title: Text('Workers'),
        centerTitle: true,
        backgroundColor: Color(0xffdb3244),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Text('Worker home screen '),
      ),
    );
  }
}
