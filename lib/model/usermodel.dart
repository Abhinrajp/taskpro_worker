import 'package:image_picker/image_picker.dart';

class Usermodel {
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

  Usermodel(
      {required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.location,
      required this.maxQualification,
      required this.workType,
      required this.about,
      required this.profileImage,
      required this.aadharFront,
      required this.aadharBack});
  tojson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'location': location,
      'maxQualification': maxQualification,
      'workType': workType,
      'about': about,
      'profileImageUrl': profileImage,
      'aadharFrontUrl': aadharFront,
      'aadharBackUrl': aadharBack,
    };
  }
}
