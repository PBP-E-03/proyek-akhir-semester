import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pbp_e_03_flutter/donation/services/donation_service.dart';
import 'package:file_picker/file_picker.dart';

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
  bool _donate_for_someone = false;
  String _hopes = "";
  String _name = "";
  String _phone = "";
  String _email = "";
  // File _paymentReceipt = File('default.txt');

  late Future<File> _paymentReceipt;

  void getFile() {
    setState(() => {_paymentReceipt = DonationService.pickFile()});
  }

  // Future<void> getFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);
  //   late File file;

  //   if(result!=null) {
  //     String path = result.files.first.path!;
  //     file = File(path);
  //   }

  //   setState(() {
  //     _paymentReceipt = file;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    DonationService.getCountries().then((data) => {
          setState(() {
            countries = data;
          })
        });
    _paymentReceipt = Future.value(File('default.txt'));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                decoration: InputDecoration(
                    hintText: "Your desired amount",
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
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Column(
            //     children: [
                  // _paymentReceipt != null ?
                  // Text(_paymentReceipt.path):
                  // Text("gada"),
                  // TextButton(
                  //   onPressed: () => {
                  //     getFile()
                  //   },
                  //    child: Text('select file'))

                  // FutureBuilder(
                  //   future: _paymentReceipt,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       File file = snapshot.data!;
                  //       return Text(file.path);
                  //     } else if (snapshot.hasError) {
                  //       return Text('Error: ${snapshot.error}');
                  //     }
                  //     return Text('tidak ada data');

                  //     // return CircularProgressIndicator();

                  //     // return TextButton(
                  //     //   onPressed: () => DonationService.pickFile(),
                  //     //   child: Text('Select a file AAAAAAAAAAAAAAAA'),
                  //     // );
                  //   },
                  // ),
                  // TextButton(
                  //       onPressed: () => getFile(),
                  //       child: Text('Select a file AAAAAAAAAAAAAAAA'),
                  //     )

                  // TextButton(
                  //   child: Text('Select file'),
                  //   onPressed: () async {
                  //     FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);
                  //     late File file;

                  //     if(result!=null) {
                  //       String path = result.files.first.path!;
                  //       file = File(path);
                  //     }

                  //     setState(() {
                  //       _paymentReceipt = file;
                  //     });
                  //   },
                  // ),
                // ],
              // ),
            // )
          ],
        ),
      ),
    );
  }
}
