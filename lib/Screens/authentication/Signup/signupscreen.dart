import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:taskpro/Screens/Home/homescreen.dart';
import 'package:taskpro/Screens/authentication/Login/loginscreen.dart';
import 'package:taskpro/Screens/authentication/Signup/mapview.dart';
import 'package:taskpro/Utilities/utilities.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/controller/Authblock/Authbloc/auth_bloc.dart';
import 'package:taskpro/controller/Authblock/Authbloc/auth_state.dart';
import 'package:taskpro/controller/Authblock/Imagebloc/image_bloc.dart';
import 'package:taskpro/controller/Authblock/Mapbloc/map_bloc.dart';
import 'package:taskpro/widgets/signupwidget/signupform.dart';
import 'package:taskpro/widgets/signupwidget/signupformvalidations.dart';
import 'package:taskpro/widgets/signupsnakbar.dart';
import 'package:taskpro/widgets/signupwidget/signupbutton.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final formKey = GlobalKey<FormState>();
Utilities utilities = Utilities();

class _SignUpScreenState extends State<SignUpScreen> {
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
              }
            }, builder: (context, state) {
              if (state is AuthLoading) {
                return Center(
                  child:
                      LottieBuilder.asset('lib/Assets/signup-animation.json'),
                );
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
                                              utilities.profileimage =
                                                  XFile(state.imagefile.path);
                                              return Profilecircleavathar(
                                                  profilepic:
                                                      utilities.profileimage,
                                                  showFullImage: showFullImage);
                                            } else {
                                              return Profilecircleavathar(
                                                  profilepic:
                                                      utilities.profileimage,
                                                  showFullImage: showFullImage);
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
                                    validator: validateforpassword,
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
                                    maxlength: 10,
                                    icon: const Icon(Icons.phone_rounded)),
                                const SizedBox(height: 17),
                                BlocConsumer<MapBloc, MapState>(
                                    listener: (context, state) {
                                  if (state.selectedplace != null) {
                                    utilities.selectedLocationLatLng =
                                        state.selectedlocation;
                                    utilities.location.text =
                                        state.selectedplace!;
                                  }
                                }, builder: (context, state) {
                                  return Signupform(
                                      controler: utilities.location,
                                      keybordtype: TextInputType.none,
                                      maxlength: null,
                                      maxline: 1,
                                      minline: 1,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      hinttext: 'Location',
                                      validator: validateforlocation,
                                      readonly: true,
                                      icon: const Icon(
                                          Icons.location_on_outlined),
                                      onTap: () async {
                                        final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider.value(
                                                        value: context
                                                            .read<MapBloc>(),
                                                        child:
                                                            const Mapviewpage())));
                                        if (result != null) {
                                          context.read<MapBloc>().add(
                                              Locationselected(
                                                  result['location']));
                                          context.read<MapBloc>().fectplacename(
                                              result['location']);
                                        }
                                      });
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
                                Signupform(
                                  controler: utilities.worktype,
                                  hinttext: 'Work Type',
                                  icon: const Icon(Icons.work_outline),
                                  items: utilities.workerTypes,
                                  validator: validateforwork,
                                  dropdownvalue: utilities.selectedWorkType,
                                ),
                                const SizedBox(height: 36),
                                Row(children: [
                                  Stack(children: [
                                    BlocBuilder<ImageBloc, ImageState>(
                                      builder: (context, state) {
                                        if (state
                                            is Aadhaarfrontimageselected) {
                                          utilities.aadharfornt =
                                              XFile(state.imagefile.path);
                                          return Aadharcntainer(
                                              aaadharpic: utilities.aadharfornt,
                                              showFullImage: showFullImage);
                                        } else {
                                          return Aadharcntainer(
                                              aaadharpic: utilities.aadharfornt,
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
                                          utilities.aadharback =
                                              XFile(state.imagefile.path);
                                          return Aadharcntainer(
                                            aaadharpic: utilities.aadharback,
                                            showFullImage: showFullImage,
                                          );
                                        } else {
                                          return Aadharcntainer(
                                              aaadharpic: utilities.aadharback,
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
                                                        Selectedaadharbackimageevent(
                                                            image: image))))
                                  ])
                                ]),
                                Padding(
                                    padding:
                                        const EdgeInsets.only(top: 8, left: 20),
                                    child: Row(children: [
                                      Aadhartext(
                                        text: 'Aadhar Frontside',
                                        isbold: utilities.aadharfornt != null,
                                      ),
                                      const SizedBox(width: 20),
                                      Aadhartext(
                                        text: 'Aadhar Frontside',
                                        isbold: utilities.aadharback != null,
                                      )
                                    ])),
                                const SizedBox(height: 30),
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
                                const Signupbutton(),
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
