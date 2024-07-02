import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskpro/controller/Authblock/bloc/auth_event.dart';
import 'package:taskpro/controller/Authblock/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  final FirebaseFirestore firestore;
  AuthBloc(this.firebaseAuth, this.firebaseStorage, this.firestore)
      : super(AuthInitial()) {
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        print('reached');
        UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
                email: event.email, password: event.password);
        User? user = userCredential.user;
        String? profileimageurl;
        String? aadharfrontimageurl;
        String? aadharbackimageurl;
        log('reached');
        if (event.profileImage != null) {
          profileimageurl = await uploadFile(
              event.profileImage!, 'profile_images/${user?.uid}.jpg');
        }
        if (event.aadharFront != null) {
          aadharfrontimageurl = await uploadFile(
              event.aadharFront!, 'aadhar_front/${user?.uid}.jpg');
        }
        if (event.aadharBack != null) {
          aadharbackimageurl = await uploadFile(
              event.aadharBack!, 'aadhar_back/${user?.uid}.jpg');
        }
        log(event.phoneNumber);
        await firestore.collection('workers').doc().set({
          'firstName': event.firstName,
          'lastName': event.lastName,
          'phoneNumber': event.phoneNumber,
          'location': event.location,
          'maxQualification': event.maxQualification,
          'workType': event.workType,
          'about': event.about,
          'profileImageUrl': profileimageurl,
          'aadharFrontUrl': aadharfrontimageurl,
          'aadharBackUrl': aadharbackimageurl,
        });
        log('i think added');
        emit(AuthSuccess());
      } catch (e) {
        log('error during sign up : ${e.toString()}');
        emit(AuthFailure(e.toString()));
      }
    });
  }
  Future<String> uploadFile(XFile file, String path) async {
    try {
      final File localfile = File(file.path);
      if (!await localfile.exists()) {
        throw Exception('File does not exist at path : ${file.path}');
      }
      Reference storageReference = firebaseStorage.ref().child(path);
      UploadTask uploadTask = storageReference.putFile(localfile);
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('failed to upload file : ${e.toString()}');
      rethrow;
    }
  }
}
