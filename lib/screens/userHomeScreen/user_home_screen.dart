import 'package:flutter/material.dart';
import 'package:paniyaal/screens/userHomeScreen/widget/job_category_screen.dart';
import 'package:paniyaal/screens/userHomeScreen/widget/user_profile_screen.dart';

import 'bottomNavigation/bottom_navigation.dart';

class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({
    Key? key,}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = [
    JobCategoryScreen(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
    );
  }
}
