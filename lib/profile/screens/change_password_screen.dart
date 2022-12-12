import 'package:flutter/material.dart';
import 'package:pbp_e_03_flutter/authentication/components/text_field_components.dart';
import 'package:pbp_e_03_flutter/profile/services/profile_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  String _inputtedPassword = "";
  String _currentPassword = "";
  String _passwordConfirmation = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text(
              "Change Password",
              style: TextStyle(color: Colors.black),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
            child: Column(
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                        "https://desainkaosmurah.com/files/image/img_user/user_1/20200113115926_cartoon_park_forest_2.jpg"),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFieldComponent(
                            isTextObscured: true,
                            labelText: "Current Password",
                            action: (String? value) => setState(() {
                                  _currentPassword = value!;
                                }),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Current Password cannot be empty!';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldComponent(
                            isTextObscured: true,
                            labelText: "New Password",
                            action: (String? value) => setState(() {
                                  _inputtedPassword = value!;
                                }),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Password cannot be empty!';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldComponent(
                            isTextObscured: true,
                            labelText: "Password Confirmation",
                            action: (String? value) => setState(() {
                                  _passwordConfirmation = value!;
                                }),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Password Confirmation cannot be empty!';
                              } else if (value != _inputtedPassword) {
                                return "Password did not match!";
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                Map<String, String> body = {
                                  "current_password": _currentPassword,
                                  "password": _inputtedPassword,
                                  "password_confirmation":
                                      _passwordConfirmation,
                                };

                                dynamic response =
                                    await ProfileService.changePassword(body);

                                Future.delayed(Duration.zero).then((value) =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text(response['message']))));

                                setState(() {});
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text("Change Password",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )))
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
