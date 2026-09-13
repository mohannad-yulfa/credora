import 'package:flutter/material.dart';

/// Single source of truth for the application's visual palette.
abstract final class AppColors {
  static const black = Color(0xFF18232B);
  static const white = Color(0xFFFFFFFF);
  static const black87 = Color(0xDE18232B);
  static const grey = Color(0xFF8A9AA1);
  static const grey200 = Color(0xFFE8EFEC);
  static const grey300 = Color(0xFFD7E1DE);
  static const grey600 = Color(0xFF64737B);
  static const grey700 = Color(0xFF4E5D65);
  static const green = Color(0xFF1FAD82);
  static const green100 = Color(0xFFDDF5EC);
  static const red = Color(0xFFD94F5B);
  static const blue = Color(0xFF2D9CDB);
  static const blue800 = Color(0xFF2479A8);
  static const amber = Color(0xFFF2A93B);
  static const bronze = Color(0xFFCD7F32);
  static const cyan = Color(0xFF2D9CDB);
  static const transparentBlack08 = Color(0x14000000);
  static const transparentBlack38 = Color(0x61000000);
  static const transparentBlack58 = Color(0x3A000000);
  static const transparentBlack80 = Color(0x52000000);
  static const transparentBlack97 = Color(0x61000000);
  static const giftAccent = Color(0xFFFFE2A8);
  static const paleGreen = Color(0xFFDDF5EC);
  static const offerGreen = Color(0xFF1FAD82);
  static const offerBlue = Color(0xFF2D9CDB);
  static const buttonBlue = Color(0xFF2479A8);
  static const inputGrey = Color(0xFFF0F5F3);
  static const darkBackground = Color(0xFFF7F4EF);
  static const teal = Color(0xFF19A89A);
  static const darkTeal = Color(0xFF123E3B);

  // --- تحديث درجات الثيمة لتصبح أكثر فخامة وتناسقاً ---
  static const background = Color(0xFFF8F9FA); // خلفية أفتح وأكثر حداثة
  static const surface = Color(0xFFFFFFFF);
  static const surfaceElevated = Color(0xFFFFFFFF);
  static const surfaceSoft = Color(0xFFF1F3F5);
  static const border = Color(0xFFE9ECEF);

  static const primary = Color(0xFFFF6B4A);
  static const primaryStrong = Color(0xFFE24E32);
  static const primaryLight = Color(0xFFFFEBE6);
  static const onPrimary = white;

  static const text = Color(0xFF212529);
  static const textMuted = Color(0xFF6C757D);

  static const success = Color(0xFF1FAD82);
  static const warning = Color(0xFFF2A93B);
  static const danger = Color(0xFFD94F5B);
  static const transparent = Colors.transparent;

  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: black.withOpacity(0.05),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get mediumShadow => [
    BoxShadow(
      color: black.withOpacity(0.08),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];
}

abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.primaryStrong,
      onSecondary: AppColors.onPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.text,
      error: AppColors.danger,
      onError: AppColors.onPrimary,
      outline: AppColors.border,
    );

    return ThemeData(
      colorScheme: colorScheme,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      cardColor: AppColors.surface,
      dividerColor: AppColors.border,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.text),
        bodyMedium: TextStyle(color: AppColors.text),
        bodySmall: TextStyle(color: AppColors.textMuted),
        titleLarge: TextStyle(color: AppColors.text),
        titleMedium: TextStyle(color: AppColors.text),
        titleSmall: TextStyle(color: AppColors.text),
        labelLarge: TextStyle(color: AppColors.text),
        labelMedium: TextStyle(color: AppColors.text),
        labelSmall: TextStyle(color: AppColors.textMuted),
      ),
      iconTheme: const IconThemeData(color: AppColors.text),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.surfaceElevated,
        contentTextStyle: TextStyle(color: AppColors.text),
      ),

      // App Bar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.text,
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
        centerTitle: true,
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceSoft,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        labelStyle: const TextStyle(color: AppColors.textMuted),
        hintStyle: const TextStyle(color: AppColors.textMuted),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primary),
      ),

      // Cards & Dividers
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
      ),

      useMaterial3: true,
    );
  }

  static ThemeData get dark => light;
}

abstract final class AppMotion {
  static const fast = Duration(milliseconds: 180);
  static const standard = Duration(milliseconds: 280);
  static const emphasized = Duration(milliseconds: 420);
  static const curve = Curves.easeOutCubic;
  static const emphasizedCurve = Curves.easeInOutCubic;

  static PageRoute<T> page<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, animation, secondaryAnimation) => page,
      transitionDuration: standard,
      reverseTransitionDuration: fast,
      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: curve,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.04, 0),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
