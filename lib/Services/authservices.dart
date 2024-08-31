import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskpro/Model/updatemodel.dart';
import 'package:taskpro/View/Home/scheduledworks.dart';
import 'package:taskpro/View/authentication/Login/loginscreen.dart';
import 'package:taskpro/Utilities/const.dart';
import 'package:taskpro/widgets/popups/signupsnakbar.dart';

class Authservices {
  final Scheduledworks schedulesworks = Scheduledworks();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

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

  Stream<List<Map<String, dynamic>>> fetchhistory() {
    // final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;

    return firebaseFirestore
        .collection('workers')
        .doc(user!.uid)
        .collection('history')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<String> fetchuserpass() async {
    final user = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('workers')
        .doc(user?.uid)
        .get();
    final pass = data['password'];
    return pass;
  }

  Future<String> fetchworkerid() async {
    final user = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('workers')
        .doc(user?.uid)
        .get();
    final pass = data['id'];
    return pass;
  }

  changepassword(BuildContext context, String newpass, String pass) async {
    log(newpass);
    try {
      log('entered to try');
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        AuthCredential credential =
            EmailAuthProvider.credential(email: user.email!, password: pass);
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newpass);
        await FirebaseFirestore.instance
            .collection('workers')
            .doc(user.uid)
            .update({'password': newpass});
        CustomPopups.authenticationresultsnakbar(context,
            'Password changed successfully Login again', primarycolour);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Logingscreen(),
          ),
          (route) => false,
        );
        await FirebaseAuth.instance.signOut();
      } else {
        log('user not found');
      }
    } catch (e) {
      log(e.toString());
      CustomPopups.authenticationresultsnakbar(
          context, e.toString(), Colors.red);
    }
  }

  updateuser(BuildContext context, Updatemodel updatemodel) async {
    User? user = FirebaseAuth.instance.currentUser;
    String? profileimageurl;
    String? aadharfrontimageurl;
    String? aadharbackimageurl;
    log(updatemodel.editaadharfrontimg.toString());
    profileimageurl = await uploadFile(
        XFile(updatemodel.editprofileimg), 'profile_images/${user?.uid}.jpg');
    aadharfrontimageurl = await uploadFile(
        XFile(updatemodel.editaadharfrontimg), 'aadhar_front/${user?.uid}.jpg');
    aadharbackimageurl = await uploadFile(
        XFile(updatemodel.editaadharbackimg), 'aadhar_back/${user?.uid}.jpg');

    try {
      if (user != null) {
        await firebaseFirestore.collection('workers').doc(user.uid).update({
          'firstName': updatemodel.firrstname,
          'lastName': updatemodel.lastname,
          'phoneNumber': updatemodel.phonenumber,
          'location': updatemodel.location,
          'maxQualification': updatemodel.maxqualification,
          'about': updatemodel.about,
          'registerd': updatemodel.register,
          'profileImageUrl': profileimageurl,
          'aadharFrontUrl': aadharfrontimageurl,
          'aadharBackUrl': aadharbackimageurl,
        });
      }
      CustomPopups.authenticationresultsnakbar(
          context, 'Profile updated successfully', primarycolour);
      Navigator.pop(context);
    } catch (e) {
      CustomPopups.authenticationresultsnakbar(
          context, e.toString(), Colors.red);
    }
  }

  Future<String> uploadFile(XFile file, String path) async {
    if (file.path.startsWith('http')) {
      return file.path;
    }
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
      log('failed to upload file : ${e.toString()}');
      rethrow;
    }
  }
}
