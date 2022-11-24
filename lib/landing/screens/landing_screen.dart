import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pbp_e_03_flutter/landing/components/slider_component.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});

  final List<Map<String, String>> list = [
    {
      "imageUrl": 'assets/images/location.png',
      "description": "Choose the Location You Desired to Donate"
    },
    {
      "imageUrl": 'assets/images/tree.png',
      "description": "Choose the Number of Trees that Will be Donated"
    },
    {
      "imageUrl": 'assets/images/donation.png',
      "description": "Tap to Donate the Tree in Your Desired Location"
    },
    {
      "imageUrl": 'assets/images/leaderboard.png',
      "description": "Rise Your Rank and become the Best Among the Others "
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SliderComponent(
              items: list
                  .map((item) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.green),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(item['imageUrl']!),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                child: Text(
                                  item['description']!,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          )),
                        ),
                      ))
                  .toList()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    )),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 20),
                    )),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
