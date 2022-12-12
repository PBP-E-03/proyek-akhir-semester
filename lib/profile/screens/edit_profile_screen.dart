import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pbp_e_03_flutter/authentication/components/text_field_components.dart';
import 'package:pbp_e_03_flutter/profile/models/profile_model.dart';
import 'package:pbp_e_03_flutter/profile/services/profile_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _email = "";
  String _phone = "";
  String _address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Edit Profile",
            style: TextStyle(color: Colors.black),
          )),
      body: FutureBuilder(
        future: ProfileService.getProfile(),
        builder: (BuildContext context, AsyncSnapshot<Profile> snapshot) {
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
                                initialValue: snapshot.data!.content!.username,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Name cannot be empty!';
                                  }
                                  return null;
                                },
                                labelText: "Name",
                                hintText: "Generous People",
                                action: (String? value) => setState(() {
                                      _name = value!;
                                    })),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldComponent(
                                initialValue: snapshot.data!.content!.email,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email cannot be empty!';
                                  } else if (!EmailValidator.validate(value)) {
                                    return 'Email is not valid!';
                                  }
                                  return null;
                                },
                                labelText: "Email",
                                hintText: "generous.people@mail.com",
                                keyboardType: TextInputType.emailAddress,
                                action: (String? value) => setState(() {
                                      _email = value!.toLowerCase();
                                    })),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldComponent(
                              initialValue: snapshot.data!.content!.phone,
                              labelText: "Phone Number",
                              hintText: "08xxxxxxxx",
                              keyboardType: TextInputType.number,
                              inputFormatter: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              action: (String? value) => setState(() {
                                _phone = value!;
                              }),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone number cannot be empty!';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldComponent(
                              initialValue: snapshot.data!.content!.address,
                              labelText: "Address",
                              hintText: "Jakarta",
                              maxLines: 4,
                              action: (String? value) => setState(() {
                                _address = value!;
                              }),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Address cannot be empty!';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    Map<String, String> body = {
                                      "username": _name,
                                      "email": _email,
                                      "phone": _phone,
                                      "address": _address,
                                    };

                                    Profile response =
                                        await ProfileService.updateProfile(
                                            body);
                                    print(response);
                                    Future.delayed(Duration.zero).then(
                                        (value) => ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text(response.message))));

                                    setState(() {});
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                child: const Text("Edit",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )))
                          ],
                        ))
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
