import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbp_e_03_flutter/authentication/components/text_field_components.dart';

class AccountInformationStepComponent extends StatelessWidget {
  const AccountInformationStepComponent({
    super.key,
    required this.userInformationFormKey,
    required this.setName,
    required this.setEmail,
    required this.setPhone,
    required this.setAddress,
  });

  final GlobalKey<FormState> userInformationFormKey;
  final void Function(String? value) setName;
  final void Function(String? value) setEmail;
  final void Function(String? value) setPhone;
  final void Function(String? value) setAddress;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: userInformationFormKey,
        child: Column(
          children: [
            TextFieldComponent(
                height: 90,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty!';
                  }
                  return null;
                },
                labelText: "Name",
                hintText: "Generous People",
                action: (String? value) => setName(value)),
            TextFieldComponent(
                height: 90,
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
                action: (String? value) => setEmail(value)),
            TextFieldComponent(
              height: 90,
              labelText: "Phone Number",
              hintText: "08xxxxxxxx",
              keyboardType: TextInputType.number,
              inputFormatter: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              action: (String? value) => setPhone(value),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Phone number cannot be empty!';
                }
                return null;
              },
            ),
            TextFieldComponent(
              height: 140,
              labelText: "Address",
              hintText: "Jakarta",
              maxLines: 4,
              action: (String? value) => setAddress(value),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Address cannot be empty!';
                }
                return null;
              },
            )
          ],
        ));
  }
}
