import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpro/Model/model.dart';
import 'package:taskpro/Model/updatemodel.dart';
import 'package:taskpro/Services/authservices.dart';
import 'package:taskpro/Utilities/utilities.dart';
import 'package:taskpro/View/authentication/Signup/mapview.dart';
import 'package:taskpro/controller/Authblock/Mapbloc/map_bloc.dart';
import 'package:taskpro/controller/Editimagebloc/editimage_bloc.dart';
import 'package:taskpro/widgets/Profilewidgets/profileditwidget.dart';
import 'package:taskpro/widgets/popups/signupsnakbar.dart';
import 'package:taskpro/widgets/signupwidget/signupformvalidations.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Editprofilescreen extends StatefulWidget {
  final Modelclass usermodel;
  const Editprofilescreen({super.key, required this.usermodel});

  @override
  State<Editprofilescreen> createState() => _EditprofilescreenState();
}

final updatekey = GlobalKey<FormState>();
final Profileditwidget profileditwidget = Profileditwidget();
final editfirstnamecontroller = TextEditingController();
final editseconsnamecontroller = TextEditingController();
final editplacecontroller = TextEditingController();
final editqualificationcontroller = TextEditingController();
final editphonecontroller = TextEditingController();
final editaboutcontroller = TextEditingController();
final editaadharfrontcontroller = TextEditingController();
final editaadharbackcontroller = TextEditingController();
Authservices authservices = Authservices();
Utilities utilities = Utilities();

class _EditprofilescreenState extends State<Editprofilescreen> {
  @override
  void initState() {
    var name = [];
    name = widget.usermodel.name.split(' ');
    utilities.firrstname.text = name[0];
    utilities.lastname.text = name[1];
    utilities.location.text = widget.usermodel.location;
    utilities.maxqualification.text = widget.usermodel.qualification;
    utilities.phonenumber.text = widget.usermodel.phonenumber;
    utilities.about.text = widget.usermodel.about;
    utilities.editaadharfrontimg = widget.usermodel.aadharfront;
    utilities.editaadharbackimg = widget.usermodel.aadharback;
    utilities.editprofileimg = widget.usermodel.profileimage;
    log(" first profile image is ${widget.usermodel.profileimage}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: body(widget.usermodel.register, context),
    );
  }
}

AppBar appbar() {
  return AppBar(
      title: const Customtext(
          text: 'Edit profile', fontWeight: FontWeight.bold, fontsize: 16),
      centerTitle: true);
}

Widget body(String registerty, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
          child: Form(
        key: updatekey,
        child: Column(children: [
          profileditwidget.profileimagewidget(
              context, utilities.editprofileimg!),
          Row(children: [
            Expanded(
                child: profileditwidget.edittextformfeild(
                    validator: validateforname,
                    controller: utilities.firrstname,
                    hintext: 'First Name')),
            const SizedBox(width: 5),
            Expanded(
                child: profileditwidget.edittextformfeild(
                    validator: validateforname,
                    controller: utilities.lastname,
                    hintext: 'Second Name'))
          ]),
          profileditwidget.edittextformfeild(
              validator: validateforabout,
              controller: utilities.about,
              hintext: 'About',
              maxline: 500),
          BlocConsumer<MapBloc, MapState>(listener: (context, state) {
            if (state.selectedplace != null) {
              utilities.selectedLocationLatLng = state.selectedlocation;
              utilities.location.text = state.selectedplace!;
            }
          }, builder: (context, state) {
            return profileditwidget.edittextformfeild(
                onTap: () async {
                  log('clicked');
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                              value: context.read<MapBloc>(),
                              child: const Mapviewpage())));
                  if (result != null) {
                    context
                        .read<MapBloc>()
                        .add(Locationselected(result['location']));
                    context.read<MapBloc>().fectplacename(result['location']);
                  }
                },
                validator: validateforlocation,
                controller: utilities.location,
                hintext: 'Location',
                maxline: 5,
                readonly: true);
          }),
          profileditwidget.edittextformfeild(
              validator: validateforqualification,
              controller: utilities.maxqualification,
              hintext: 'Qualification'),
          profileditwidget.edittextformfeild(
              validator: validatePhoneNumber,
              controller: utilities.phonenumber,
              hintext: 'Phone Number'),
          const SizedBox(height: 30),
          registerty == 'Rejected'
              ? profileditwidget.aadharwidget(context,
                  utilities.editaadharfrontimg!, utilities.editaadharbackimg!)
              : const SizedBox(),
          const SizedBox(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            profileditwidget.customeditbutton(
                button: 'Cancel',
                onPressed: () {
                  Navigator.pop(context);
                }),
            profileditwidget.customeditbutton(
                button: 'Save',
                onPressed: () async {
                  await workerdetailsupdate(context, registerty);
                })
          ])
        ]),
      )));
}

workerdetailsupdate(BuildContext context, String registerty) async {
  final editImageState = BlocProvider.of<EditimageBloc>(context).state;
  final editAadharFrontImageState =
      BlocProvider.of<EditfrontimageBloc>(context).state;
  final editAadharBackImageState =
      BlocProvider.of<EditbackimageBloc>(context).state;

  // Initialize image variables
  String? editProfileImage = utilities.editprofileimg;
  String? editAadharFrontImage = utilities.editaadharfrontimg;
  String? editAadharBackImage = utilities.editaadharbackimg;

  // Check state type and assign image paths
  if (editImageState is Editedmagestate) {
    editProfileImage = editImageState.image;
  }

  if (editAadharFrontImageState is Editedfrontmagestate) {
    editAadharFrontImage = editAadharFrontImageState.image;
  }

  if (editAadharBackImageState is Editedbackmagestate) {
    editAadharBackImage = editAadharBackImageState.image;
  }

  if (updatekey.currentState!.validate() &&
      editProfileImage != null &&
      editAadharFrontImage != null &&
      editAadharBackImage != null) {
    log("Updated profile image path: $editProfileImage");
    log("Updated Aadhaar front image path: $editAadharFrontImage}");
    log("Updated Aadhaar back image path: $editAadharBackImage");
    await authservices.updateuser(
        context,
        Updatemodel(
            editprofileimg: editProfileImage,
            editaadharfrontimg: editAadharFrontImage,
            editaadharbackimg: editAadharBackImage,
            firrstname: utilities.firrstname.text,
            lastname: utilities.lastname.text,
            phonenumber: utilities.phonenumber.text,
            location: utilities.location.text,
            maxqualification: utilities.maxqualification.text,
            about: utilities.about.text,
            register: registerty == 'Rejected' ? 'registerd' : 'Accepted'));
  } else if (editAadharBackImage == null ||
      editAadharFrontImage == null ||
      editProfileImage == null) {
    if (editAadharBackImage == null &&
        editAadharFrontImage == null &&
        editProfileImage == null) {
      CustomPopups.authenticationresultsnakbar(
          context, 'Add Image details', Colors.red);
    } else if (editAadharBackImage == null || editAadharFrontImage == null) {
      CustomPopups.authenticationresultsnakbar(
          context, 'Add your Aadhaar details', Colors.red);
    } else {
      CustomPopups.authenticationresultsnakbar(
          context, 'Add your Photo', Colors.red);
    }
  }
}
