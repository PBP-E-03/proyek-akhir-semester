import 'package:flutter/material.dart';

class StepperControllerComponent extends StatelessWidget {
  const StepperControllerComponent(
      {super.key,
      required this.nextStep,
      required this.previousStep,
      required this.currentStep});

  final void Function() previousStep;
  final void Function() nextStep;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
                onPressed: previousStep,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    minimumSize: const Size.fromHeight(50)),
                child: Text(
                  currentStep == 0 ? "Cancel" : "Previous",
                  style: const TextStyle(fontSize: 20),
                ))),
        const SizedBox(width: 10),
        Expanded(
            child: ElevatedButton(
                onPressed: nextStep,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    minimumSize: const Size.fromHeight(50)),
                child: Text(
                  currentStep == 1 ? "Register" : "Next",
                  style: const TextStyle(fontSize: 20),
                )))
      ],
    );
  }
}
