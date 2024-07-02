import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskpro/Screens/Home/homescreen.dart';
import 'package:taskpro/Screens/authentication/Login/loginscreen.dart';
import 'package:taskpro/Screens/authentication/Signup/mapview.dart';
import 'package:taskpro/Utilities/utilities.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/controller/Authblock/Authbloc/auth_bloc.dart';
import 'package:taskpro/controller/Authblock/Authbloc/auth_event.dart';
import 'package:taskpro/controller/Authblock/Authbloc/auth_state.dart';
import 'package:taskpro/controller/Authblock/Imagebloc/image_bloc.dart';
import 'package:taskpro/widgets/signupform.dart';
import 'package:taskpro/widgets/signupformvalidations.dart';
import 'package:taskpro/widgets/signupsnakbar.dart';

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
              title: Customtextforsignup(
                  text: 'Sign Up', color: Colors.white, fontsize: 10),
              centerTitle: true,
            ),
            body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
              if (state is AuthSuccess) {
                CustomSnackBar.authenticationresultsnakbar(
                    context, 'Singed Successfully', Colors.green);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Homescreen()),
                  (route) => false,
                );
              }
              if (state is AuthFailure) {
                CustomSnackBar.authenticationresultsnakbar(context, state.error,
                    const Color.fromARGB(255, 234, 106, 97));
                print(state.error);
              }
            }, builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                  padding:
                      const EdgeInsets.only(left: 29, right: 29, bottom: 10),
                  child: SingleChildScrollView(
                      child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Form(
                              key: formKey,
                              child: Column(children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Customtextforsignup(
                                          text: 'taskpro',
                                          color: primarycolour,
                                          fontsize: 28)
                                    ]),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        BlocBuilder<ImageBloc, ImageState>(
                                          builder: (context, state) {
                                            if (state is Profileimageselected) {
                                              return GestureDetector(
                                                onLongPress: () {
                                                  showFullImage(
                                                    context,
                                                    state.imagefile,
                                                    'profile',
                                                  );
                                                },
                                                child: CircleAvatar(
                                                  backgroundImage: FileImage(
                                                      state.imagefile),
                                                  maxRadius: 53,
                                                ),
                                              );
                                            } else {
                                              return const CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    'lib/Assets/user-image.png'),
                                                maxRadius: 53,
                                              );
                                            }
                                          },
                                        ),
                                        Positioned(
                                          top: 70,
                                          left: 65,
                                          child: CustomDialogButton(
                                            onImageSelected: (image) =>
                                                BlocProvider.of<ImageBloc>(
                                                        context)
                                                    .add(
                                                        Selectedprifileimageevent(
                                                            image: image)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(children: [
                                  Expanded(
                                      child: Signupform(
                                          icon: const Icon(
                                              Icons.person_2_outlined),
                                          textCapitalization:
                                              TextCapitalization.words,
                                          controler: utilities.firrstname,
                                          hinttext: 'First Name',
                                          validator: validateforname)),
                                  const SizedBox(width: 20),
                                  Expanded(
                                      child: Signupform(
                                          icon: const Icon(
                                              Icons.person_2_outlined),
                                          textCapitalization:
                                              TextCapitalization.none,
                                          controler: utilities.lastname,
                                          hinttext: 'Last Name',
                                          validator: validateforname))
                                ]),
                                const SizedBox(height: 15),
                                Signupform(
                                    icon: const Icon(
                                        Icons.alternate_email_outlined),
                                    textCapitalization: TextCapitalization.none,
                                    controler: utilities.email,
                                    hinttext: 'Email',
                                    keybordtype: TextInputType.emailAddress,
                                    validator: validateformail),
                                const SizedBox(height: 17),
                                Signupform(
                                    icon: const Icon(
                                        Icons.remove_red_eye_outlined),
                                    textCapitalization: TextCapitalization.none,
                                    controler: utilities.password,
                                    hinttext: 'Password'),
                                const SizedBox(height: 17),
                                Signupform(
                                    controler: utilities.phonenumber,
                                    validator: validatePhoneNumber,
                                    hinttext: 'Phone Number',
                                    keybordtype: TextInputType.number,
                                    icon: const Icon(Icons.phone_rounded)),
                                const SizedBox(height: 17),
                                TextFormField(
                                    readOnly: true,
                                    onTap: () async {
                                      final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Mapviewpage()));

                                      if (result != null) {
                                        setState(() {
                                          utilities.selectedLocationLatLng =
                                              result['location'];
                                          utilities.location.text =
                                              result['place'];
                                        });
                                      }
                                    },
                                    controller: utilities.location,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        borderSide:
                                            BorderSide(color: primarycolour),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
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
                                      hintText: 'Location',
                                      prefixIcon: const Icon(
                                          Icons.location_on_outlined),
                                      hintStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: primarycolour,
                                          fontSize: 13),
                                    ),
                                    validator: (value) {
                                      if (utilities.selectedLocationLatLng ==
                                          null) {
                                        return 'Location is required';
                                      }
                                      return null;
                                    }),
                                const SizedBox(height: 20),
                                Signupform(
                                    icon: const Icon(Icons.book_outlined),
                                    textCapitalization:
                                        TextCapitalization.words,
                                    controler: utilities.maxqualification,
                                    hinttext: 'Max Qualification',
                                    validator: validateforqualification),
                                const SizedBox(height: 20),
                                Row(children: [
                                  Expanded(
                                      child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 17),
                                            prefixIcon:
                                                const Icon(Icons.work_outline),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      17, 46, 64, 1.0)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[400]!),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                  color: Colors.red),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                  color: Colors.red),
                                            ),
                                            labelText: 'Work Type',
                                            labelStyle: const TextStyle(
                                                color: primarycolour,
                                                fontSize: 12),
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
                                              utilities.selectedWorkType =
                                                  newValue;
                                            });
                                          },
                                          validator: (value) {
                                            if (utilities.selectedWorkType ==
                                                    null ||
                                                utilities.selectedWorkType!
                                                    .isEmpty) {
                                              return 'Choose your work';
                                            }
                                            return null;
                                          }))
                                ]),
                                const SizedBox(height: 36),
                                Row(children: [
                                  Stack(children: [
                                    BlocBuilder<ImageBloc, ImageState>(
                                      builder: (context, state) {
                                        if (state
                                            is Aadhaarfrontimageselected) {
                                          return Aadharcntainer(
                                              aaadharpic:
                                                  XFile(state.imagefile.path),
                                              showFullImage: showFullImage);
                                        } else {
                                          return Aadharcntainer(
                                              aaadharpic: null,
                                              showFullImage: showFullImage);
                                        }
                                      },
                                    ),
                                    Positioned(
                                        top: 47,
                                        left: 114,
                                        child: CustomDialogButton(
                                            onImageSelected: (image) =>
                                                BlocProvider.of<ImageBloc>(
                                                        context)
                                                    .add(
                                                        Selectedaadharfrontimageevent(
                                                            image: image))))
                                  ]),
                                  const SizedBox(width: 16),
                                  Stack(children: [
                                    BlocBuilder<ImageBloc, ImageState>(
                                      builder: (context, state) {
                                        if (state is Aadharbackimageselected) {
                                          return Aadharcntainer(
                                            aaadharpic:
                                                XFile(state.imagefile.path),
                                            showFullImage: showFullImage,
                                          );
                                        } else {
                                          return Aadharcntainer(
                                              aaadharpic: null,
                                              showFullImage: showFullImage);
                                        }
                                      },
                                    ),
                                    Positioned(
                                        top: 47,
                                        left: 114,
                                        child: CustomDialogButton(
                                            onImageSelected: (image) =>
                                                BlocProvider.of<ImageBloc>(
                                                  context,
                                                ).add(
                                                    Selectedaadharbackimageevent(
                                                        image: image))))
                                  ])
                                ]),
                                Padding(
                                    padding:
                                        const EdgeInsets.only(top: 8, left: 20),
                                    child: Row(children: [
                                      utilities.aadharfornt != null
                                          ? Expanded(
                                              child: Aadhartext(
                                                  text: 'Aadhar Frontside',
                                                  fontWeight: FontWeight.bold))
                                          : Expanded(
                                              child: Aadhartext(
                                                  text: 'Aadhar Frontside',
                                                  fontWeight:
                                                      FontWeight.normal)),
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
                                                  fontWeight:
                                                      FontWeight.normal))
                                    ])),
                                const SizedBox(height: 10),
                                const SizedBox(height: 20),
                                Signupform(
                                    icon: const Icon(Icons.info_outline),
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    controler: utilities.about,
                                    hinttext: 'About',
                                    minline: 1,
                                    maxline: null,
                                    maxlength: 500,
                                    validator: validateforabout),
                                const SizedBox(height: 20),
                                Customtextforsignup(
                                    text:
                                        'Your phone number and location help us match you with the right Client.',
                                    fontsize: 11,
                                    fontWeight: FontWeight.w400),
                                const SizedBox(height: 20),
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
                                              firstName: utilities
                                                  .firrstname.text,
                                              lastName: utilities.lastname.text,
                                              phoneNumber: utilities
                                                  .phonenumber.text,
                                              location: utilities.location.text,
                                              maxQualification: utilities
                                                  .maxqualification.text,
                                              workType:
                                                  utilities.selectedWorkType ??
                                                      '',
                                              about: utilities.about.text,
                                              aadharBack: utilities.aadharback,
                                              aadharFront:
                                                  utilities.aadharfornt,
                                              profileImage:
                                                  utilities.profileimage));
                                    } else if (utilities.aadharback == null ||
                                        utilities.aadharfornt == null ||
                                        utilities.profileimage == null) {
                                      if (utilities.aadharback == null &&
                                          utilities.aadharfornt == null &&
                                          utilities.profileimage == null) {
                                        CustomSnackBar
                                            .authenticationresultsnakbar(
                                                context,
                                                'Add Image details',
                                                Colors.red);
                                      } else if (utilities.aadharback == null ||
                                          utilities.aadharfornt == null) {
                                        CustomSnackBar
                                            .authenticationresultsnakbar(
                                                context,
                                                'Add your Aadhaar details',
                                                Colors.red);
                                      } else {
                                        CustomSnackBar
                                            .authenticationresultsnakbar(
                                                context,
                                                'Add your Photo',
                                                Colors.red);
                                      }
                                    }
                                  },
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll(primarycolour),
                                      fixedSize: WidgetStatePropertyAll(
                                          Size(400, 60))),
                                  child: Customtextforsignup(
                                      text: 'Sign Up', color: Colors.white),
                                ),
                                const SizedBox(height: 20),
                                Customtextforsignup(
                                    text: 'By signing up, you agree to our'),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                          onTap: () {},
                                          child: Customtextforsignup(
                                              text: 'Terms of services,',
                                              color: const Color.fromARGB(
                                                  255, 22, 115, 191))),
                                      Customtextforsignup(text: 'and'),
                                      GestureDetector(
                                          onTap: () {},
                                          child: Customtextforsignup(
                                              text: 'Privacy Policy',
                                              color: const Color.fromARGB(
                                                  255, 22, 115, 191)))
                                    ]),
                                const SizedBox(height: 50),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Customtextforsignup(
                                          text: 'Already have an account ?'),
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Logingscreen()));
                                          },
                                          child: Customtextforsignup(
                                              text: ' Log in',
                                              color: const Color.fromARGB(
                                                  255, 22, 115, 191)))
                                    ])
                              ])))));
            })));
  }
}
