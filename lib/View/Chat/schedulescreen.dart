import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskpro/Services/bookservices.dart';
import 'package:taskpro/Services/chatservices.dart';
import 'package:taskpro/Utilities/const.dart';
import 'package:taskpro/controller/Schedulebloc/Datebloc/date_bloc.dart';
import 'package:taskpro/widgets/Schedule/schdulewidget.dart';
import 'package:taskpro/widgets/popups/alertmessages.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Schedulescreen extends StatefulWidget {
  final Map<String, dynamic> worker;
  final String tag;
  const Schedulescreen({super.key, required this.tag, required this.worker});

  @override
  State<Schedulescreen> createState() => _SchedulescreenState();
}

final Chatservices chatservices = Chatservices();
final Schdulewidget schdulewidget = Schdulewidget();
Alertmessages alertmessages = Alertmessages();
final Bookedservices bookedservices = Bookedservices();

class _SchedulescreenState extends State<Schedulescreen> {
  DateTime selecteddate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: appbar(context),
        body: BlocBuilder<DateBloc, DateState>(builder: (context, state) {
          if (state is Dateselectedstate) {
            selecteddate = state.selecteddate;
          }
          return StreamBuilder(
              stream: bookedservices.scheduleddatestream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError || !snapshot.hasData) {
                  return const Center(
                      child: Customtext(
                          text: 'Oops, something wrong is happening'));
                }
                final Set<DateTime> scheduledDates = snapshot.data!;

                return SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      const SizedBox(height: 50),
                      Text('Reserve the date',
                          style: GoogleFonts.robotoMono(
                              color: primarycolour,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 30),
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                              decoration: BoxDecoration(border: Border.all()),
                              child: Column(children: [
                                Hero(
                                    tag: widget.tag,
                                    child: schdulewidget.schedulecalender(
                                        context, selecteddate, scheduledDates)),
                                const SizedBox(height: 15)
                              ]))),
                      const SizedBox(height: 15),
                      schdulewidget.dateselectbutton(
                          sendbuttonmessage, context, selecteddate)
                    ]));
              });
        }));
  }

  void sendbuttonmessage(String message) async {
    var name = widget.worker['name'];
    chatservices.sendmessage(widget.worker['id'], name, message, 'schedule');
  }
}

AppBar appbar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
    ),
    title: const Customtext(
      text: 'Schedule',
      fontWeight: FontWeight.bold,
      fontsize: 22,
      color: Colors.white,
    ),
    backgroundColor: primarycolour,
    centerTitle: true,
  );
}
