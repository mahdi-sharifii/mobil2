import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:mobile2/locator.dart';
import 'package:sizer/sizer.dart';

import 'home/screen/home.dart';

void main() {
  runApp(const MyApp());

  startLocator();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MySplashScreen(),
      );
    });
  }
}

/// Splash Screen
class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goNextPage(context);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: DelayedDisplay(
          delay: const Duration(milliseconds: 600),
          child: FlutterLogo(
            size: 25.w,
          ),
        ),
      ),
    );
  }
}

/// Sleep in Splash Screen 5 sec and go to Home Screen

Future<void> goNextPage(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );

  });
}
