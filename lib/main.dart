import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpro/View/Splachscreens/splashscreenvideo.dart';
import 'package:taskpro/Utilities/const.dart';
import 'package:taskpro/controller/Authblock/Authbloc/auth_bloc.dart';
import 'package:taskpro/controller/Authblock/Imagebloc/image_bloc.dart';
import 'package:taskpro/controller/Authblock/Mailbloc/mail_bloc.dart';
import 'package:taskpro/controller/Authblock/Mapbloc/map_bloc.dart';
import 'package:taskpro/controller/Bottombar/bottombar_bloc.dart';
import 'package:taskpro/controller/Editimagebloc/editimage_bloc.dart';
import 'package:taskpro/controller/Fetchbloc/fetchuser_bloc.dart';
import 'package:taskpro/controller/Paswwordblock/password_bloc.dart';
import 'package:taskpro/controller/Schedulebloc/Datebloc/date_bloc.dart';
import 'package:taskpro/controller/Themeblock/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            FirebaseAuth.instance,
            FirebaseStorage.instance,
            FirebaseFirestore.instance,
          ),
        ),
        BlocProvider(create: (context) => ImageBloc()),
        BlocProvider(create: (context) => MapBloc()),
        BlocProvider(create: (context) => MailBloc()),
        BlocProvider(create: (context) => FetchuserBloc()),
        BlocProvider(create: (context) => BottombarBloc()),
        BlocProvider(create: (context) => DateBloc()),
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => PasswordBloc()),
        BlocProvider(create: (context) => EditimageBloc()),
        BlocProvider(create: (context) => EditfrontimageBloc()),
        BlocProvider(create: (context) => EditbackimageBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
              title: 'taskpro',
              debugShowCheckedModeBanner: false,
              theme: (state as Themechange).themeData,
              home: const Splashscreenvideo());
        },
      ),
    );
  }
}
