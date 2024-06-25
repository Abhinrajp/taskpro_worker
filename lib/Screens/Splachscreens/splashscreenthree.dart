import 'package:flutter/material.dart';
import 'package:taskpro/Screens/authentication/signupscreen.dart';
import 'package:taskpro/const.dart';

class SplashscreenThree extends StatelessWidget {
  const SplashscreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.only(top: 100, left: 10, right: 10),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              style:
                                  TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                  (route) => false);
                            },
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          width: 300,
                          child: Text(
                            'Chat with your client to schedule the job and complete it',
                            style: TextStyle(fontWeight: FontWeight.w600),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8, left: 49),
                          child: Container(
                            height: 70,
                            width: 100,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(153, 202, 201, 201),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: const Padding(
                              padding:
                                  EdgeInsets.only(top: 8, right: 8, left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 13),
                                    child: Text('Hi there!'),
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '11:00 am',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 10),
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('lib/Assets/user-icon-man.png'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 120,
                              width: 190,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(153, 202, 201, 201),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Am ready for the work, is 8:00 am is oke for you ?'),
                                    Padding(
                                      padding: EdgeInsets.only(top: 7),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '11:00 am',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 80,
                              width: 190,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(42, 100, 136, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 12),
                                      child: Text(
                                        'Yes. That’s ok for me',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 7),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '11:00 am',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('lib/Assets/user-icon-women.png'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ]))));
  }
}
