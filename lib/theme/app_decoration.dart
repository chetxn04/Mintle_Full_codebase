import 'package:flutter/material.dart';
import 'package:harsh_app/core/app_export.dart';

class AppDecoration {
  // Gradient decorations
  static BoxDecoration get gradientOnPrimaryContainerToBlack => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.21, 1),
          end: Alignment(0.2, 0),
          colors: [
            theme.colorScheme.onPrimaryContainer,
            appTheme.black900,
          ],
        ),
      );
}

class BorderRadiusStyle {}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
