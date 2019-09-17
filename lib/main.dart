import 'package:flutter/material.dart';
import 'package:smart_home_final/provider_setup.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_final/core/constants.dart/route_path.dart';
import 'package:smart_home_final/ui/router.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Khsmart',
        theme: ThemeData(
          primaryColor: Colors.green,
          primarySwatch: Colors.amber,
        ),
        initialRoute: RoutePaths.Login,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
