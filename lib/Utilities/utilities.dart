import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Utilities {
  XFile? profileimage;
  XFile? aadharfornt;
  XFile? aadharback;
  String? editprofileimg;
  String? editaadharfrontimg;
  String? editaadharbackimg;
  var firrstname = TextEditingController();
  var lastname = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var phonenumber = TextEditingController();
  var location = TextEditingController();
  var maxqualification = TextEditingController();
  var worktype = TextEditingController();
  var about = TextEditingController();
  String? selectedWorkType;
  LatLng? selectedLocationLatLng;
  final List<String> workerTypes = [
    'Electrician',
    'Plumber',
    'Cleaner',
    'Painter',
    'Mounting Specialist',
    'Carpenter',
    'HVAC Technician',
    'Roofer',
    'Landscaper',
    'Mason',
    'Welder',
    'General Contractor',
    'Tiler',
    'Handyman',
    'Glazier',
    'Locksmith',
    'Pest Control Specialist',
    'Flooring Installer',
    'Drywall Installer',
    'Plasterer',
    'Window Installer',
    'Door Installer',
    'Ceiling Specialist',
    'Solar Panel Installer',
    'Home Security Installer',
  ];
}
