import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpro/View/Notification/notificationscreen.dart';
import 'package:taskpro/View/Profile/profilescreen.dart';
import 'package:taskpro/View/authentication/Login/loginscreen.dart';
import 'package:taskpro/controller/Fetchbloc/fetchuser_bloc.dart';
import 'package:taskpro/widgets/popups/signupsnakbar.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    context.read<FetchuserBloc>().add(Fetchuser());
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    CustomPopups customPopups = CustomPopups();
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: BlocBuilder<FetchuserBloc, FetchuserState>(
                builder: (context, state) {
              if (state is FetchuserLoaded) {
                final userdata = state.userdata;
                var profileimage = userdata.profileimage;
                var place = extractplace(userdata.location);
                log(userdata.location);
                return Column(children: [
                  SizedBox(
                      width: 360,
                      child: PreferredSize(
                          preferredSize: const Size.fromHeight(26),
                          child: AppBar(
                              leadingWidth: double.infinity,
                              leading: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on,
                                        size: 17, color: Colors.red[900]),
                                    const SizedBox(height: 8),
                                    Customtext(text: place)
                                  ]),
                              actions: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Notificationscreen(),
                                                ));
                                          },
                                          icon: const Icon(
                                              Icons.notifications_active)),
                                      const SizedBox(width: 35),
                                      InkWell(
                                          splashColor: Colors.white38,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            radius: 20,
                                            backgroundImage:
                                                NetworkImage(profileimage),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profilescreen(
                                                            tag: 'img',
                                                            usermodel:
                                                                userdata)));
                                          })
                                    ])
                              ]))),
                  Center(child: Text('${user!.email}'))
                ]);
              } else if (state is FetchuserLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchuserError) {
                return Center(child: Text(state.error));
              } else {
                return const Center(child: Text('No data'));
              }
            })),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            log('logout clicked');
            customPopups.alertboxforconfirmation(
                context, () => signout(context, user!));
          },
          child: const Icon(Icons.exit_to_app),
        ));
  }

  signout(BuildContext context, User user) async {
    await FirebaseAuth.instance.signOut();
    CustomPopups.authenticationresultsnakbar(
        context, 'Logout from ${user.email}', Colors.red);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const Logingscreen(),
      ),
      (route) => false,
    );
  }

  String extractplace(String location) {
    List<String> parts = location.split(',');
    parts = parts.map((part) => part.trim()).toList();
    if (parts.length >= 4) {
      if (parts[parts.length - 3].isNotEmpty) {
        return parts[parts.length - 3];
      } else {
        return parts[parts.length - 4];
      }
    } else if (parts.length >= 3) {
      return parts[parts.length - 3];
    }
    return 'Unknown';
  }
}
