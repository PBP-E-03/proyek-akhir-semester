import 'package:flutter/material.dart';
import 'package:pbp_e_03_flutter/home/screens/home_screen.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 2,
        length: 5,
        child: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              body: const SafeArea(
                  child: TabBarView(children: [
                HomeScreen(), // Change this for history screen
                HomeScreen(), // Change this for market screen
                HomeScreen(),
                HomeScreen(), // Change this for donation screen
                HomeScreen() // Change this for leader board screen
              ])),
              bottomNavigationBar: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: Colors.green,
                ),
                child: TabBar(
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white38),
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.history),
                      ),
                      Tab(
                        icon: Icon(Icons.store),
                      ),
                      Tab(
                        icon: Icon(Icons.home),
                      ),
                      Tab(
                        icon: Icon(Icons.forest),
                      ),
                      Tab(
                        icon: Icon(Icons.leaderboard),
                      )
                    ]),
              ),
            );
          },
        ));
  }
}
