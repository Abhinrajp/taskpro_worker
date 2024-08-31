import 'package:flutter/material.dart';
import 'package:taskpro/Utilities/const.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Customformfield extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String hintext;
  final Icon icon;
  final TextInputType keybordtype;
  const Customformfield(
      {super.key,
      required this.hintext,
      required this.icon,
      required this.controller,
      required this.validator,
      this.keybordtype = TextInputType.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        validator: validator,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: icon,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: primarycolour),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.red),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          label: Customtext(text: hintext, fontsize: 14),
        ),
      ),
    );
  }
}
