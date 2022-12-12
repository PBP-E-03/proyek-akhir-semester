import 'package:flutter/material.dart';
import 'package:pbp_e_03_flutter/authentication/models/user_model.dart';
import 'package:pbp_e_03_flutter/authentication/services/authentication_service.dart';
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
            child: FutureBuilder(
          future: AuthenticationService.getUser(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasError) {
              Future.delayed(Duration.zero).then((value) =>
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(snapshot.error.toString()))));
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
                  child: Column(
                    children: [
                      ProfileSection(
                          name: snapshot.data!.content!.name,
                          coin: snapshot.data!.content!.coin),
                      const SizedBox(
                        height: 18,
                      ),
                      AccountSection(
                          donationTotal:
                              snapshot.data!.content!.totalDonatedTree,
                          country: snapshot.data!.content!.mostDonatedCountry),
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
              );
            }
          },
        )),
        bottomNavigationBar: const BottomNavigationBarComponents(
          currentPage: 'Home',
        ));
  }
}
