import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskpro/View/Chat/messagescreen.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Chathistoryscreen extends StatefulWidget {
  const Chathistoryscreen({super.key});

  @override
  State<Chathistoryscreen> createState() => _ChathistoryscreenState();
}

class _ChathistoryscreenState extends State<Chathistoryscreen> {
  @override
  Widget build(BuildContext context) {
    final currentuser = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
        appBar: AppBar(
            title: const Customtext(
                text: 'Messages',
                fontWeight: FontWeight.bold,
                fontsize: 22,
                color: primarycolour),
            centerTitle: true),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chat_rooms')
                .where('participants', arrayContains: currentuser)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Customtext(text: 'No messages');
              }
              final List<DocumentSnapshot> chatrooms = snapshot.data!.docs;
              final Set<String> otheruserid = {};
              for (var chatroom in chatrooms) {
                final List<dynamic> participates = chatroom['participants'];
                participates.forEach((participant) {
                  if (participant != currentuser) {
                    otheruserid.add(participant);
                  }
                });
              }
              return FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .where(FieldPath.documentId,
                          whereIn: otheruserid.toList())
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Customtext(text: 'No messages');
                    }
                    final List<DocumentSnapshot> users = snapshot.data!.docs;
                    return ListView.builder(
                        itemBuilder: (context, index) {
                          final userdata = users[index];
                          final username = userdata['name'];
                          final userimage = userdata['profileimage'];
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Messagescreen(
                                            worker: userdata.data()
                                                as Map<String, dynamic>)));
                              },
                              child: Card(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: SizedBox(
                                      height: 90,
                                      width: double.infinity,
                                      child: Row(children: [
                                        const SizedBox(width: 20),
                                        CircleAvatar(
                                            minRadius: 26,
                                            backgroundImage:
                                                NetworkImage(userimage)),
                                        const SizedBox(width: 20),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Customtext(
                                                  text: username,
                                                  fontWeight: FontWeight.bold,
                                                  fontsize: 14),
                                              Customtext(
                                                  text: username,
                                                  fontsize: 12,
                                                  color: Colors.grey)
                                            ])
                                      ]))));
                        },
                        itemCount: users.length);
                  });
            }));
  }
}
