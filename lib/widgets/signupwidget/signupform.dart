// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

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
  Future<void> pickImage(ImageSource source) async {
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
                      await pickImage(ImageSource.camera);
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
                      await pickImage(ImageSource.gallery);
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
  String hinttext;
  final String? Function(String?)? validator;
  int? maxline, minline, maxlength;
  TextEditingController controler;
  TextCapitalization textCapitalization;
  TextInputType keybordtype;
  Icon icon;
  Color? color;
  bool readonly;
  VoidCallback? onTap;
  List<String>? items;
  String? dropdownvalue;
  Signupform(
      {this.keybordtype = TextInputType.name,
      this.textCapitalization = TextCapitalization.none,
      this.color,
      required this.controler,
      this.maxline,
      this.minline,
      this.maxlength,
      required this.hinttext,
      super.key,
      required this.icon,
      this.validator,
      this.readonly = false,
      this.onTap,
      this.items,
      this.dropdownvalue});

  @override
  Widget build(BuildContext context) {
    if (items != null) {
      return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 17),
            prefixIcon: const Icon(Icons.work_outline),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red),
            ),
            labelText: 'Work Type',
            labelStyle: const TextStyle(color: Colors.black, fontSize: 12),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          value: dropdownvalue,
          items: items!.map((String workerType) {
            return DropdownMenuItem<String>(
                value: workerType,
                child: Text(
                  workerType,
                  style: TextStyle(
                      fontWeight: dropdownvalue == workerType
                          ? FontWeight.normal
                          : FontWeight.normal),
                ));
          }).toList(),
          onChanged: (String? newValue) {
            controler.text = newValue ?? '';
          },
          validator: validator);
    } else {
      return TextFormField(
        controller: controler,
        minLines: minline,
        maxLines: maxline,
        keyboardType: keybordtype,
        maxLength: maxlength,
        readOnly: readonly,
        onTap: onTap,
        textCapitalization: textCapitalization,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          fillColor: Colors.white.withOpacity(0.8),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Colors.black)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red)),
          prefixIcon: Icon(icon.icon),
          label: Customtext(text: hinttext),
        ),
      );
    }
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

class Profilecircleavathar extends StatelessWidget {
  final void Function(BuildContext context, File imageFile, String text)
      showFullImage;
  XFile? profilepic;
  Profilecircleavathar({
    super.key,
    required this.profilepic,
    required this.showFullImage,
  });

  @override
  Widget build(BuildContext context) {
    return profilepic != null
        ? GestureDetector(
            onLongPress: () {
              showFullImage(
                context,
                File(profilepic!.path),
                'profile',
              );
            },
            child: CircleAvatar(
              backgroundImage: FileImage(File(profilepic!.path)),
              maxRadius: 53,
            ),
          )
        : const CircleAvatar(
            backgroundImage: AssetImage('lib/Assets/user-image.png'),
            maxRadius: 53,
          );
  }
}

class Aadhartext extends StatelessWidget {
  String text;
  final bool isbold;
  Aadhartext({
    required this.text,
    required this.isbold,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        style: TextStyle(
            fontWeight: isbold ? FontWeight.bold : FontWeight.normal,
            fontSize: 11),
      ),
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
