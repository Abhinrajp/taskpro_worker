import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskpro/Services/chatservices.dart';
import 'package:taskpro/View/Chat/messagescreen.dart';
import 'package:taskpro/Utilities/const.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Chathistoryscreen extends StatefulWidget {
  const Chathistoryscreen({super.key});

  @override
  State<Chathistoryscreen> createState() => _ChathistoryscreenState();
}

// final currentuser = FirebaseAuth.instance.currentUser!.uid;
Chatservices chatservices = Chatservices();

class _ChathistoryscreenState extends State<Chathistoryscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: appbar(context),
        body: body());
  }
}

AppBar appbar(BuildContext context) {
  return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Customtext(
          text: 'Messages',
          fontWeight: FontWeight.bold,
          fontsize: 22,
          color: primarycolour),
      centerTitle: true);
}

Widget body() {
  return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!userSnapshot.hasData) {
          return const Center(child: Text('Please log in'));
        }

        final currentUser = userSnapshot.data!.uid;

        return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chat_rooms')
                .where('participants', arrayContains: currentUser)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return emptychathistory();
              }
              final List<DocumentSnapshot> chatrooms = snapshot.data!.docs;
              final Set<String> otheruserid = {};
              for (var chatroom in chatrooms) {
                final List<dynamic> participates = chatroom['participants'];
                participates.forEach((participant) {
                  if (participant != currentUser) {
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
                      return emptychathistory();
                    }
                    final List<DocumentSnapshot> users = snapshot.data!.docs;
                    return buildchathistory(users, currentUser);
                  });
            });
      });
}

Widget emptychathistory() {
  return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Padding(
      padding: const EdgeInsets.only(left: 110),
      child: Image.asset('lib/Assets/nomsg.png'),
    ),
    const Customtext(
      text: 'No messages',
      fontWeight: FontWeight.bold,
      fontsize: 15,
    ),
    const Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: Customtext(
            text: 'Try to connect with someone',
            fontWeight: FontWeight.bold,
            fontsize: 13))
  ]));
}

Widget buildchathistory(
    List<DocumentSnapshot<Object?>> users, String currentUser) {
  return ListView.builder(
      itemBuilder: (context, index) {
        Widget profileWidget;
        final userdata = users[index];
        final String userid = userdata.id;
        final username = userdata['name'];
        final userimage = userdata['profileimage'];
        userimage.length == 1
            ? profileWidget = CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue,
                child: Text(userimage,
                    style: const TextStyle(color: Colors.white, fontSize: 30)))
            : profileWidget = Image.network(
                height: 100.0, width: 100, userimage, fit: BoxFit.cover);
        return detailsofbuildchathistory(
            userid, currentUser, username, profileWidget, userdata);
      },
      itemCount: users.length);
}

Widget detailsofbuildchathistory(String userid, currentUser, username,
    Widget profileWidget, DocumentSnapshot<Object?> userdata) {
  return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        chatservices.getlastmessage(currentUser, userid),
        chatservices.getunseenmsgcount(currentUser, userid)
      ]),
      builder: (context, snapshot) {
        String lastmessage = '';
        String lastMessageTime = '';
        int unseenmsgcount = 0;

        if (snapshot.hasData && snapshot.data != null) {
          final List<dynamic> data = snapshot.data as List<dynamic>;

          // Handle last message data
          final lastmessagedata = data[0]?.data() as Map<String, dynamic>?;
          if (lastmessagedata != null) {
            final Timestamp timestamp = lastmessagedata['timestamp'];
            lastMessageTime = DateFormat('hh:mm a').format(timestamp.toDate());
            lastmessage = lastmessagedata['message'] ?? '';
          }

          // Handle unseen message count
          unseenmsgcount = data[1] ?? 0;
        }

        return listtileofchathistory(context, userdata, profileWidget, username,
            lastmessage, lastMessageTime, unseenmsgcount);
      });
}

Widget listtileofchathistory(
    BuildContext context,
    DocumentSnapshot<Object?> userdata,
    Widget profileWidget,
    String username,
    lastmessage,
    lastMessageTime,
    int unseenmsgcount) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Messagescreen(
                    worker: userdata.data() as Map<String, dynamic>)));
      },
      child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: ListTile(
              leading: Stack(children: [
                const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        AssetImage('lib/Assets/User-Profile-PNG.png')),
                CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(child: profileWidget))
              ]),
              title: Customtext(
                  text: username, fontWeight: FontWeight.bold, fontsize: 14),
              subtitle: Customtext(
                  text: lastmessage, fontsize: 12, color: Colors.grey),
              trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Customtext(text: lastMessageTime),
                    unseenmsgcount > 0
                        ? CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.green,
                            child: Customtext(
                                text: unseenmsgcount.toString(),
                                color: Colors.white),
                          )
                        : const SizedBox()
                  ]))));
}
