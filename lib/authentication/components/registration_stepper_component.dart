import 'package:flutter/material.dart';
import 'package:pbp_e_03_flutter/authentication/components/account_information_step_component.dart';
import 'package:pbp_e_03_flutter/authentication/components/password_information_step_component.dart';
import 'package:pbp_e_03_flutter/authentication/components/stepper_controller_component.dart';

class RegistrationStepperComponent extends StatefulWidget {
  const RegistrationStepperComponent({super.key});

  @override
  State<RegistrationStepperComponent> createState() =>
      _RegistrationStepperComponentState();
}

class _RegistrationStepperComponentState
    extends State<RegistrationStepperComponent> {
  int _step = 0;
  final _userInformationFormKey = GlobalKey<FormState>();
  final _passwordInformationFormKey = GlobalKey<FormState>();
  String _name = "";
  String _email = "";
  String _phone = "";
  String _address = "";
  String _password = "";
  String _confirmationPassword = "";

  void nextStep() {
    if (_step == getSteps().length - 1) {
      if (_passwordInformationFormKey.currentState!.validate()) {}
      //Do something with this information
      print("test cuy");
    } else if (_userInformationFormKey.currentState!.validate()) {
      print("test");
      setState(() {
        _step += 1;
      });
    }
  }

  void previousStep() => _step == 0
      ? Navigator.pop(context)
      : setState(() {
          _step -= 1;
        });

  List<Step> getSteps() {
    return [
      Step(
        state: _step > 0 ? StepState.complete : StepState.indexed,
        isActive: _step >= 0,
        title: const Text(""),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text("User Information",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 14,
                ),
                AccountInformationStepComponent(
                  userInformationFormKey: _userInformationFormKey,
                  setEmail: ((String? value) => setState(() {
                        _email = value!;
                      })),
                  setPhone: ((String? value) => setState(() {
                        _phone = value!;
                      })),
                  setName: ((String? value) => setState(() {
                        _name = value!;
                      })),
                  setAddress: ((String? value) => setState(() {
                        _email = value!;
                      })),
                ),
              ],
            ),
            StepperControllerComponent(
                currentStep: _step,
                nextStep: nextStep,
                previousStep: previousStep)
          ],
        ),
      ),
      Step(
          state: _step > 1 ? StepState.complete : StepState.indexed,
          isActive: _step >= 1,
          title: const Text(""),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text("Password Information",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 14,
                    ),
                    PasswordInformationStepComponent(
                      passwordInformationKey: _passwordInformationFormKey,
                      inputtedPassword: _password,
                      setPassword: ((String? value) => setState(() {
                            _password = value!;
                          })),
                      setConfirmationPassword: ((String? value) => setState(() {
                            _confirmationPassword = value!;
                          })),
                    ),
                  ],
                ),
                StepperControllerComponent(
                    currentStep: _step,
                    nextStep: nextStep,
                    previousStep: previousStep)
              ],
            ),
          ))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            canvasColor: Colors.transparent,
            colorScheme:
                Theme.of(context).colorScheme.copyWith(primary: Colors.green)),
        child: Stepper(
          elevation: 0,
          type: StepperType.horizontal,
          controlsBuilder: ((context, details) {
            // return widget.getStepController(widget.formKey, context, _step);
            return Container();
          }),
          currentStep: _step,
          onStepTapped: (int index) {
            setState(() {
              _step = index;
            });
          },
          steps: getSteps(),
        ));
  }
}
