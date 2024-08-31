import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpro/Utilities/const.dart';
import 'package:taskpro/controller/Editimagebloc/editimage_bloc.dart';
import 'package:taskpro/widgets/signupwidget/signupform.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Profileditwidget {
  Widget profileimagewidget(BuildContext context, String profilimgurl) {
    return Stack(children: [
      BlocBuilder<EditimageBloc, EditimageState>(
        builder: (context, state) {
          String displayImageUrl = profilimgurl;
          if (state is Editedmagestate) {
            displayImageUrl = state.image;
          } else {
            displayImageUrl = profilimgurl;
          }

          ImageProvider imageProvider;
          if (displayImageUrl.startsWith('http')) {
            imageProvider = NetworkImage(displayImageUrl);
          } else {
            imageProvider = FileImage(File(displayImageUrl));
          }
          return CircleAvatar(backgroundImage: imageProvider, radius: 70);
        },
      ),
      Positioned(
          top: 95,
          left: 98,
          child: CustomDialogButton(onImageSelected: (image) {
            BlocProvider.of<EditimageBloc>(context)
                .add(Editedimageevent(image: image!.path));
          }))
    ]);
  }

  Widget aadharwidget(
      BuildContext context, String aadharfronturl, aadharbackurl) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Stack(children: [
        BlocBuilder<EditfrontimageBloc, EditimageState>(
            builder: (context, state) {
          String displayImageUrl = aadharfronturl;

          ImageProvider imageProvider = NetworkImage(displayImageUrl);
          if (state is Editedfrontmagestate) {
            displayImageUrl = state.image;
            if (state.image.startsWith('http')) {
              imageProvider = NetworkImage(displayImageUrl);
            } else {
              imageProvider = FileImage(File(displayImageUrl));
            }
          }
          return Container(
              height: 160,
              width: 160,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: Image(image: imageProvider, fit: BoxFit.cover)));
        }),
        Positioned(
            left: 120,
            top: 110,
            child: CustomDialogButton(onImageSelected: (image) {
              BlocProvider.of<EditfrontimageBloc>(context)
                  .add(Editedfrontimageevent(image: image!.path));
            }))
      ]),
      Stack(children: [
        BlocBuilder<EditbackimageBloc, EditimageState>(
            builder: (context, state) {
          String displayImageUrl = aadharbackurl;
          displayImageUrl = aadharbackurl;
          ImageProvider imageProvider = NetworkImage(displayImageUrl);
          if (state is Editedbackmagestate) {
            displayImageUrl = state.image;
            if (state.image.startsWith('http')) {
              imageProvider = NetworkImage(displayImageUrl);
            } else {
              imageProvider = FileImage(File(displayImageUrl));
            }
          }
          return Container(
              height: 160,
              width: 160,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: Image(image: imageProvider, fit: BoxFit.cover)));
        }),
        Positioned(
            left: 120,
            top: 110,
            child: CustomDialogButton(onImageSelected: (image) {
              BlocProvider.of<EditbackimageBloc>(context)
                  .add(Editedbackimageevent(image: image!.path));
            }))
      ])
    ]);
  }

  Widget customeditbutton(
      {required String button, void Function()? onPressed}) {
    return ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(primarycolour)),
        onPressed: onPressed,
        child: Customtext(text: button, color: Colors.white));
  }

  Widget edittextformfeild(
      {required TextEditingController controller,
      required String hintext,
      int maxline = 1,
      int minline = 1,
      bool readonly = false,
      String? Function(String?)? validator,
      void Function()? onTap}) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: TextFormField(
            onTap: onTap,
            controller: controller,
            maxLines: maxline,
            minLines: minline,
            readOnly: readonly,
            validator: validator,
            decoration: InputDecoration(
                labelStyle: const TextStyle(fontSize: 13),
                label: Customtext(text: hintext, fontsize: 13),
                hintText: hintext)));
  }
}
