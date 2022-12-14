import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pbp_e_03_flutter/authentication/components/slider_component.dart';
import 'package:pbp_e_03_flutter/authentication/components/text_field_components.dart';
import 'package:pbp_e_03_flutter/authentication/models/token_model.dart';
import 'package:pbp_e_03_flutter/authentication/screens/registration_screen.dart';
import 'package:pbp_e_03_flutter/authentication/services/authentication_service.dart';
import 'package:pbp_e_03_flutter/home/screens/home_screen.dart';
import 'package:pbp_e_03_flutter/shared/service/secure_storage_service.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

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
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
              child: Image.asset("assets/images/logo-black.png",
                  fit: BoxFit.cover, width: 212),
            ),
            SliderComponent(
                height: MediaQuery.of(context).size.height * 0.525,
                items: widget.list
                    .map((item) => Card(
                          margin: const EdgeInsets.all(12),
                          color: Colors.green,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 0),
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
                    .toList())
          ]),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      TextFieldComponent(
                          keyboardType: TextInputType.emailAddress,
                          labelText: "Email",
                          hintText: "generous.people@mail.com",
                          action: (String? value) {
                            setState(() {
                              _email = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Email cannot be empty!';
                            } else if (!EmailValidator.validate(value)) {
                              return 'Email is not valid!';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFieldComponent(
                        isTextObscured: true,
                        labelText: "Password",
                        action: (String? value) {
                          setState(() {
                            _password = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_loginFormKey.currentState!.validate()) {
                              Map<String, String> body = {
                                "email": _email,
                                "password": _password,
                              };

                              dynamic response =
                                  await AuthenticationService.loginUser(body);

                              if (response['refresh'] != null &&
                                  response['access'] != null) {
                                await SecureStorageService.write(
                                    "refreshToken", response['refresh']);
                                await SecureStorageService.write(
                                    "accessToken", response['access']);

                                Future.delayed(Duration.zero).then((value) =>
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    )));
                              } else {
                                Future.delayed(Duration.zero).then((value) =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Email or password are wrong"))));
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 20),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Doesn't have an account?",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationScreen()));
                            },
                            child: const Text("Create One!",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    ));
  }
}
