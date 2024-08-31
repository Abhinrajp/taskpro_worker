import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:taskpro/Functions/customfunctions.dart';
import 'package:taskpro/Model/model.dart';
import 'package:taskpro/Services/authservices.dart';
import 'package:taskpro/View/Home/scheduledworks.dart';
import 'package:taskpro/View/Settings/settingsscreen.dart';
import 'package:taskpro/View/Profile/profilescreen.dart';
import 'package:taskpro/Utilities/const.dart';
import 'package:taskpro/controller/Fetchbloc/fetchuser_bloc.dart';
import 'package:taskpro/widgets/popups/signupsnakbar.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

final user = FirebaseAuth.instance.currentUser;
final Scheduledworks scheduledworks = Scheduledworks();
CustomPopups customPopups = CustomPopups();
Authservices authservices = Authservices();
String popupsettings = 'Settings';
String popupProfile = 'Profile';

final Customfunctions customfunctions = Customfunctions();

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    context.read<FetchuserBloc>().add(Fetchuser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: body());
  }

  AppBar appbar(
      BuildContext context, String place, profileimage, Modelclass userdata) {
    return AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leadingWidth: double.infinity,
        leading:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.location_on, size: 17, color: Colors.red[900]),
          const SizedBox(height: 8),
          Customtext(text: place)
        ]),
        actions: [appbaraction(profileimage, userdata)]);
  }

  Widget appbaraction(String profileimage, Modelclass userdata) {
    return Row(children: [
      InkWell(
          splashColor: Colors.white38,
          child: Stack(children: [
            const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('lib/Assets/User-Profile-PNG.png')),
            CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 20,
                backgroundImage: NetworkImage(profileimage)),
          ]),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Profilescreen(tag: 'img', usermodel: userdata)));
          }),
      const SizedBox(width: 10),
      PopupMenuButton(
          color: Theme.of(context).scaffoldBackgroundColor,
          itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profilescreen(
                                tag: 'img', usermodel: userdata)));
                  },
                  value: popupProfile,
                  child: Customtext(text: popupProfile),
                ),
                PopupMenuItem(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Settingsscreen(usermodel: userdata)));
                    },
                    value: popupsettings,
                    child: Customtext(text: popupsettings))
              ])
    ]);
  }

  Widget body() {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: BlocBuilder<FetchuserBloc, FetchuserState>(
            builder: (context, state) {
          if (state is FetchuserLoaded) {
            final userdata = state.userdata;
            var profileimage = userdata.profileimage;
            var place = customfunctions.extractplace(userdata.location);
            log(userdata.location);
            return Stack(children: [
              Column(children: [
                Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: appbar(context, place, profileimage, userdata)),
                Expanded(child: Center(child: scheduledworks.streamschedule()))
              ]),
              Positioned(
                  top: 110,
                  left: 25,
                  child: Row(children: [
                    Customtext(
                        text: 'Scheduled works',
                        fontWeight: FontWeight.bold,
                        fontsize: 18,
                        color: primarycolour.withOpacity(.8))
                  ]))
            ]);
          } else if (state is FetchuserLoading) {
            return Center(
                child: SizedBox(
                    height: 70,
                    child: LottieBuilder.asset('lib/Assets/wsh0QqtlX0.json')));
          } else if (state is FetchuserError) {
            return Center(child: Customtext(text: state.error));
          } else {
            return const Center(child: Customtext(text: 'No data'));
          }
        }));
  }
}
