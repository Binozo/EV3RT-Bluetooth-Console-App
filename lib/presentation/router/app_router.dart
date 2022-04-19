import 'package:flutter/material.dart';

import '../screens/console_screen.dart';
import '../screens/home_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case "/console":
        return MaterialPageRoute(builder: (context) => const ConsoleScreen());
      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    }
  }
}