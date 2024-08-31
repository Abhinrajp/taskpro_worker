import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpro/View/Chat/chathistoryscreen.dart';
import 'package:taskpro/View/Home/homescreen.dart';

import 'package:taskpro/Utilities/const.dart';
import 'package:taskpro/controller/Bottombar/bottombar_bloc.dart';
import 'package:taskpro/widgets/decorationwidget.dart';

class Homebottomnavigationbar extends StatefulWidget {
  const Homebottomnavigationbar({super.key});

  @override
  State<Homebottomnavigationbar> createState() =>
      _HomebottomnavigationbarState();
}

class _HomebottomnavigationbarState extends State<Homebottomnavigationbar> {
  @override
  Widget build(BuildContext context) {
    double displaywidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocBuilder<BottombarBloc, BottombarState>(
            builder: (context, state) {
          return IndexedStack(
              index: state.currentIndex,
              children: const [Homescreen(), Chathistoryscreen()]);
        }),
        bottomNavigationBar: BlocBuilder<BottombarBloc, BottombarState>(
          builder: (context, state) {
            return Container(
                margin: EdgeInsets.all(displaywidth * .05),
                height: displaywidth * .155,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 30,
                          offset: const Offset(0, 10))
                    ],
                    borderRadius: BorderRadius.circular(50)),
                child: ListView.builder(
                    itemCount: 2,
                    scrollDirection: Axis.horizontal,
                    padding:
                        EdgeInsets.symmetric(horizontal: displaywidth * .02),
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          context
                              .read<BottombarBloc>()
                              .add(Tabchangeevent(index));
                          HapticFeedback.lightImpact();
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Stack(children: [
                          Customeanimatedcontainer(
                              width: index == state.currentIndex
                                  ? displaywidth * 0.42
                                  : displaywidth * 0.18,
                              child: AnimatedContainer(
                                  duration: const Duration(seconds: 2),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  height: index == state.currentIndex
                                      ? displaywidth * 0.13
                                      : 0,
                                  width: index == state.currentIndex
                                      ? displaywidth * 0.42
                                      : 0,
                                  decoration: BoxDecoration(
                                      color: index == state.currentIndex
                                          ? primarycolour
                                          : Colors.transparent,
                                      borderRadius:
                                          BorderRadius.circular(50)))),
                          Customeanimatedcontainer(
                              width: index == state.currentIndex
                                  ? displaywidth * 0.63
                                  : displaywidth * 0.42,
                              child: Stack(children: [
                                Row(children: [
                                  Container(
                                      width: index == state.currentIndex
                                          ? displaywidth * 0.06
                                          : 0),
                                  AnimatedOpacity(
                                      opacity:
                                          index == state.currentIndex ? 1 : 0,
                                      duration: const Duration(seconds: 2),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: Text(
                                          index == state.currentIndex
                                              ? listofstring[index]
                                              : '',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15)))
                                ]),
                                Row(children: [
                                  Customeanimatedcontainer(
                                      width: index == state.currentIndex
                                          ? displaywidth * 0.3
                                          : 20),
                                  Icon(listoficon[index],
                                      size: displaywidth * 0.076,
                                      color: index == state.currentIndex
                                          ? Colors.white
                                          : Colors.black)
                                ])
                              ]))
                        ]))));
          },
        ));
  }

  List<String> listofstring = ['Home', 'Message'];
  List<IconData> listoficon = [
    Icons.home_rounded,
    Icons.chat,
  ];
}
