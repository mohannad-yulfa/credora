import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late Orientation orientation;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

  static double width(double inputWidth) {
    return (inputWidth / 375.0) * screenWidth;
  }

  static double contentWidth(
    double desiredWidth, {
    double horizontalMargin = 32,
  }) {
    return desiredWidth.clamp(0, screenWidth - horizontalMargin).toDouble();
  }

  static double height(double inputHeight) {
    return (inputHeight / 812.0) * screenHeight;
  }

  /// 🔤 حجم الخط المتجاوب
  static double fontSize(double inputFontSize) {
    // نجمع بين العرض والطول للحصول على متوسط نسبي
    double scaleFactor = (screenWidth + screenHeight) / (375.0 + 812.0);
    return inputFontSize * scaleFactor;
  }

  /// 🧍 للحصول على حجم متناسب للـ padding أو margin
  static EdgeInsets symmetricPadding({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: width(horizontal),
      vertical: height(vertical),
    );
  }
}
