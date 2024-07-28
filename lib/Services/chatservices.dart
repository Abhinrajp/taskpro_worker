import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskpro/Model/messagemodel.dart';

class Chatservices {
  sendmessage(String reciverid, String sendernme, message) async {
    final String senderid = FirebaseAuth.instance.currentUser!.uid;
    final String sendername = sendernme;
    final Timestamp timestamp = Timestamp.now();

    Messagemodel messagemodel = Messagemodel(
        senderid: senderid,
        sendername: sendername,
        reciverid: reciverid,
        message: message,
        timestamp: timestamp);

    List<String> ids = [senderid, reciverid];
    ids.sort();
    String chatroomid = ids.join('_');

    DocumentReference chatroomeference =
        FirebaseFirestore.instance.collection('chat_rooms').doc(chatroomid);

    chatroomeference.set({
      'participants': ids,
      'message': message,
      'timestamp': timestamp,
    }, SetOptions(merge: true));

    await chatroomeference.collection('messages').add(messagemodel.tomap());
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
}
