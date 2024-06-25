import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final LatLng? location;
  final String maxQualification;
  final String workType;
  final String about;
  final XFile? profileImage;
  final XFile? aadharFront;
  final XFile? aadharBack;

  const SignUpRequested({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.location,
    required this.maxQualification,
    required this.workType,
    required this.about,
    this.profileImage,
    this.aadharFront,
    this.aadharBack,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        firstName,
        lastName,
        phoneNumber,
        location,
        maxQualification,
        workType,
        about,
        profileImage,
        aadharFront,
        aadharBack,
      ];
}
