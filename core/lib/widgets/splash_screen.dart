import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_Screen';
  
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreen();
  }

  splashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(
      duration,
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeMoviePage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/splash.png'),
      ),
    );
  }
}