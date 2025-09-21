import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'Middleman Dashboard';
  static const String version = '1.0.0';

  // Colors - Based on the UI design
  static const Color primaryBlue = Color(0xFF4285F4);
  static const Color primaryGreen = Color(0xFF34A853);
  static const Color warningOrange = Color(0xFFFB8C00);
  static const Color errorRed = Color(0xFFEA4335);
  static const Color lightBlue = Color(0xFF87CEEB);
  static const Color purple = Color(0xFF8A2BE2);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color darkGrey = Color(0xFF616161);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Gradients
  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFF7B68EE), Color(0xFF9370DB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [Color(0xFF87CEEB), Color(0xFF4169E1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [Color(0xFF32CD32), Color(0xFF228B22)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Padding and Margins
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  // Border Radius
  static const double defaultBorderRadius = 12.0;
  static const double cardBorderRadius = 16.0;

  // Font Sizes
  static const double titleFontSize = 24.0;
  static const double subtitleFontSize = 18.0;
  static const double bodyFontSize = 16.0;
  static const double captionFontSize = 12.0;

  // Icon Sizes
  static const double defaultIconSize = 24.0;
  static const double smallIconSize = 16.0;
  static const double largeIconSize = 32.0;

  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
}

// Theme Configuration
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: AppConstants.primaryBlue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppConstants.primaryBlue,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.grey[50],
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: AppConstants.titleFontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.defaultBorderRadius,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.largePadding,
            vertical: AppConstants.defaultPadding,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppConstants.primaryBlue,
        unselectedItemColor: AppConstants.darkGrey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// Utility Classes
class AppUtils {
  static String formatCurrency(double amount) {
    return '₹${amount.toStringAsFixed(0)}';
  }

  static String formatWeight(double weight) {
    if (weight >= 1000) {
      return '${(weight / 1000).toStringAsFixed(1)}t';
    }
    return '${weight.toStringAsFixed(0)}kg';
  }

  static String formatDate(DateTime date) {
    return '${date.day}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }

  static String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}
