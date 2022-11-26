import 'package:flutter/material.dart';
import 'package:pbp_e_03_flutter/authentication/components/text_field_components.dart';

class PasswordInformationStepComponent extends StatelessWidget {
  const PasswordInformationStepComponent(
      {super.key,
      required this.passwordInformationKey,
      required this.setPassword,
      required this.setConfirmationPassword,
      required this.inputtedPassword});

  final GlobalKey<FormState> passwordInformationKey;
  final void Function(String? value) setPassword;
  final void Function(String? value) setConfirmationPassword;
  final String inputtedPassword;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: passwordInformationKey,
        child: Column(
          children: [
            TextFieldComponent(
                height: 90,
                isTextObscured: true,
                labelText: "Password",
                action: setPassword,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be empty!';
                  }
                  return null;
                }),
            TextFieldComponent(
                height: 90,
                isTextObscured: true,
                labelText: "Password Confirmation",
                action: setConfirmationPassword,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Password Confirmation cannot be empty!';
                  } else if (value != inputtedPassword) {
                    return "Password did not match!";
                  }
                  return null;
                })
          ],
        ));
  }
}
