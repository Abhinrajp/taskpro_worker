import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskpro/Screens/Home/homescreen.dart';
import 'package:taskpro/Screens/authentication/Signup/mapview.dart';
import 'package:taskpro/Utilities/utilities.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/controller/Authblock/bloc/auth_bloc.dart';
import 'package:taskpro/controller/Authblock/bloc/auth_event.dart';
import 'package:taskpro/controller/Authblock/bloc/auth_state.dart';
import 'package:taskpro/widgets/signupform.dart';
import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final formKey = GlobalKey<FormState>();
Utilities utilities = Utilities();

class _SignUpScreenState extends State<SignUpScreen> {
  void aadharFrontImageSelected(XFile? image) {
    setState(() {
      utilities.aadharfornt = image;
    });
  }

  void aadharBackImageSelected(XFile? image) {
    setState(() {
      utilities.aadharback = image;
    });
  }

  void profileselectedimage(XFile? image) {
    setState(() {
      utilities.profileimage = image;
    });
  }

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
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                  'Singed Successfully',
                  textAlign: TextAlign.center,
                )));
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Homescreen()));
              }
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.error),
                ));
                print(state.error);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
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
                                  utilities.profileimage != null
                                      ? GestureDetector(
                                          onLongPress: () {
                                            if (utilities.profileimage !=
                                                null) {
                                              showFullImage(
                                                  context,
                                                  File(
                                                    utilities
                                                        .profileimage!.path,
                                                  ),
                                                  'profile');
                                            }
                                          },
                                          child: CircleAvatar(
                                            backgroundImage: FileImage(File(
                                                utilities.profileimage!.path)),
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
                                          onImageSelected:
                                              profileselectedimage))
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
                                    textCapitalization:
                                        TextCapitalization.words,
                                    controler: utilities.firrstname,
                                    hinttext: 'First Name',
                                    valmsg: 'Enter your first Name'),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                  child: Signupform(
                                      icon: const Icon(Icons.person_2_outlined),
                                      textCapitalization:
                                          TextCapitalization.none,
                                      controler: utilities.lastname,
                                      hinttext: 'Last Name',
                                      valmsg: 'Enter your last Name')),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Signupform(
                            icon: const Icon(Icons.alternate_email_outlined),
                            textCapitalization: TextCapitalization.none,
                            controler: utilities.email,
                            hinttext: 'Email',
                            valmsg: 'Enter Your email',
                          ),
                          const SizedBox(height: 17),
                          Signupform(
                              icon: const Icon(Icons.remove_red_eye_outlined),
                              textCapitalization: TextCapitalization.none,
                              controler: utilities.password,
                              hinttext: 'Password',
                              valmsg: 'Enter Your Password'),
                          const SizedBox(height: 17),
                          TextFormField(
                            controller: utilities.phonenumber,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                borderSide:
                                    BorderSide(color: Colors.grey[400]!),
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
                                  utilities.selectedLocationLatLng =
                                      result['location'];
                                  utilities.location.text = result['place'];
                                });
                              }
                            },
                            controller: utilities.location,
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
                              prefixIcon:
                                  const Icon(Icons.location_on_outlined),
                              hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: primarycolour,
                                  fontSize: 13),
                            ),
                            validator: (value) {
                              if (utilities.selectedLocationLatLng == null) {
                                return 'Location is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Signupform(
                              icon: const Icon(Icons.book_outlined),
                              textCapitalization: TextCapitalization.words,
                              controler: utilities.maxqualification,
                              hinttext: 'Max Qualification',
                              valmsg: 'Enter Your Max Qualification'),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 17),
                                    prefixIcon: const Icon(Icons.work_outline),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(17, 46, 64, 1.0)),
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
                                  value: utilities.selectedWorkType,
                                  items: utilities.workerTypes
                                      .map((String workerType) {
                                    return DropdownMenuItem<String>(
                                      value: workerType,
                                      child: Text(workerType),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      utilities.selectedWorkType = newValue;
                                    });
                                  },
                                  validator: (value) {
                                    if (utilities.selectedWorkType == null ||
                                        utilities.selectedWorkType!.isEmpty) {
                                      return 'Choose your work';
                                    }
                                    return null;
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
                                  aaadharpic: utilities.aadharfornt,
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
                                  aaadharpic: utilities.aadharback,
                                  showFullImage: showFullImage,
                                ),
                                Positioned(
                                    top: 47,
                                    left: 114,
                                    child: CustomDialogButton(
                                        onImageSelected:
                                            aadharBackImageSelected))
                              ]),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 20),
                            child: Row(
                              children: [
                                utilities.aadharfornt != null
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
                                utilities.aadharback != null
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
                              controler: utilities.about,
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
                              print(utilities.location.text);
                              print(
                                  'work type is ${utilities.selectedWorkType}');
                              if (formKey.currentState!.validate() &&
                                  utilities.profileimage != null &&
                                  utilities.aadharfornt != null &&
                                  utilities.aadharback != null) {
                                BlocProvider.of<AuthBloc>(context).add(
                                    SignUpRequested(
                                        email: utilities.email.text,
                                        password: utilities.password.text,
                                        firstName: utilities.firrstname.text,
                                        lastName: utilities.lastname.text,
                                        phoneNumber: utilities.phonenumber.text,
                                        location: utilities.location.text,
                                        maxQualification:
                                            utilities.maxqualification.text,
                                        workType:
                                            utilities.selectedWorkType ?? '',
                                        about: utilities.about.text,
                                        aadharBack: utilities.aadharback,
                                        aadharFront: utilities.aadharfornt,
                                        profileImage: utilities.profileimage));
                              } else if (utilities.aadharback == null ||
                                  utilities.aadharfornt == null ||
                                  utilities.profileimage == null) {
                                if (utilities.aadharback == null &&
                                    utilities.aadharfornt == null &&
                                    utilities.profileimage == null) {
                                  noImage('Add Image details');
                                } else if (utilities.aadharback == null &&
                                    utilities.aadharfornt == null) {
                                  noImage('Add your Aadhaar details');
                                } else if (utilities.aadharback == null) {
                                  noImage('Add backside of your Aadhaar');
                                } else if (utilities.aadharfornt == null) {
                                  noImage('Add Frontside of your Aadhaar');
                                } else {
                                  noImage('Add your Photo');
                                }
                              }
                            },
                            style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(primarycolour),
                                fixedSize:
                                    WidgetStatePropertyAll(Size(400, 60))),
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
              );
            },
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
