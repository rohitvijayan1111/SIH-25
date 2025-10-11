import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'controllers/app_controller.dart';
import 'widgets/dynamic_bottom_navigation.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(
      builder: (context, controller, child) {
        return Scaffold(
          body: controller.getCurrentScreen(),
          // bottomNavigationBar: BottomNavigationBar(
          //   type: BottomNavigationBarType.fixed,
          //   // backgroundColor: Colors.white,
          //   // selectedItemColor: const Color(0xFF4285F4),
          //   // unselectedItemColor: Colors.grey[600],
          //   currentIndex: controller.currentTabIndex,
          //   onTap: controller.changeTab,
          //   items: controller
          //       .currentTabs(context) // ✅ Pass context here
          //       .map(
          //         (tab) => BottomNavigationBarItem(
          //           icon: Icon(tab.icon),
          //           activeIcon: Icon(tab.activeIcon),
          //           label: tab.label,
          //         ),
          //       )
          //       .toList(),
          // ),
          bottomNavigationBar: DynamicBottomNav(),
        );
      },
    );
  }
}
