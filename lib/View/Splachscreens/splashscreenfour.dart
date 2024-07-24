import 'package:flutter/material.dart';
import 'package:taskpro/const.dart';

class SplashscreenFour extends StatelessWidget {
  const SplashscreenFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: const EdgeInsets.only(top: 100, left: 10, right: 10),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text(
            'taskpro',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const Text(
            'taskpro',
            style: TextStyle(
                fontSize: 20,
                color: primarycolour,
                fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45, right: 15),
            child: GestureDetector(
              child: const Text(
                'Skip ',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              onTap: () {},
            ),
          ),
        ]),
        const SizedBox(
          height: 60,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 300,
              child: Text(
                'Manage your tasks and build our inner circle of clients.',
                style: TextStyle(fontWeight: FontWeight.w600),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ]),
        ),
        const SizedBox(
          height: 60,
        ),
        Container(
          height: 100,
          width: 250,
          color: const Color.fromARGB(153, 237, 237, 237),
          child: const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Abhinraj p',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '12/6/2024',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text('10:00 AM', style: TextStyle(color: Colors.grey))
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      maxRadius: 35,
                      backgroundImage:
                          AssetImage('lib/Assets/user-icon-man.png'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(153, 237, 237, 237),
              border: Border.symmetric(
                vertical: BorderSide(color: primarycolour),
                horizontal: BorderSide(color: primarycolour),
              )),
          height: 125,
          width: 285,
          child: Padding(
            padding: const EdgeInsets.only(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 125,
                  width: 10,
                  color: const Color.fromARGB(255, 238, 215, 7),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Teza',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                    ),
                    Text(
                      '1 unread meassage',
                      style: TextStyle(
                          color: Color.fromARGB(255, 238, 215, 7),
                          fontWeight: FontWeight.w800),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                          size: 24,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '3/7/2024',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: Colors.grey,
                          size: 24,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text('8:30 AM',
                            style: TextStyle(color: Colors.grey, fontSize: 14))
                      ],
                    )
                  ],
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      maxRadius: 40,
                      backgroundImage:
                          AssetImage('lib/Assets/user-icon-women.png'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          height: 100,
          width: 250,
          color: const Color.fromARGB(153, 237, 237, 237),
          child: const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Roney',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '20/7/2024',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text('9:00 AM', style: TextStyle(color: Colors.grey))
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      maxRadius: 35,
                      backgroundImage:
                          AssetImage('lib/Assets/user-icon-officer.png'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    )));
  }
}
