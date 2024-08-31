import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:taskpro/View/Chat/messagescreen.dart';
import 'package:taskpro/Utilities/const.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Scheduledworks {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  Stream<List<Map<String, dynamic>>> get schedulestream {
    if (user != null) {
      return firebaseFirestore
          .collection('workers')
          .doc(user!.uid)
          .collection('schedule')
          .snapshots()
          .map((snapshot) {
        final DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
        String fromatednow = dateFormat.format(DateTime.now());
        DateTime currentdate = dateFormat.parse(fromatednow);
        List<Map<String, dynamic>> schedules =
            snapshot.docs.map((doc) => doc.data()).where((schedule) {
          DateTime scheduledDate = dateFormat.parse(schedule['date']);
          return scheduledDate.isAtSameMomentAs(currentdate) ||
              scheduledDate.isAfter(currentdate);
        }).toList();

        // Sort by date in descending order
        schedules.sort((a, b) {
          DateTime dateA = dateFormat.parse(a['date']);
          DateTime dateB = dateFormat.parse(b['date']);
          return dateA.compareTo(dateB);
        });

        return schedules;
      });
    } else {
      return const Stream.empty();
    }
  }

  Widget streamschedule() {
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: schedulestream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(alignment: Alignment.center, children: [
                  SizedBox(
                      height: 220,
                      width: 220,
                      child: LottieBuilder.asset('lib/Assets/t6MrC2ql2w.json')),
                  const Positioned(
                      top: 103,
                      left: 71,
                      child: Customtext(
                          text: 'No Schedules',
                          fontWeight: FontWeight.bold,
                          fontsize: 9))
                ]),
                const Customtext(
                    text: 'No Scheduled works',
                    fontWeight: FontWeight.bold,
                    fontsize: 17)
              ],
            );
          }
          var schdules = snapshot.data;
          return ListView.builder(
              itemBuilder: (context, index) {
                var user = schdules[index];
                final userimage = user['profileimage'];

                return Padding(
                    padding: const EdgeInsets.all(6),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Messagescreen(worker: user)));
                        },
                        child: Card(
                            elevation: 0,
                            child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(.1),
                                          offset: const Offset(2, 1),
                                          spreadRadius: 1,
                                          blurStyle: BlurStyle.outer)
                                    ],
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(35),
                                        topLeft: Radius.circular(35))),
                                height: 90,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 20),
                                      userimage.length == 1
                                          ? CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.blue,
                                              child: Text(userimage,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 30)))
                                          : Stack(children: [
                                              const CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage: AssetImage(
                                                      'lib/Assets/User-Profile-PNG.png')),
                                              CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.grey,
                                                  backgroundImage:
                                                      NetworkImage(userimage))
                                            ]),
                                      const SizedBox(width: 30),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Customtext(
                                                text: user['name'],
                                                fontWeight: FontWeight.bold,
                                                fontsize: 14),
                                            const SizedBox(height: 5),
                                            Customtext(
                                                text: user['date'],
                                                color: Colors.grey,
                                                fontsize: 12)
                                          ])
                                    ])))));
              },
              itemCount: schdules!.length);
        });
  }
}
