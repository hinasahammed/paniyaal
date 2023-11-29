import 'package:flutter/material.dart';
import 'package:paniyaal/screens/userHomeScreen/userPofileScreen/user_profile_screen.dart';

import 'bottomNavigation/bottom_navigation.dart';
import 'jobCategoryScreen/job_category_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({
    super.key,
  });

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final _pages = [
    const JobCategoryScreen(),
    UserProfileScreen(),
  ];

  @override
  void initState() {
    setState(() {
      UserHomeScreen.selectedIndexNotifier = ValueNotifier(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: UserHomeScreen.selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
    );
  }
}
