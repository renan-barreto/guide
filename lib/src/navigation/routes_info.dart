import 'package:flutter/material.dart';
import 'package:guide/src/navigation/flows.dart';
import 'package:guide/src/screens/home_screen.dart';

class RoutesInfo {
  static dynamic getRoutes(dynamic settings) {
    switch (settings.name) {
      case Flows.home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
          settings: settings,
        );
    }

    return null;
  }
}
