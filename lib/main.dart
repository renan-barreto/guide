import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guide/src/navigation/routes_info.dart';
import 'package:guide/src/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(GuideApp());
}

Map<int, Color> ps = {
  50: Color.fromRGBO(18, 58, 60, .1),
  100: Color.fromRGBO(18, 58, 60, .2),
  200: Color.fromRGBO(18, 58, 60, .3),
  300: Color.fromRGBO(18, 58, 60, .4),
  400: Color.fromRGBO(18, 58, 60, .5),
  500: Color.fromRGBO(18, 58, 60, .6),
  600: Color.fromRGBO(18, 58, 60, .7),
  700: Color.fromRGBO(18, 58, 60, .8),
  800: Color.fromRGBO(18, 58, 60, .9),
  900: Color.fromRGBO(18, 58, 60, 1),
};

class GuideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xFF123A3C, ps);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guide Investimentos',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: SplashScreen(),
      onGenerateRoute: (settings) {
        return RoutesInfo.getRoutes(settings);
      },
    );
  }
}
