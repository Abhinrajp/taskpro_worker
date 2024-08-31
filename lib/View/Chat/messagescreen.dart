import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskpro/Services/chatservices.dart';
import 'package:taskpro/View/Chat/schedulescreen.dart';
import 'package:taskpro/Utilities/const.dart';
import 'package:taskpro/widgets/Message/messagewidget.dart';
import 'package:taskpro/widgets/popups/signupsnakbar.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Messagescreen extends StatefulWidget {
  final Map<String, dynamic> worker;
  const Messagescreen({super.key, required this.worker});

  @override
  State<Messagescreen> createState() => _MessagescreenState();
}

final messagecontroller = TextEditingController();
final Chatservices chatservices = Chatservices();
final paymentcontroller = TextEditingController();

final Messagescreenwidget messagescreenwidget = Messagescreenwidget();

class _MessagescreenState extends State<Messagescreen> {
  @override
  void initState() {
    super.initState();
    chatservices.updateLastSeen(
        FirebaseAuth.instance.currentUser!.uid, widget.worker['id']);
    // chatservices.updateLastSeenForOtherUser(
    //     widget.worker['id'], FirebaseAuth.instance.currentUser!.uid);
  }

  void sendtextmessage() async {
    var name = widget.worker['name'];
    if (messagecontroller.text.isNotEmpty) {
      chatservices.sendmessage(
          widget.worker['id'], name, messagecontroller.text, 'text');
      log(messagecontroller.text);
      messagecontroller.clear();
    }
  }

  void sendbuttonmessage() async {
    var name = widget.worker['name'];
    if (paymentcontroller.text.isNotEmpty) {
      chatservices.sendmessage(
          widget.worker['id'], name, paymentcontroller.text, 'payment');
      paymentcontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget profileimgwidget = messagescreenwidget.profilewidget(widget.worker);
    var name = widget.worker['name'];
    return Scaffold(
        appBar: appbar(
            context, profileimgwidget, name, widget.worker, sendbuttonmessage),
        body: Column(children: [
          const SizedBox(height: 20),
          Expanded(child: messagescreenwidget.messagelist(widget.worker)),
          messagescreenwidget.inputmessage(sendtextmessage, messagecontroller)
        ]));
  }
}

AppBar appbar(BuildContext context, Widget profilewidget, String name,
    Map<String, dynamic> worker, void Function() sendbuttonmessage) {
  return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leadingWidth: 238,
      leading: Row(children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        const SizedBox(width: 20),
        Stack(children: [
          const CircleAvatar(
              radius: 23,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('lib/Assets/User-Profile-PNG.png')),
          CircleAvatar(
              radius: 23,
              backgroundColor: Colors.transparent,
              child: ClipOval(child: profilewidget))
        ]),
        const SizedBox(width: 20),
        Expanded(child: Customtext(text: name, fontWeight: FontWeight.bold))
      ]),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Schedulescreen(worker: worker, tag: 'tag')));
            },
            icon: const Icon(Icons.calendar_month_rounded)),
        paymenticon(context, sendbuttonmessage),
        IconButton(onPressed: () {}, icon: const Icon(Icons.call_rounded)),
        const SizedBox(width: 5)
      ]);
}

Widget paymenticon(BuildContext context, void Function() sendbuttonmessage) {
  return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    title: const Customtext(
                        text: 'Enter the amount',
                        fontWeight: FontWeight.bold,
                        fontsize: 15),
                    content: TextFormField(controller: paymentcontroller),
                    actions: [
                      TextButton(
                          onPressed: () {
                            sendbuttonmessage();
                            CustomPopups.authenticationresultsnakbar(
                                context,
                                'payment request send successfully',
                                primarycolour);
                            Navigator.pop(context);
                          },
                          child: const Customtext(
                              text: 'Ok', fontWeight: FontWeight.bold))
                    ]));
      },
      icon: const Icon(Icons.payment_outlined));
}
