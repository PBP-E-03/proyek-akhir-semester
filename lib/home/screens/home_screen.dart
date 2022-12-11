import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pbp_e_03_flutter/authentication/screens/login_screen.dart';
import 'package:pbp_e_03_flutter/authentication/services/authentication_service.dart';
import 'package:pbp_e_03_flutter/home/components/bottom_navigation_bar_component.dart';
import 'package:pbp_e_03_flutter/shared/service/secure_storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Center(
                child: Text("Hello user"),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      await AuthenticationService.logoutUser();

                      await SecureStorageService.destroyAll();

                      Future.delayed(Duration.zero).then((value) =>
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen())));
                    },
                    child: const Text("logout")),
              )
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigationBarComponents());
  }
}
