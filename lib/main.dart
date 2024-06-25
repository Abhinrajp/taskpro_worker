import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpro/Screens/Splachscreens/splashscreenvideo.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/controller/Authblock/bloc/auth_bloc.dart';

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
          )
        ],
        child: MaterialApp(
          title: 'taskpro',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: primarycolour),
            useMaterial3: true,
          ),
          home: const Splashscreenvideo(),
        ));
  }
}
