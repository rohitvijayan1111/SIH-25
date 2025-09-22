import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/app_controller.dart';

class DynamicBottomNav extends StatelessWidget {
  const DynamicBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(
      builder: (context, controller, child) {
        final tabs = controller.currentTabs;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentTabIndex,
            onTap: controller.changeTab,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF4285F4),
            unselectedItemColor: Colors.grey[600],
            selectedFontSize: 12,
            unselectedFontSize: 12,
            items: tabs
                .map(
                  (tab) => BottomNavigationBarItem(
                    icon: Icon(tab.icon),
                    activeIcon: Icon(tab.activeIcon),
                    label: tab.label,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
