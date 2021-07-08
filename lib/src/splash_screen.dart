import 'package:flutter/material.dart';
import 'package:guide/src/navigation/flows.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    startApp();
  }

  void startApp() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      return Navigator.pushReplacementNamed(context, Flows.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(18, 58, 60, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                'assets/images/guide.png',
                width: MediaQuery.of(context).size.width - 100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
