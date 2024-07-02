import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Utilities {
  XFile? profileimage;
  XFile? aadharfornt;
  XFile? aadharback;
  final firrstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phonenumber = TextEditingController();
  final location = TextEditingController();
  final maxqualification = TextEditingController();
  final worktype = TextEditingController();
  final about = TextEditingController();
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
