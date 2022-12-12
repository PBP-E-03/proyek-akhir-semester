import 'package:flutter/material.dart';
import 'package:pbp_e_03_flutter/authentication/screens/login_screen.dart';
import 'package:pbp_e_03_flutter/authentication/services/authentication_service.dart';
import 'package:pbp_e_03_flutter/profile/components/edit_profile_section.dart';
import 'package:pbp_e_03_flutter/profile/components/profile_section.dart';
import 'package:pbp_e_03_flutter/shared/service/secure_storage_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          )),
      body: SafeArea(
          child: FutureBuilder(
        future: AuthenticationService.getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Future.delayed(Duration.zero).then((value) =>
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(snapshot.error.toString()))));
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(
                padding: const EdgeInsets.all(12),
                child: Column(children: [
                  ProfileSection(
                      name: snapshot.data!.content!.name,
                      email: snapshot.data!.content!.email),
                  const SizedBox(
                    height: 20,
                  ),
                  const EditProfileSection(),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await AuthenticationService.logoutUser();

                        await SecureStorageService.destroyAll();

                        Future.delayed(Duration.zero).then(
                            (value) => Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (route) => false,
                                ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text("Logout",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )))
                ]));
          }
        },
      )),
    );
  }
}
