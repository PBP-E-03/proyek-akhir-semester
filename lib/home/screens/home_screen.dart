import 'package:flutter/material.dart';
import 'package:pbp_e_03_flutter/home/components/account_section.dart';
import 'package:pbp_e_03_flutter/home/components/bottom_navigation_bar_component.dart';
import 'package:pbp_e_03_flutter/home/components/faq_section.dart';
import 'package:pbp_e_03_flutter/home/components/news_section.dart';
import 'package:pbp_e_03_flutter/home/components/profile_section.dart';

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
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
            child: Column(
              children: [
                const ProfileSection(),
                const SizedBox(
                  height: 18,
                ),
                const AccountSection(),
                const SizedBox(
                  height: 18,
                ),
                NewsSection(),
                const SizedBox(
                  height: 18,
                ),
                const FAQSection(),
              ],
            ),
          ),
        )),
        bottomNavigationBar: const BottomNavigationBarComponents(
          currentPage: 'Home',
        ));
  }
}
