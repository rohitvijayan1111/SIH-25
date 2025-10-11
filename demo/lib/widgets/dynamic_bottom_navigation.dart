import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/app_controller.dart';
import '../models/service_section.dart';

class DynamicBottomNav extends StatelessWidget {
  const DynamicBottomNav({Key? key}) : super(key: key);

  // // Define colors for each section
  // Map<ServiceSection, Color> getSectionColors() {
  //   return {
  //     ServiceSection.categories: const Color(0xFF4285F4), // Blue - Default
  //     ServiceSection.uploadProduce: const Color(0xFF0C8345), // Green - Farmer
  //     ServiceSection.browseProducts: const Color(
  //       0xFFFF9800,
  //     ), // Light Blue - Customer
  //     ServiceSection.sourceAndSell: Colors.white,
  //     ServiceSection.farmerEssentials: const Color(
  //       0xFF8BC34A,
  //     ), // Light Green - Farmer Services
  //   };
  // }

  // // Define background colors for each section (lighter versions)
  // Map<ServiceSection, Color> getSectionBackgroundColors() {
  //   return {
  //     ServiceSection.categories: Colors.white,
  //     ServiceSection.uploadProduce: const Color(0xFF0C8345), // Very light green
  //     ServiceSection.browseProducts: const Color(0xFFFFF3E0), // Very light blue
  //     ServiceSection.sourceAndSell: const Color(
  //       0xFF1E40AF,
  //     ), // Very light orange
  //     ServiceSection.farmerEssentials: const Color(
  //       0xFFF9FBE7,
  //     ), // Very light green
  //   };
  // }

  // Alternative vibrant color scheme
  Map<ServiceSection, Color> getSectionColors() {
    return {
      ServiceSection.categories: const Color(0xFF6C63FF), // Purple - Default
      ServiceSection.uploadProduce: Color(0xFF0C8345), // Bright Green - Farmer
      ServiceSection.browseProducts: const Color(
        0xFFFF6900,
      ), // Bright Blue - Customer
      ServiceSection.sourceAndSell: Color(
        0xFF1E40AF,
      ), // Bright Orange - Middleman
      ServiceSection.farmerEssentials: const Color(
        0xFF33B679,
      ), // Forest Green - Farmer Services
    };
  }

  Map<ServiceSection, Color> getSectionBackgroundColors() {
    return {
      ServiceSection.categories: const Color(0xFFF8F7FF), // Very light purple
      ServiceSection.uploadProduce: const Color(0xFFE8F5E8), // Very light green
      ServiceSection.browseProducts: const Color(0xFFFFF2E6), // Very light blue
      ServiceSection.sourceAndSell: const Color(0xFFE6F3FF),
      ServiceSection.farmerEssentials: const Color(
        0xFFE8F4F0,
      ), // Very light forest green
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(
      builder: (context, controller, child) {
        final tabs = controller.currentTabs(context);
        final currentSection = controller.currentSection;
        final sectionColors = getSectionColors();
        final backgroundColors = getSectionBackgroundColors();

        final selectedColor =
            sectionColors[currentSection] ?? const Color(0xFF4285F4);
        final backgroundColor =
            backgroundColors[currentSection] ?? Colors.white;

        return Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                color: selectedColor.withOpacity(0.1),
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
            backgroundColor: backgroundColor,
            selectedItemColor: selectedColor,
            unselectedItemColor: Colors.grey[600],
            // unselectedItemColor: Colors.grey[200],
            selectedFontSize: 12,
            unselectedFontSize: 12,
            elevation:
                0, // Remove default elevation since we're using custom shadow
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
