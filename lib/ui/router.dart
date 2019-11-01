import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home_final/core/constants.dart/route_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home_final/ui/views/config_device_view.dart';

import 'package:smart_home_final/ui/views/home_view.dart';
import 'package:smart_home_final/ui/views/login_views.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RoutePaths.ConfigDevice:
        return MaterialPageRoute(builder: (_) => ConfigDevice());  
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
