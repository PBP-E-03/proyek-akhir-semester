import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbp_e_03_flutter/donation/services/donation_service.dart';
import 'package:pbp_e_03_flutter/home/components/bottom_navigation_bar_component.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  final String title = "Add Budget Info";

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final _formKey = GlobalKey<FormState>();
  int amount = 0;
  String _country = 'Indonesia';
  List<String> countries = [];
  List<String> country_codes = [];
  Map<String, String> code_and_country = {};
  bool _donate_for_someone = false;
  String _hopes = "";
  String _name = "";
  String _phone = "";
  String _email = "";

  @override
  void initState() {
    super.initState();
    DonationService.getCountries().then((data) => {
          setState(() {
            countries = data;
          })
        });
    DonationService.getCountryObjects().then((value) => {
          setState(() {
            code_and_country = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      // Check if the value is a number that is a multiple of 10,000
                      if (int.tryParse(value!) != null &&
                          int.parse(value) % 10000 == 0) {
                        // If the value is valid, return null to indicate that the input is valid
                        return null;
                      } else {
                        // If the value is not valid, return an error message
                        return 'Please enter a number that is a multiple of 10000';
                      }
                    },
                    decoration: InputDecoration(
                        hintText:
                            "Your desired amount (Rp) in multiples of 10000",
                        labelText: "Amount",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    onChanged: (String value) {
                      setState(() {
                        int valueInt = int.parse(value);
                        amount = valueInt;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: "Select a country",
                    ),
                    child: DropdownButton<String>(
                      value: _country,
                      items: countries.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _country = value!;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: "Donate for someone?",
                    ),
                    child: Checkbox(
                      value: _donate_for_someone,
                      onChanged: (bool? value) {
                        setState(() {
                          _donate_for_someone = value!;
                        });
                      },
                    ),
                  ),
                ),
                Visibility(
                    visible: _donate_for_someone,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "John Doe",
                                labelText: "Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                            onChanged: (String value) {
                              setState(() {
                                _name = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "0858xxxxxxx",
                                labelText: "Phone",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                            onChanged: (String value) {
                              setState(() {
                                _phone = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "example@gmail.com",
                                labelText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                            onChanged: (String value) {
                              setState(() {
                                _email = value;
                              });
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      // Set the text input action
                      textInputAction: TextInputAction.newline,
                      maxLines: 10,
                      decoration: InputDecoration(
                          hintText: "Your hopes for this donation",
                          labelText: "Hopes",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      onChanged: (String value) {
                        setState(() {
                          _hopes = value;
                        });
                      },
                    )),

                const SizedBox(
                  height: 30.0,
                ),

                ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> person = {
                        "name": _name,
                        "phone": _phone,
                        "email": _email,
                      };

                      Map<String, dynamic> body = {
                        "amount": amount ~/ 10000,
                        "country_code": code_and_country[_country],
                        "hopes": _hopes,
                        "donate_for_someone": _donate_for_someone,
                        "person": jsonEncode(person)
                      };

                      dynamic response = await DonationService.donate(body);

                      print(response);
                    },
                    child: const Text('Submit'))
                // ],
                // ),
                // )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          const BottomNavigationBarComponents(currentPage: "Donation"),
    );
  }
}
