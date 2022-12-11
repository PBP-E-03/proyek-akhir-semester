import 'package:flutter/material.dart';
import 'package:pbp_e_03_flutter/authentication/screens/login_screen.dart';
import 'package:pbp_e_03_flutter/authentication/services/authentication_service.dart';
import 'package:pbp_e_03_flutter/home/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const App());

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ScreenState>(create: (_) => ScreenState()),
      ],
      child: MaterialApp(
          title: 'GenerosiTree',
          debugShowCheckedModeBanner:
              const String.fromEnvironment("ENV") == "prod" ? false : true,
          navigatorKey: navigatorKey,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: FutureBuilder(
            future: AuthenticationService.isAuthenticated(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return snapshot.data! ? const HomeScreen() : LoginScreen();
              }
            },
          )),
    );
  }
}

class ScreenState with ChangeNotifier {
  int _currentScreen = 0;
  int get getCurrentScreen => _currentScreen;

  void setCurrentScreen(int screenIndex) {
    _currentScreen = screenIndex;
    notifyListeners();
  }
}
