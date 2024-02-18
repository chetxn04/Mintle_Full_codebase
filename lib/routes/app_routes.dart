import 'package:flutter/material.dart';
import 'package:harsh_app/presentation/landing_screen_2_screen/landing_screen_2_screen.dart';

class AppRoutes {
  static const String landingScreen2Screen = '/landing_screen_2_screen';

  static Map<String, WidgetBuilder> routes = {
    landingScreen2Screen: (context) => LandingScreen2Screen()
  };
}
