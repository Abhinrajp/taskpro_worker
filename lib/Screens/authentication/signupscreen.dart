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
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final formKey = GlobalKey<FormState>();

class _SignUpScreenState extends State<SignUpScreen> {
  void aadharFrontImageSelected(XFile? image) {
    setState(() {
      aadharfornt = image;
    });
  }

  void aadharBackImageSelected(XFile? image) {
    setState(() {
      aadharback = image;
    });
  }

  void profileselectedimage(XFile? image) {
    setState(() {
      profileimage = image;
    });
  }

  XFile? profileimage;
  XFile? aadharfornt;
  XFile? aadharback;
  final firrstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phonenumber = TextEditingController();
  final location = TextEditingController();
  final maxqualification = TextEditingController();
  final worktype = TextEditingController();
  final about = TextEditingController();
  String? selectedWorkType;
  var uuid = const Uuid();
  LatLng? selectedLocationLatLng;
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
  final String token = '1234567890';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(17, 46, 64, 1.0),
        Colors.white,
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(
              'Sign Up',
              style: TextStyle(
                  color: Colors.white,
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
                print(state.error);
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
                                    ? GestureDetector(
                                        onLongPress: () {
                                          if (profileimage != null) {
                                            showFullImage(
                                                context,
                                                File(
                                                  profileimage!.path,
                                                ),
                                                'profile');
                                          }
                                        },
                                        child: CircleAvatar(
                                          backgroundImage: FileImage(
                                              File(profileimage!.path)),
                                          maxRadius: 53,
                                        ),
                                      )
                                    : const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'lib/Assets/user-image.png'),
                                        maxRadius: 53,
                                      ),
                                Positioned(
                                    top: 70,
                                    left: 65,
                                    child: CustomDialogButton(
                                        onImageSelected: profileselectedimage))
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Signupform(
                                  icon: const Icon(Icons.person_2_outlined),
                                  textCapitalization: TextCapitalization.words,
                                  controler: firrstname,
                                  hinttext: 'First Name',
                                  valmsg: 'Enter your first Name'),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                                child: Signupform(
                                    icon: const Icon(Icons.person_2_outlined),
                                    textCapitalization: TextCapitalization.none,
                                    controler: lastname,
                                    hinttext: 'Last Name',
                                    valmsg: 'Enter your last Name')),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Signupform(
                          icon: const Icon(Icons.alternate_email_outlined),
                          textCapitalization: TextCapitalization.none,
                          controler: email,
                          hinttext: 'Email',
                          valmsg: 'Enter Your email',
                        ),
                        const SizedBox(height: 17),
                        Signupform(
                            icon: const Icon(Icons.remove_red_eye_outlined),
                            textCapitalization: TextCapitalization.none,
                            controler: password,
                            hinttext: 'Password',
                            valmsg: 'Enter Your Password'),
                        const SizedBox(height: 17),
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
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(17, 46, 64, 1.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
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
                            prefixIcon: const Icon(Icons.phone_outlined),
                            hintText: 'Phone Number',
                            hintStyle: const TextStyle(
                                color: primarycolour, fontSize: 12),
                          ),
                        ),
                        TextFormField(
                          readOnly: true,
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Mapviewpage()),
                            );

                            if (result != null) {
                              setState(() {
                                selectedLocationLatLng = result['location'];
                                location.text = result['place'];
                              });
                            }
                          },
                          controller: location,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: primarycolour),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            hintText: 'Location',
                            prefixIcon: const Icon(Icons.location_on_outlined),
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primarycolour,
                                fontSize: 13),
                          ),
                          validator: (value) {
                            if (selectedLocationLatLng == null) {
                              return 'Location is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Signupform(
                            icon: const Icon(Icons.book_outlined),
                            textCapitalization: TextCapitalization.words,
                            controler: maxqualification,
                            hinttext: 'Max Qualification',
                            valmsg: 'Enter Your Max Qualification'),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 17),
                                  prefixIcon: const Icon(Icons.work_outline),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(17, 46, 64, 1.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    borderSide:
                                        BorderSide(color: Colors.grey[400]!),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  labelText: 'Work Type',
                                  labelStyle: const TextStyle(
                                      color: primarycolour, fontSize: 12),
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
                                validator: (value) {
                                  if (selectedWorkType == null ||
                                      selectedWorkType!.isEmpty) {
                                    return 'Choose your work';
                                  }
                                  null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 36,
                        ),
                        Row(
                          children: [
                            Stack(children: [
                              Aadharcntainer(
                                aaadharpic: aadharfornt,
                                showFullImage: showFullImage,
                              ),
                              Positioned(
                                  top: 47,
                                  left: 114,
                                  child: CustomDialogButton(
                                    onImageSelected: aadharFrontImageSelected,
                                  ))
                            ]),
                            const SizedBox(
                              width: 16,
                            ),
                            Stack(children: [
                              Aadharcntainer(
                                aaadharpic: aadharback,
                                showFullImage: showFullImage,
                              ),
                              Positioned(
                                  top: 47,
                                  left: 114,
                                  child: CustomDialogButton(
                                      onImageSelected: aadharBackImageSelected))
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
                        const SizedBox(height: 10),
                        const SizedBox(height: 20),
                        Signupform(
                            icon: const Icon(Icons.info_outline),
                            textCapitalization: TextCapitalization.sentences,
                            controler: about,
                            hinttext: 'About',
                            minline: 1,
                            maxline: null,
                            maxlength: 500,
                            valmsg: 'Enter about yourself'),
                        const SizedBox(height: 20),
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
                            print(location.text);
                            print('work type is ${selectedWorkType}');
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
                                      location: location.text,
                                      maxQualification: maxqualification.text,
                                      workType: selectedWorkType ?? '',
                                      about: about.text,
                                      aadharBack: aadharback,
                                      aadharFront: aadharfornt,
                                      profileImage: profileimage));
                            } else if (aadharback == null ||
                                aadharfornt == null ||
                                profileimage == null) {
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
                              } else {
                                noImage('Add your Photo');
                              }
                            }
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(primarycolour),
                              fixedSize:
                                  MaterialStatePropertyAll(Size(400, 60))),
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
          )),
    );
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
}
