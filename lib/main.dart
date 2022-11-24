import 'package:flutter/material.dart';
import 'package:pbp_e_03_flutter/landing/screens/landing_screen.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GenerosiTree',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: LandingScreen());
  }
}
