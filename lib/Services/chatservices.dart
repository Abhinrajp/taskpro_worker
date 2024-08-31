import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskpro/Model/messagemodel.dart';

class Chatservices {
  Future<void> sendmessage(
      String reciverid, String sendernme, message, type) async {
    final String senderid = FirebaseAuth.instance.currentUser!.uid;
    final String sendername = sendernme;
    final Timestamp timestamp = Timestamp.now();

    Messagemodel messagemodel = Messagemodel(
        senderid: senderid,
        sendername: sendername,
        reciverid: reciverid,
        message: message,
        timestamp: timestamp,
        type: type,
        status: 'pending');

    List<String> ids = [senderid, reciverid];
    ids.sort();
    String chatroomid = ids.join('_');

    DocumentReference chatroomRef =
        FirebaseFirestore.instance.collection('chat_rooms').doc(chatroomid);

    // Fetch current chatroom data
    DocumentSnapshot chatroomSnapshot = await chatroomRef.get();

    // Retrieve and cast the 'lastseen' field as Map<String, dynamic>
    Map<String, dynamic>? lastseenData =
        chatroomSnapshot.data() as Map<String, dynamic>?;

    // Convert dynamic map to Map<String, Timestamp>
    Map<String, Timestamp> lastseen = {};
    if (lastseenData != null && lastseenData.containsKey('lastseen')) {
      var lastseenMap = lastseenData['lastseen'] as Map<String, dynamic>;
      lastseenMap.forEach((key, value) {
        if (value is Timestamp) {
          lastseen[key] = value as Timestamp;
        }
      });
    }

    // Update the sender's lastseen timestamp
    lastseen[senderid] = timestamp;

    // Save the updated 'lastseen' map
    await chatroomRef.set({
      'participants': ids,
      'message': message,
      'timestamp': timestamp,
      'lastseen': lastseen,
    }, SetOptions(merge: true));

    await chatroomRef.collection('messages').add(messagemodel.tomap());
  }

  Stream<QuerySnapshot> getmessages(String userid, otheruserid) {
    List<String> ids = [userid, otheruserid];
    ids.sort();
    String chatroomid = ids.join('_');
    return FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatroomid)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<DocumentSnapshot?> getlastmessage(
      String userid, String otheruserid) async {
    List<String> ids = [userid, otheruserid];
    ids.sort();
    String chatroomid = ids.join('_');
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatroomid)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      return null;
    }
  }

  // Future<int> getunseenmsgcount(String userid, otheruserid) async {
  //   try {
  //     List<String> ids = [userid, otheruserid];
  //     ids.sort();
  //     String chatroomid = ids.join('_');
  //     DocumentSnapshot chatroomsnapshot = await FirebaseFirestore.instance
  //         .collection('chat_rooms')
  //         .doc(chatroomid)
  //         .get();
  //     Timestamp? lastseen =
  //         chatroomsnapshot['lastseen']?[userid] ?? Timestamp(0, 0);
  //     QuerySnapshot unseenmsg = await FirebaseFirestore.instance
  //         .collection('chat_rooms')
  //         .doc(chatroomid)
  //         .collection('messages')
  //         .where('timestamp', isGreaterThan: lastseen)
  //         .get();
  //     return unseenmsg.docs.length;
  //   } catch (e) {
  //     log("Error in getunseenmsgcount: $e");
  //     return 0;
  //   }
  // }
  Future<int> getunseenmsgcount(String userid, String otheruserid) async {
    try {
      List<String> ids = [userid, otheruserid];
      ids.sort();
      String chatroomid = ids.join('_');

      DocumentSnapshot chatroomSnapshot = await FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(chatroomid)
          .get();

      // Retrieve and cast the 'lastseen' field as Map<String, dynamic>
      Map<String, dynamic>? lastseenData =
          chatroomSnapshot.data() as Map<String, dynamic>?;

      // Convert the dynamic map to a map with String keys and Timestamp values
      Timestamp lastseen = Timestamp(0, 0);
      if (lastseenData != null && lastseenData['lastseen'] != null) {
        var lastseenMap = lastseenData['lastseen'] as Map<String, dynamic>;
        lastseen = lastseenMap.containsKey(userid)
            ? (lastseenMap[userid] as Timestamp)
            : Timestamp(0, 0);
      }

      // Log the last seen timestamp
      log("Last seen timestamp for user $userid: $lastseen");

      // Query unseen messages
      QuerySnapshot unseenMsg = await FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(chatroomid)
          .collection('messages')
          .where('timestamp', isGreaterThan: lastseen)
          .get();

      // Log the number of unseen messages
      log("Unseen messages count: ${unseenMsg.docs.length}");

      return unseenMsg.docs.length;
    } catch (e) {
      log("Error in getunseenmsgcount: $e");
      return 0;
    }
  }

  Future<void> updateLastSeen(String currentUserId, String otherUserId) async {
    List<String> ids = [currentUserId, otherUserId];
    ids.sort();
    String chatroomid = ids.join('_');

    DocumentReference chatroomRef =
        FirebaseFirestore.instance.collection('chat_rooms').doc(chatroomid);

    await chatroomRef.update({
      'lastseen.$currentUserId': Timestamp.now(),
    });
  }

  Future<void> updateLastSeenForOtherUser(
      String currentUserId, String otherUserId) async {
    List<String> ids = [currentUserId, otherUserId];
    ids.sort();
    String chatroomid = ids.join('_');

    DocumentReference chatroomRef =
        FirebaseFirestore.instance.collection('chat_rooms').doc(chatroomid);

    await chatroomRef.update({
      'lastseen.$otherUserId': Timestamp.now(),
    });
  }
}
