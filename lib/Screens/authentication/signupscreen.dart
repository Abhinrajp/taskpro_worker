import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskpro/Screens/authentication/mapview.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/controller/Authblock/bloc/auth_bloc.dart';
import 'package:taskpro/controller/Authblock/bloc/auth_event.dart';
import 'package:taskpro/controller/Authblock/bloc/auth_state.dart';
import 'package:taskpro/widgets/signupform.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final formKey = GlobalKey<FormState>();

class _SignUpScreenState extends State<SignUpScreen> {
  XFile? profileimage;
  XFile? aadharfornt;
  XFile? aadharback;
  LatLng? location;
  final firrstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phonenumber = TextEditingController();
  final maxqualification = TextEditingController();
  final worktype = TextEditingController();
  final about = TextEditingController();
  String? selectedWorkType;

  final List<String> workerTypes = [
    'Electrician',
    'Plumber',
    'Cleaner',
    'Painter',
    'Mounting Specialist',
    'Carpenter',
    'HVAC Technician',
    'Roofer',
    'Landscaper',
    'Mason',
    'Welder',
    'General Contractor',
    'Tiler',
    'Handyman',
    'Glazier',
    'Locksmith',
    'Pest Control Specialist',
    'Flooring Installer',
    'Drywall Installer',
    'Plasterer',
    'Window Installer',
    'Door Installer',
    'Ceiling Specialist',
    'Solar Panel Installer',
    'Home Security Installer',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Sign Up',
            style: TextStyle(
                color: primarycolour,
                fontSize: 10,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                'Singed Successfully',
                textAlign: TextAlign.center,
              )));
            } else if (state is AuthFailure) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
              ));
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 29, right: 29, bottom: 10),
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'taskpro',
                            style: TextStyle(
                                color: primarycolour,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              profileimage != null
                                  ? CircleAvatar(
                                      backgroundImage:
                                          FileImage(File(profileimage!.path)),
                                      maxRadius: 53,
                                    )
                                  : const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'lib/Assets/user-image.png'),
                                      maxRadius: 53,
                                    ),
                              Positioned(
                                  top: 70,
                                  left: 65,
                                  child: IconButton(
                                      onPressed: () async {
                                        final ImagePicker picker =
                                            ImagePicker();
                                        var temp = await picker.pickImage(
                                            source: ImageSource.gallery);
                                        setState(() {
                                          profileimage = temp;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 28,
                                        color: Colors.grey,
                                      )))
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Signupform(
                                controler: firrstname,
                                hinttext: 'First Name',
                                valmsg: 'Enter your first Name'),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                              child: Signupform(
                                  controler: lastname,
                                  hinttext: 'Last Name',
                                  valmsg: 'Enter your last Name')),
                        ],
                      ),
                      Signupform(
                        controler: email,
                        hinttext: 'Email',
                        valmsg: 'Enter Your email',
                      ),
                      Signupform(
                          controler: password,
                          hinttext: 'Password',
                          valmsg: 'Enter Your Password'),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enterr your Phone number';
                          } else if (value.length < 10) {
                            return 'Phone number must be 10 digits';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 203, 203, 203))),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('location container taped');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Mapview(
                                    onLocationSelected: locationseletion),
                              ));
                        },
                        child: Container(
                            decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(width: .6))),
                            height: 30,
                            width: 330,
                            child: location != null
                                ? Text(location.toString())
                                : const Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: primarycolour,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Location',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                      ),
                      Signupform(
                          controler: maxqualification,
                          hinttext: 'Max Qualification',
                          valmsg: 'Enter Your Max Qualification'),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                hintText: 'Work Type',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              value: selectedWorkType,
                              items: workerTypes.map((String workerType) {
                                return DropdownMenuItem<String>(
                                  value: workerType,
                                  child: Text(workerType),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedWorkType = newValue;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Stack(children: [
                            Aadharcntainer(aaadharpic: aadharfornt),
                            Positioned(
                                top: 27,
                                left: 114,
                                child: IconButton(
                                    onPressed: () async {
                                      final ImagePicker picker = ImagePicker();
                                      var front = await picker.pickImage(
                                          source: ImageSource.camera);
                                      setState(() {
                                        aadharfornt = front;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 28,
                                      color: Colors.grey,
                                    )))
                          ]),
                          const SizedBox(
                            width: 16,
                          ),
                          Stack(children: [
                            Aadharcntainer(aaadharpic: aadharback),
                            Positioned(
                                top: 27,
                                left: 114,
                                child: IconButton(
                                    onPressed: () async {
                                      final ImagePicker picker = ImagePicker();
                                      var back = await picker.pickImage(
                                          source: ImageSource.camera);
                                      setState(() {
                                        aadharback = back;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 28,
                                      color: Colors.grey,
                                    )))
                          ]),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 20),
                        child: Row(
                          children: [
                            aadharfornt != null
                                ? Expanded(
                                    child: Aadhartext(
                                    text: 'Aadhar Frontside',
                                    fontWeight: FontWeight.bold,
                                  ))
                                : Expanded(
                                    child: Aadhartext(
                                        text: 'Aadhar Frontside',
                                        fontWeight: FontWeight.normal)),
                            const SizedBox(
                              width: 20,
                            ),
                            aadharback != null
                                ? Expanded(
                                    child: Aadhartext(
                                        text: 'Aadhar Backside',
                                        fontWeight: FontWeight.bold))
                                : Expanded(
                                    child: Aadhartext(
                                        text: 'Aadhar Backside',
                                        fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.black),
                      Signupform(
                          controler: about,
                          hinttext: 'About',
                          minline: 1,
                          maxline: null,
                          maxlength: 500,
                          valmsg: 'Enter about yourself'),
                      const Text(
                        'Your phone number and location help us match you with the right Client.',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 11),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate() &&
                              profileimage != null &&
                              aadharfornt != null &&
                              aadharback != null) {
                            BlocProvider.of<AuthBloc>(context).add(
                                SignUpRequested(
                                    email: email.text,
                                    password: password.text,
                                    firstName: firrstname.text,
                                    lastName: lastname.text,
                                    phoneNumber: phonenumber.text,
                                    location: location!,
                                    maxQualification: maxqualification.text,
                                    workType: selectedWorkType ?? '',
                                    about: about.text,
                                    aadharBack: aadharback,
                                    aadharFront: aadharfornt,
                                    profileImage: profileimage));
                          } else if (aadharback == null ||
                              aadharfornt == null ||
                              profileimage == null ||
                              location == null) {
                            if (aadharback == null &&
                                aadharfornt == null &&
                                profileimage == null) {
                              noImage('Add Image details');
                            } else if (aadharback == null &&
                                aadharfornt == null) {
                              noImage('Add your Aadhaar details');
                            } else if (aadharback == null) {
                              noImage('Add backside of your Aadhaar');
                            } else if (aadharfornt == null) {
                              noImage('Add Frontside of your Aadhaar');
                            } else if (location == null) {
                              noImage('Choose your location');
                            } else {
                              noImage('Add your Photo');
                            }
                          }
                        },
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(primarycolour),
                            fixedSize: MaterialStatePropertyAll(Size(400, 60))),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'By signing up, you agree to our',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Terms of services,',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 22, 115, 191)),
                            ),
                          ),
                          const Text(
                            'and',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Privacy Policy',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 22, 115, 191)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account ?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              ' Log in',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 22, 115, 191)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  noImage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 234, 106, 97),
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )));
  }

  locationseletion(LatLng latLng) {
    setState(() {
      location = latLng;
    });
  }
}
