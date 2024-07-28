import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskpro/Services/chatservices.dart';
import 'package:taskpro/View/Chat/schedulescreen.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Messagescreen extends StatefulWidget {
  final Map<String, dynamic> worker;
  const Messagescreen({super.key, required this.worker});

  @override
  State<Messagescreen> createState() => _MessagescreenState();
}

class _MessagescreenState extends State<Messagescreen> {
  final messagecontroller = TextEditingController();
  final Chatservices chatservices = Chatservices();

  void sendmessage() async {
    var name = widget.worker['name'];
    if (messagecontroller.text.isNotEmpty) {
      chatservices.sendmessage(
          widget.worker['id'], name, messagecontroller.text);
      messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    var name = widget.worker['name'];
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 350,
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            const SizedBox(width: 20),
            CircleAvatar(
                backgroundImage: NetworkImage(widget.worker['profileimage'])),
            const SizedBox(width: 20),
            Customtext(
              text: name,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Schedulescreen(
                              tag: 'tag',
                            )));
              },
              icon: const Icon(Icons.calendar_month_rounded)),
          const SizedBox(width: 10),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call_rounded)),
          const SizedBox(width: 20)
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(child: messagelist()),
          inputmessage()
        ],
      ),
    );
  }

  Widget messagelist() {
    String semderid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: chatservices.getmessages(widget.worker['id'], semderid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Customtext(text: snapshot.error.toString()),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs.map((doc) => messageitem(doc)).toList(),
        );
      },
    );
  }

  Widget messageitem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool iscurrentuser =
        data['senderid'] == FirebaseAuth.instance.currentUser!.uid;
    return Column(
        crossAxisAlignment:
            iscurrentuser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Container(
                  decoration: BoxDecoration(
                      color: iscurrentuser
                          ? primarycolour.withOpacity(.8)
                          : Colors.grey.withOpacity(.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Customtext(
                          text: data['message'],
                          color:
                              iscurrentuser ? Colors.white : Colors.black)))),
        ]);
  }

  Widget inputmessage() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Expanded(
              child: TextFormField(
            minLines: 1,
            maxLines: null,
            textCapitalization: TextCapitalization.sentences,
            controller: messagecontroller,
            decoration: InputDecoration(
                hintStyle: const TextStyle(fontSize: 13),
                filled: true,
                fillColor: Colors.grey.withOpacity(.2),
                hintText: 'Type something ...',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(.2)),
                    borderRadius: const BorderRadius.all(Radius.circular(50)))),
          )),
          const SizedBox(width: 8),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(primarycolour),
                  minimumSize: WidgetStatePropertyAll(Size(10, 60))),
              onPressed: sendmessage,
              child:
                  const Icon(Icons.send_rounded, size: 28, color: Colors.white))
        ]));
  }
}
