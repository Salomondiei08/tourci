import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tour_ci/screens/city_list_screen.dart';
import 'package:tour_ci/screens/profile_screen.dart';

import '../theme/app_theme.dart';
import 'camera_screen.dart';
import 'overview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Map<String, Widget>> _pages = [
    {
      "page": const OverviewScreen(),
    },
    {
      "page": const CityListScreen(),
    },
    {
      "page": const CameraScreen(),
    },
    {
      "page": const OverviewScreen(),
    },
    {
      "page": const ProfileScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[currentIndex]["page"],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: selectElement,
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Icon(
                  Icons.home_outlined,
                  color: Colors.black,
                  size: 4.h,
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Icon(
                  Icons.home_outlined,
                  color: AppTheme.orange,
                  size: 4.h,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Icon(
                  Icons.language,
                  color: Colors.black,
                  size: 4.h,
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Icon(
                  Icons.language,
                  color: AppTheme.orange,
                  size: 4.h,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Icon(
                  Icons.explore_outlined,
                  color: Colors.black,
                  size: 4.h,
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Icon(
                  Icons.explore_outlined,
                  color: AppTheme.orange,
                  size: 4.h,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Icon(
                  Icons.history,
                  color: Colors.black,
                  size: 4.h,
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Icon(
                  Icons.history,
                  color: AppTheme.orange,
                  size: 4.h,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 4.h,
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Icon(
                  Icons.person,
                  color: AppTheme.orange,
                  size: 4.h,
                ),
              ),
            ),
          ],
        )

        //  AppNavigationBar(
        //   currentIndex: currentIndex,
        //   listOfIcons: listOfIcons,
        //   onTap: selectElement,
        // ),
        );
  }

  void selectElement(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
