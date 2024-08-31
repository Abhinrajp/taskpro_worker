import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskpro/View/authentication/Login/loginscreen.dart';
import 'package:taskpro/View/authentication/Signup/email_verifying.dart';
import 'package:taskpro/View/authentication/Signup/mapview.dart';
import 'package:taskpro/Utilities/utilities.dart';
import 'package:taskpro/Utilities/const.dart';
import 'package:taskpro/controller/Authblock/Authbloc/auth_bloc.dart';
import 'package:taskpro/controller/Authblock/Authbloc/auth_state.dart';
import 'package:taskpro/controller/Authblock/Imagebloc/image_bloc.dart';
import 'package:taskpro/controller/Authblock/Mailbloc/mail_bloc.dart';
import 'package:taskpro/controller/Authblock/Mapbloc/map_bloc.dart';
import 'package:taskpro/widgets/signupwidget/signupform.dart';
import 'package:taskpro/widgets/signupwidget/signupformvalidations.dart';
import 'package:taskpro/widgets/popups/signupsnakbar.dart';
import 'package:taskpro/widgets/signupwidget/signupbutton.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final formKey = GlobalKey<FormState>();
Utilities utilities = Utilities();
User? user;
final auth = FirebaseAuth.instance;

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          primarycolour,
          Colors.white,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(backgroundColor: Colors.transparent),
            body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
              if (state is AuthSuccess) {
                log('Auth block success');
                context.read<MailBloc>().add(StartedEmailverrification());
                CustomPopups.authenticationresultsnakbar(context,
                    'Verification mail send to your mail', primarycolour);
                clearFields();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmailVerifying()));
              }
              if (state is AuthFailure) {
                final onlyerror = extractErrorMessage(state.error);
                log(state.error.characters.toString());
                CustomPopups.authenticationresultsnakbar(context, onlyerror,
                    const Color.fromARGB(255, 234, 106, 97));
              }
            }, builder: (context, state) {
              if (state is AuthLoading) {
                return Center(child: Image.asset('lib/Assets/Authloading.gif'));
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
                                      Text('taskpro',
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold))
                                    ]),
                                const SizedBox(height: 20),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Stack(children: [
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
                                        }),
                                        Positioned(
                                            top: 70,
                                            left: 65,
                                            child: CustomDialogButton(
                                                onImageSelected: (image) =>
                                                    BlocProvider.of<ImageBloc>(
                                                            context)
                                                        .add(
                                                            Selectedprifileimageevent(
                                                                image: image))))
                                      ])
                                    ]),
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
                                    dropdownvalue: utilities.selectedWorkType),
                                const SizedBox(height: 36),
                                Row(children: [
                                  Stack(children: [
                                    BlocBuilder<ImageBloc, ImageState>(
                                        builder: (context, state) {
                                      if (state is Aadhaarfrontimageselected) {
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
                                    }),
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
                                            showFullImage: showFullImage);
                                      } else {
                                        return Aadharcntainer(
                                            aaadharpic: utilities.aadharback,
                                            showFullImage: showFullImage);
                                      }
                                    }),
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
                                        text: 'Aadhar Backside',
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
                                const Customtext(
                                    text:
                                        'Your phone number and location help us match you with the right Client.',
                                    fontsize: 11,
                                    fontWeight: FontWeight.w400),
                                const SizedBox(height: 20),
                                const Signupbutton(),
                                const SizedBox(height: 20),
                                const Customtext(
                                    text: 'By signing up, you agree to our'),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                          onTap: () {},
                                          child: const Customtext(
                                              text: 'Terms of services,',
                                              color: Color.fromARGB(
                                                  255, 22, 115, 191))),
                                      const Customtext(text: 'and'),
                                      GestureDetector(
                                          onTap: () {},
                                          child: const Customtext(
                                              text: 'Privacy Policy',
                                              color: Color.fromARGB(
                                                  255, 22, 115, 191)))
                                    ]),
                                const SizedBox(height: 50),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Customtext(
                                          text: 'Already have an account ?'),
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Logingscreen()));
                                          },
                                          child: const Customtext(
                                              text: ' Log in',
                                              color: Color.fromARGB(
                                                  255, 22, 115, 191)))
                                    ]),
                                const SizedBox(height: 20)
                              ])))));
            })));
  }

  clearFields() {
    utilities.email.clear();
    utilities.password.clear();
    utilities.firrstname.clear();
    utilities.lastname.clear();
    utilities.phonenumber.clear();
    utilities.location.clear();
    utilities.maxqualification.clear();
    utilities.worktype.clear();
    utilities.about.clear();
    utilities.aadharback = null;
    utilities.aadharfornt = null;
    utilities.profileimage = null;
  }
}
