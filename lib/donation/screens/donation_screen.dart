import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pbp_e_03_flutter/donation/services/donation_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pbp_e_03_flutter/shared/service/secure_storage_service.dart';

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
  late File _paymentReceipt;

  // late Future<File> _paymentReceipt;

  // void getFile() {
  //   setState(() => {_paymentReceipt = DonationService.pickFile()});
  // }

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
    DonationService.getCountryObjects().then((value) => {
          setState(() {
            code_and_country = value;
          })
        });
    // _paymentReceipt = Future.value(File('default.txt'));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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

              TextButton(
                child: Text('Select a file'),
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['png', 'jpg', 'jpeg']);
                  late File file;

                  // print(result);

                  if (result != null) {
                    print("MASUK");

                    if (kIsWeb) {
                      print("MASUK web");
                      // On the web, use the file's bytes to create a File object
                      Uint8List bytes = result.files.first.bytes!;
                      file = File.fromRawPath(bytes);
                    } else {
                      String filePath = result.files.single.path!;
                      print("DI BAWAH / SAMPING INI FILEPATH AAAA");
                      print(filePath);
                      file = File(filePath);
                    }
                  }

                  setState(() {
                    _paymentReceipt = file;
                  });
                },
              ),

              SizedBox(
                height: 30.0,
              ),

              ElevatedButton(
                  onPressed: () async {
                    print("masuk onpressed");

                    const String baseUrl = String.fromEnvironment("API_URL");
                    
                    String? accessToken = await SecureStorageService.read("accessToken");
                    final Map<String, String> headers = {
                        "Content-Type": "application/json",
                    "Authorization": "Bearer $accessToken"
                      };

                    var request = http.MultipartRequest(
                        "POST", Uri.parse(path.join(baseUrl, "donation")));

                    request.headers.addAll(headers);

                    print("berhasil request");

                    int pohonAmount = (amount / 10000).toInt();

                    Map<String, String> person = {
                      "name": _name,
                      "phone": _phone,
                      "email": _email,
                    };
                    print(person);

                    String? code = code_and_country[_country];

                    request.files.add(await http.MultipartFile.fromPath(
                        "payment_receipt", _paymentReceipt.path));

                    request.fields["amount"] = pohonAmount.toString();
                    request.fields["donate_for_someone"] =
                        _donate_for_someone.toString();

                    request.fields["country_code"] = code.toString();
                    request.fields["hopes"] = _hopes;
                    request.fields["person"] = person.toString();

                    var response = await request.send();
                    //Get the response from the server
                    var responseData = await response.stream.toBytes();
                    var responseString = String.fromCharCodes(responseData);
                    print(responseString);
                  },
                  child: Text('Submit'))
              // ],
              // ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
