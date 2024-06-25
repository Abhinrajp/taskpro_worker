import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Signupform extends StatelessWidget {
  String hinttext, valmsg;
  int? maxline, minline, maxlength;
  TextEditingController controler;
  Signupform({
    required this.controler,
    this.maxline,
    required this.valmsg,
    this.minline,
    this.maxlength,
    required this.hinttext,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => (value == null || value.isEmpty) ? valmsg : null,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 203, 203, 203))),
      ),
    );
  }
}

class Aadharcntainer extends StatelessWidget {
  XFile? aaadharpic;
  Aadharcntainer({
    required this.aaadharpic,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 150,
      color: Colors.grey,
      child: aaadharpic != null
          ? Image.file(
              File(aaadharpic!.path),
              fit: BoxFit.cover,
            )
          : Image.asset(
              'lib/Assets/user-image.png',
              fit: BoxFit.cover,
            ),
    );
  }
}

class Aadhartext extends StatelessWidget {
  String text;
  FontWeight fontWeight;
  Aadhartext({
    required this.text,
    required this.fontWeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: Colors.black, fontSize: 12, fontWeight: fontWeight),
    );
  }
}
