import 'package:google_maps_flutter/google_maps_flutter.dart';

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your Phone number';
  } else if (value.length < 10) {
    return 'Phone number must be 10 digits';
  }
  return null;
}

String? validateforname(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your Name';
  }
  return null;
}

String? validateforpassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your Password';
  }
  return null;
}

String? validateforlocation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Choose your Location';
  }
  return null;
}

String? validateforqualification(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your Qualification';
  }
  return null;
}

String? validateforwork(String? value) {
  if (value == null || value.isEmpty) {
    return 'Choose your Worktype';
  }
  return null;
}

String? validateforabout(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter About you';
  }
  return null;
}

String? validateformail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your Email';
  } else if (!emailregexp.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

final RegExp emailregexp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false, multiLine: false);
