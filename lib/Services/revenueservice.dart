import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:taskpro/Services/authservices.dart';

class Revenueservice {
  final Authservices authservices = Authservices();

  Future<Map<String, dynamic>> fetchrevenue() async {
    var workerid = await authservices.fetchworkerid();
    DateTime now = DateTime.now();
    String todaydate = DateFormat('yyyy-MM-dd').format(now);
    String thismonth = DateFormat('yyyy-MM').format(now);
    String thisyear = DateFormat('yyyy').format(now);
    DateTime previousmonthdate = DateTime(now.year, now.month - 1, 1);
    String previousmonth = DateFormat('yyyy-MM').format(previousmonthdate);

    double todaytotal = 0;
    double thisprevmonthtotal = 0;
    double thismonthtotal = 0;
    double thisyeartotal = 0;

    List<Map<String, dynamic>> revenuelist = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('workers')
        .doc(workerid)
        .collection('revenue')
        .get();
    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      DateTime date = (data['date'] as Timestamp).toDate();
      double amount = data['amount'];
      String username = data['user'];

      if (DateFormat('yyyy-MM-dd').format(date) == todaydate) {
        todaytotal += amount;
      }
      if (DateFormat('yyyy-MM').format(date) == previousmonth) {
        thisprevmonthtotal += amount;
      }
      if (DateFormat('yyyy-MM').format(date) == thismonth) {
        thismonthtotal += amount;
      }
      if (DateFormat('yyyy').format(date) == thisyear) {
        thisyeartotal += amount;
      }
      revenuelist.add({
        'date': DateFormat('yyyy-MM-dd').format(date),
        'amount': amount,
        'user': username,
      });
    }
    return {
      'totaltoday': todaytotal,
      'totalthismonth': thismonthtotal,
      'totalpreviousmonth': thisprevmonthtotal,
      'totalthisyear': thisyeartotal,
      'revenuelist': revenuelist,
    };
  }
}
