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
  final String location;
  final String maxQualification;
  final String workType;
  final String about;
  final XFile? profileImage;
  final XFile? aadharFront;
  final XFile? aadharBack;
  final String registerd;

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
    this.registerd = 'registerd',
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
        registerd,
        profileImage,
        aadharFront,
        aadharBack,
      ];
}
