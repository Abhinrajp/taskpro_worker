import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/controller/Schedulebloc/Datebloc/date_bloc.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Schedulescreen extends StatefulWidget {
  final String tag;
  const Schedulescreen({super.key, required this.tag});

  @override
  State<Schedulescreen> createState() => _SchedulescreenState();
}

class _SchedulescreenState extends State<Schedulescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            title: const Customtext(
                text: 'Schedule',
                fontWeight: FontWeight.bold,
                fontsize: 22,
                color: Colors.white),
            backgroundColor: primarycolour,
            centerTitle: true),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 50),
            Text(
              'Reserve the date',
              style: GoogleFonts.robotoMono(
                  color: primarycolour,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            BlocBuilder<DateBloc, DateState>(builder: (context, state) {
              DateTime selecteddate = DateTime.now();
              if (state is Dateselectedstate) {
                selecteddate = state.selecteddate;
              }
              return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(children: [
                        Hero(
                          tag: widget.tag,
                          child: TableCalendar(
                              daysOfWeekHeight: 40,
                              headerStyle: HeaderStyle(
                                  headerPadding: const EdgeInsets.all(17),
                                  rightChevronIcon: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                  ),
                                  leftChevronIcon: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: primarycolour,
                                  ),
                                  titleCentered: true,
                                  formatButtonVisible: false,
                                  titleTextFormatter: (date, locale) {
                                    return DateFormat('EE-MMM-yyyy', locale)
                                        .format(date);
                                  },
                                  titleTextStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  decoration: const BoxDecoration(
                                      color: primarycolour)),
                              focusedDay: selecteddate,
                              firstDay: DateTime(1900),
                              lastDay: DateTime(2200),
                              selectedDayPredicate: (day) {
                                return isSameDay(selecteddate, day);
                              },
                              onDaySelected: (selecteddate, focusedDay) {
                                context
                                    .read<DateBloc>()
                                    .add(Dateseletedevent(selecteddate));
                              },
                              calendarStyle: CalendarStyle(
                                  selectedDecoration: const BoxDecoration(
                                      color: primarycolour,
                                      shape: BoxShape.circle),
                                  todayDecoration: BoxDecoration(
                                      color: primarycolour.withOpacity(.2),
                                      shape: BoxShape.circle))),
                        ),
                        const SizedBox(height: 15)
                      ])));
            }),
            const SizedBox(height: 15),
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(primarycolour),
                    minimumSize: WidgetStatePropertyAll(Size(200, 60)),
                    maximumSize: WidgetStatePropertyAll(Size(250, 60))),
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Customtext(
                        text: 'Schedule now',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.white,
                    )
                  ],
                ))
          ]),
        ));
  }
}
