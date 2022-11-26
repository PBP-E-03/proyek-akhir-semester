import 'package:flutter/material.dart';
import 'package:pbp_e_03_flutter/authentication/components/registration_stepper_component.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  Widget getStepController(
      GlobalKey<FormState> formKey, BuildContext context, int step) {
    List<Widget> stepControllers = [
      Row(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 20),
              )),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // var budget = {
                  //   "title": _title,
                  //   "amount": _amount,
                  //   "type": _type,
                  //   "date": dateInput.text
                  // };

                  // Provider.of<BudgetModel>(context, listen: false)
                  //     .addBudget(budget);

                  // _formKey.currentState?.reset();

                  // setState(() {
                  //   _type = 'Choose Type';
                  //   dateInput.text = "";
                  // });

                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Data has been saved!")));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 20),
              )),
        ],
      ),
      Row(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 20),
              )),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // var budget = {
                  //   "title": _title,
                  //   "amount": _amount,
                  //   "type": _type,
                  //   "date": dateInput.text
                  // };

                  // Provider.of<BudgetModel>(context, listen: false)
                  //     .addBudget(budget);

                  // _formKey.currentState?.reset();

                  // setState(() {
                  //   _type = 'Choose Type';
                  //   dateInput.text = "";
                  // });

                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Data has been saved!")));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 20),
              )),
        ],
      )
    ];

    return stepControllers[step];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/landing-hero.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.darken),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.cover,
                          width: 212,
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(40),
                              bottom: Radius.circular(0))),
                      child: const RegistrationStepperComponent())
                ],
              ))),
    );
  }
}
