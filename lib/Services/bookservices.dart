import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Bookedservices {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  Stream<Set<DateTime>> get scheduleddatestream {
    if (user != null) {
      return firebaseFirestore
          .collection('workers')
          .doc(user!.uid)
          .collection('schedule')
          .snapshots()
          .map((snapshot) {
        final DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
        String formateddatenow = dateFormat.format(DateTime.now());
        DateTime currentdate = dateFormat.parse(formateddatenow);
        Set<DateTime> scheduleddates = snapshot.docs
            .map((doc) {
              DateTime scheduledDate = dateFormat.parse(doc.data()['date']);
              return DateTime(
                  scheduledDate.year, scheduledDate.month, scheduledDate.day);
            })
            .where((schdedate) =>
                schdedate.isAtSameMomentAs(currentdate) ||
                schdedate.isAfter(currentdate))
            .toSet();
        log(scheduleddates.toString());
        return scheduleddates;
      });
    } else {
      return const Stream.empty();
    }
  }
}
