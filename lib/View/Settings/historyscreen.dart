import 'package:flutter/material.dart';
import 'package:taskpro/Services/authservices.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Historyscreen extends StatefulWidget {
  const Historyscreen({super.key});

  @override
  State<Historyscreen> createState() => _HistoryscreenState();
}

final Authservices authservices = Authservices();

class _HistoryscreenState extends State<Historyscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appbar(context),
      body: body(authservices.fetchhistory()),
    );
  }
}

AppBar appbar(BuildContext context) {
  return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Customtext(
          text: "History", fontWeight: FontWeight.bold, fontsize: 18),
      centerTitle: true);
}

Widget body(Stream<List<Map<String, dynamic>>> fetchhistory) {
  return Padding(
      padding: const EdgeInsets.all(10),
      child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: fetchhistory,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return emptyhistory();
            }
            var schedule = snapshot.data;
            return buildhistory(schedule);
          }));
}

Widget emptyhistory() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            height: 220,
            width: 220,
            child: Image.asset('lib/Assets/Emptyfav.png')),
        const Customtext(
            text: 'No Works are completed',
            fontWeight: FontWeight.bold,
            fontsize: 17)
      ]),
    ],
  );
}

Widget buildhistory(List<Map<String, dynamic>>? schedule) {
  return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: ListView.builder(
          itemBuilder: (context, index) {
            var user = schedule[index];
            return cardofschedule(user);
          },
          itemCount: schedule!.length));
}

Widget cardofschedule(Map<String, dynamic> user) {
  final userimage = user['profileimage'];
  return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Card(
          color: Colors.grey.withOpacity(.2),
          elevation: 0,
          child: SizedBox(
              height: 90,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                const SizedBox(width: 20),
                userimage.length == 1
                    ? CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        child: Text(userimage,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30)))
                    : Stack(children: [
                        const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                AssetImage('lib/Assets/User-Profile-PNG.png')),
                        CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(userimage))
                      ]),
                const SizedBox(width: 30),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Customtext(
                          text: user['name'],
                          fontWeight: FontWeight.bold,
                          fontsize: 13),
                      Row(children: [
                        const Icon(Icons.calendar_month_outlined,
                            color: Colors.grey, size: 20),
                        const SizedBox(width: 10),
                        Customtext(text: user['date'], color: Colors.grey)
                      ])
                    ])
              ]))));
}
