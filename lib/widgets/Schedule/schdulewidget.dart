import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskpro/View/Chat/schedulescreen.dart';
import 'package:taskpro/Utilities/const.dart';
import 'package:taskpro/controller/Schedulebloc/Datebloc/date_bloc.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Schdulewidget {
  Widget schedulecalender(BuildContext context, DateTime selecteddate,
      Set<DateTime> scheduledDates) {
    return TableCalendar(
        daysOfWeekHeight: 40,
        headerStyle: HeaderStyle(
            headerPadding: const EdgeInsets.all(17),
            rightChevronIcon: const Icon(Icons.arrow_forward_ios_rounded,
                color: Colors.white),
            leftChevronIcon: const Icon(Icons.arrow_forward_ios_rounded,
                color: primarycolour),
            titleCentered: true,
            formatButtonVisible: false,
            titleTextFormatter: (date, locale) {
              return DateFormat('EE-MMM-yyyy', locale).format(date);
            },
            titleTextStyle: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            decoration: const BoxDecoration(color: primarycolour)),
        focusedDay: selecteddate,
        firstDay: DateTime(1900),
        lastDay: DateTime(2200),
        enabledDayPredicate: (day) {
          return !day.isBefore(DateTime.now());
        },
        selectedDayPredicate: (day) {
          return isSameDay(selecteddate, day);
        },
        onDaySelected: (selecteddate, focusedDay) {
          log('the selected date is : $selecteddate.toString()');
          context.read<DateBloc>().add(Dateseletedevent(selecteddate));
        },
        calendarStyle: CalendarStyle(
            selectedDecoration: const BoxDecoration(
                color: primarycolour, shape: BoxShape.circle),
            todayDecoration: BoxDecoration(
                color: primarycolour.withOpacity(.2), shape: BoxShape.circle),
            markerDecoration:
                const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
        eventLoader: (day) {
          DateTime stripedday = DateTime(day.year, day.month, day.day);
          return scheduledDates.contains(stripedday) ? ['event'] : [];
        });
  }

  Widget dateselectbutton(void Function(String message) sendbuttonmessage,
      BuildContext context, DateTime selecteddate) {
    return ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(primarycolour),
            minimumSize: WidgetStatePropertyAll(Size(200, 60)),
            maximumSize: WidgetStatePropertyAll(Size(250, 60))),
        onPressed: () {
          log('the selected date is in side the button is : $selecteddate.toString()');
          sendbuttonmessage(DateFormat('d-MMM-yyyy').format(selecteddate));
          Navigator.pop(context);
          alertmessages.successmsg(context, QuickAlertType.success,
              'Work scheduled successfully', primarycolour);
        },
        child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Customtext(
                  text: 'Schedule now',
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              Icon(Icons.calendar_month_rounded, color: Colors.white)
            ]));
  }
}
