// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskpro/const.dart';

class CustomDialogButton extends StatefulWidget {
  final Function(XFile?) onImageSelected;

  const CustomDialogButton({
    Key? key,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  _CustomDialogButtonState createState() => _CustomDialogButtonState();
}

class _CustomDialogButtonState extends State<CustomDialogButton> {
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    widget.onImageSelected(image);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(78.0),
            child: Dialog(
              backgroundColor: primarycolour,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      await _pickImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 45,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await _pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.image_outlined,
                      size: 45,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      icon: const Icon(
        Icons.camera_alt_outlined,
        size: 28,
        color: Colors.black,
      ),
    );
  }
}

class Signupform extends StatelessWidget {
  String hinttext, valmsg;
  int? maxline, minline, maxlength;
  TextEditingController controler;
  TextCapitalization? textCapitalization;
  Icon icon;
  Color? color;
  Signupform(
      {this.textCapitalization,
      this.color,
      required this.controler,
      this.maxline,
      required this.valmsg,
      this.minline,
      this.maxlength,
      required this.hinttext,
      super.key,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controler,
      minLines: minline,
      maxLines: maxline,
      maxLength: maxlength,
      textCapitalization: textCapitalization!,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => (value == null || value.isEmpty) ? valmsg : null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        fillColor: Colors.white.withOpacity(0.8),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: primarycolour),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
        ),
        prefixIcon: Icon(icon.icon),
        labelText: hinttext,
        labelStyle: const TextStyle(
          color: primarycolour,
          fontSize: 13,
        ),
      ),
    );
  }
}

class Aadharcntainer extends StatelessWidget {
  final void Function(BuildContext context, File imageFile, String text)
      showFullImage;
  XFile? aaadharpic;
  Aadharcntainer({
    required this.aaadharpic,
    super.key,
    required this.showFullImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      height: 80,
      width: 150,
      child: aaadharpic != null
          ? GestureDetector(
              onLongPress: () {
                showFullImage(context, File(aaadharpic!.path), 'aadhaar');
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Image.file(
                  File(aaadharpic!.path),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Image.asset(
                'lib/Assets/user-image.png',
                fit: BoxFit.cover,
              ),
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

void showFullImage(BuildContext context, File imageFile, String text) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          text == 'profile'
              ? CircleAvatar(
                  minRadius: 30,
                  maxRadius: 190,
                  backgroundImage: FileImage(imageFile),
                )
              : Image.file(imageFile)
        ],
      ),
    ),
  );
}
