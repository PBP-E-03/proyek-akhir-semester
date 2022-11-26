import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent(
      {super.key,
      required this.labelText,
      this.hintText,
      this.height,
      this.keyboardType,
      this.inputFormatter,
      this.maxLines = 1,
      this.isTextObscured = false,
      required this.action,
      required this.validator});

  final String? hintText;
  final String labelText;
  final TextInputType? keyboardType;
  final void Function(String? value) action;
  final String? Function(String? value) validator;
  final List<TextInputFormatter>? inputFormatter;
  final int? maxLines;
  final double? height;
  final bool isTextObscured;

  void handleChangeAction(String? value) {
    action(value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      // Using padding of 8 pixels
      child: TextFormField(
        obscureText: isTextObscured,
        maxLines: maxLines,
        keyboardType: keyboardType,
        inputFormatters: inputFormatter,
        textAlignVertical: TextAlignVertical.top,
        // Only numbers can be entered,
        // Only numbers can be entered
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          alignLabelWithHint: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
        // Added behavior when name is typed
        onChanged: handleChangeAction,
        // Validator as form validation
        validator: validator,
      ),
    );
  }
}
