import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskpro/Services/authservices.dart';
import 'package:taskpro/Services/revenueservice.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Paymenthistoryscreen extends StatefulWidget {
  const Paymenthistoryscreen({super.key});

  @override
  State<Paymenthistoryscreen> createState() => _PaymenthistoryscreenState();
}

final Authservices authservices = Authservices();

final Revenueservice revenueservice = Revenueservice();

class _PaymenthistoryscreenState extends State<Paymenthistoryscreen> {
  var workerid = authservices.fetchworkerid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appbar(), body: body());
  }
}

AppBar appbar() {
  return AppBar(
      title: const Customtext(
          text: 'Payments', fontsize: 18, fontWeight: FontWeight.bold),
      centerTitle: true);
}

Widget body() {
  return FutureBuilder(
      future: revenueservice.fetchrevenue(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          log(snapshot.error.toString());
          return const Center(
              child: Customtext(text: 'Oops somethig workng happening'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                SizedBox(
                    height: 250,
                    child: Image.asset('lib/Assets/no-revenue.png')),
                const Customtext(
                    text: 'No Payments yet done ',
                    fontWeight: FontWeight.bold,
                    fontsize: 16)
              ]));
        }
        Map<String, dynamic> data = snapshot.data!;
        double totalToday = data['totaltoday'];
        double totalThisMonth = data['totalthismonth'];
        double totalPreviousMonth = data['totalpreviousmonth'];
        double totalThisYear = data['totalthisyear'];
        List<Map<String, dynamic>> revenueList = data['revenuelist'];
        return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    amountfiltercontainer(
                        totalToday.toString(), '''today 's total payment'''),
                    const SizedBox(width: 15),
                    amountfiltercontainer(totalPreviousMonth.toString(),
                        '''Last month total payment'''),
                    const SizedBox(width: 15),
                    amountfiltercontainer(totalThisMonth.toString(),
                        '''This month total payment'''),
                    const SizedBox(width: 15),
                    amountfiltercontainer(
                        totalThisYear.toString(), '''This year total payment''')
                  ])),
              const SizedBox(height: 25),
              Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        var revenue = revenueList[index];
                        var datestr = revenue['date'];
                        DateTime date = DateTime.parse(datestr);
                        String formatdate = DateFormat('dd-MMM-yyyy')
                            .format(date)
                            .toLowerCase();
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Colors.grey.withOpacity(.2)),
                                child: ListTile(
                                    title: Customtext(
                                        text: '${revenue['user']}',
                                        fontWeight: FontWeight.bold,
                                        fontsize: 14),
                                    subtitle: Customtext(
                                        text: formatdate,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey),
                                    trailing: Customtext(
                                        text: '₹ ${revenue['amount']}',
                                        fontWeight: FontWeight.bold,
                                        fontsize: 16))));
                      },
                      itemCount: revenueList.length))
            ]));
      });
}

Widget amountfiltercontainer(String amount, title) {
  return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Color(0xFFECE7D9),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(children: [
        Customtext(text: title, fontWeight: FontWeight.bold),
        Customtext(
            text: '₹ $amount ', fontsize: 18, fontWeight: FontWeight.bold)
      ]));
}
