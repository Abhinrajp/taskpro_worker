import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskpro/Services/chatservices.dart';
import 'package:taskpro/View/Chat/schedulescreen.dart';
import 'package:taskpro/Utilities/const.dart';
import 'package:taskpro/widgets/popups/signupsnakbar.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Messagescreenwidget {
  // final messagecontroller = TextEditingController();
  final Chatservices chatservices = Chatservices();
  final paymentcontroller = TextEditingController();
  Widget profilewidget(Map<String, dynamic> worker) {
    var profileimg = worker['profileimage'];
    return profileimg.length == 1
        ? CircleAvatar(
            radius: 23,
            backgroundColor: Colors.blue,
            child: Text(profileimg,
                style: const TextStyle(color: Colors.white, fontSize: 30)))
        : Image.network(
            height: 100.0, width: 100, profileimg, fit: BoxFit.cover);
  }

  Widget messagelist(Map<String, dynamic> worker) {
    String semderid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
        stream: chatservices.getmessages(worker['id'], semderid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Customtext(text: snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
              children:
                  snapshot.data!.docs.map((doc) => messageitem(doc)).toList());
        });
  }

  Widget messageitem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool iscurrentuser =
        data['senderid'] == FirebaseAuth.instance.currentUser!.uid;
    String buttontype = data['type'];
    return Column(
        crossAxisAlignment:
            iscurrentuser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          data['type'] == 'text'
              ? textmessageitem(data, iscurrentuser)
              : buttonmessageitem(data, iscurrentuser, buttontype)
        ]);
  }

  Widget textmessageitem(Map<String, dynamic> data, bool iscurrentuser) {
    log(data['timestamp'].toString());
    Timestamp timestamp = data['timestamp'];
    String time = getTimeFromTimestamp(timestamp);
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
        child: Container(
            decoration: BoxDecoration(
                color: iscurrentuser
                    ? primarycolour.withOpacity(.8)
                    : Colors.grey.withOpacity(.5),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 14, right: 14, top: 14, bottom: 8),
                child: Column(
                  crossAxisAlignment: iscurrentuser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Customtext(
                        text: data['message'],
                        color: iscurrentuser ? Colors.white : Colors.black),
                    Customtext(
                        text: time,
                        color: iscurrentuser ? Colors.white : Colors.blueGrey,
                        fontsize: 9)
                  ],
                ))));
  }

  String getTimeFromTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }

  Widget buttonmessageitem(
      Map<String, dynamic> data, bool iscurrentuser, String buttontype) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
        child: buttontype == 'payment'
            ? paymentbutton(buttontype, data)
            : schedulebutton(buttontype, data));
  }

  Widget schedulebutton(String buttontype, Map<String, dynamic> data) {
    Timestamp timestamp = data['timestamp'];
    String time = getTimeFromTimestamp(timestamp);
    return data['status'] == 'failed'
        ? worksuccessmsgbutton(Colors.grey.withOpacity(.2),
            const Color(0xFF6E6E6E), data['message'], time, 'Canceled')
        : data['status'] == 'success'
            ? worksuccessmsgbutton(Colors.green.withOpacity(.3),
                const Color(0xFF6E6E6E), data['message'], time, 'is confirmed')
            : Container(
                width: 290,
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.3),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(children: [
                      const Customtext(
                          text: 'You Scheduled work on',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontsize: 14),
                      const SizedBox(height: 10),
                      Customtext(
                          text: data['message'],
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontsize: 16),
                      const SizedBox(height: 10),
                      Padding(
                          padding: const EdgeInsets.only(right: 200),
                          child: Customtext(
                              text: time, color: Colors.black, fontsize: 9))
                    ])));
  }

  Widget worksuccessmsgbutton(
      Color containerecolor, textcolor, String message, time, status) {
    return Container(
        width: 290,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: containerecolor),
        child: Padding(
            padding: const EdgeInsets.all(14),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Customtext(
                    text: 'Work Scheduled on ',
                    fontWeight: FontWeight.bold,
                    fontsize: 10,
                    color: textcolor),
                Customtext(
                    text: message, fontWeight: FontWeight.bold, fontsize: 12)
              ]),
              Customtext(
                  text: status,
                  fontWeight: FontWeight.bold,
                  fontsize: 12,
                  color: const Color(0xFF6E6E6E)),
              Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child:
                      Customtext(text: time, color: Colors.black, fontsize: 9))
            ])));
  }

  Widget paymentbutton(String buttontype, Map<String, dynamic> data) {
    Timestamp timestamp = data['timestamp'];
    String time = getTimeFromTimestamp(timestamp);
    return data['status'] == 'pending'
        ? Container(
            width: 290,
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(.3),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(children: [
                  const Customtext(
                      text: 'Payment amount of',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontsize: 14),
                  const SizedBox(height: 10),
                  Customtext(
                      text: '₹ ${data['message']}',
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontsize: 16),
                  const SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.only(right: 200),
                      child: Customtext(
                          text: time, color: Colors.black, fontsize: 9))
                ])))
        : data['status'] == 'success'
            ? paymetreultbutton(data['message'], 'is Successfull', time,
                Colors.green.withOpacity(.3))
            : paymetreultbutton(
                data['message'], 'is Failed', time, Colors.red.withOpacity(.3));
  }

  Widget paymetreultbutton(String message, messagestatus, time, Color bgcolor) {
    return Container(
        width: 290,
        decoration: BoxDecoration(
            color: bgcolor,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
            padding: const EdgeInsets.all(14),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Customtext(
                    text: 'Payment of  ',
                    fontWeight: FontWeight.bold,
                    fontsize: 11,
                    color: Color(0xFF6E6E6E)),
                Customtext(
                    text: '₹$message  ',
                    fontWeight: FontWeight.bold,
                    fontsize: 14),
                Customtext(
                    text: messagestatus,
                    fontWeight: FontWeight.w900,
                    fontsize: 11,
                    color: const Color(0xFF6E6E6E)),
              ]),
              Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child:
                      Customtext(text: time, color: Colors.black, fontsize: 9))
            ])));
  }

  Widget inputmessage(void Function() sendtextmessage,
      TextEditingController messagecontroller) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Expanded(child: messagefeild(messagecontroller)),
          const SizedBox(width: 8),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(primarycolour),
                  minimumSize: WidgetStatePropertyAll(Size(10, 60))),
              onPressed: () {
                log('presssed send button');
                sendtextmessage();
              },
              child:
                  const Icon(Icons.send_rounded, size: 28, color: Colors.white))
        ]));
  }

  Widget messagefeild(TextEditingController messagecontroller) {
    return TextFormField(
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
                borderRadius: const BorderRadius.all(Radius.circular(50)))));
  }

  AppBar appbar(BuildContext context, Widget profilewidget, String name,
      Map<String, dynamic> worker, void Function() sendbuttonmessage) {
    return AppBar(
        leadingWidth: 260,
        leading: Row(children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          const SizedBox(width: 20),
          CircleAvatar(radius: 25, child: ClipOval(child: profilewidget)),
          const SizedBox(width: 20),
          Expanded(child: Customtext(text: name, fontWeight: FontWeight.bold))
        ]),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Schedulescreen(
                              worker: worker,
                              tag: 'tag',
                            )));
              },
              icon: const Icon(Icons.calendar_month_rounded)),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                            title: const Customtext(
                                text: 'Enter the amount',
                                fontWeight: FontWeight.bold,
                                fontsize: 15),
                            content:
                                TextFormField(controller: paymentcontroller),
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
              icon: const Icon(Icons.payment_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call_rounded)),
          const SizedBox(width: 5)
        ]);
  }
}
