import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpro/Model/model.dart';
import 'package:taskpro/Services/authservices.dart';
import 'package:taskpro/View/Home/homescreen.dart';
import 'package:taskpro/View/Profile/profilescreen.dart';
import 'package:taskpro/View/Settings/aboutscreen.dart';
import 'package:taskpro/View/Settings/changepasswordscreen.dart';
import 'package:taskpro/View/Settings/historyscreen.dart';
import 'package:taskpro/View/Settings/paymenthistoryscreen.dart';
import 'package:taskpro/View/Settings/privacypolicy.dart';
import 'package:taskpro/controller/Themeblock/theme_bloc.dart';
import 'package:taskpro/widgets/popups/signupsnakbar.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';
import 'package:url_launcher/url_launcher.dart';

class Settingsscreen extends StatefulWidget {
  final Modelclass usermodel;
  const Settingsscreen({super.key, required this.usermodel});

  @override
  State<Settingsscreen> createState() => _SettingsscreenState();
}

final Authservices authservices = Authservices();

class _SettingsscreenState extends State<Settingsscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appbar(), body: body(context, widget.usermodel));
  }
}

AppBar appbar() {
  return AppBar(title: const Customtext(text: 'Settings'), centerTitle: true);
}

Widget body(BuildContext context, Modelclass usermodel) {
  return SingleChildScrollView(
      child: Column(children: [
    customSettingsCategory('Settings', [
      customSettingstile(context, 'Theme', Icons.light_mode, () {
        context.read<ThemeBloc>().add(Toggleevent());
      }),
      customSettingstile(context, 'History', Icons.history_outlined, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Historyscreen()));
      }),
      customSettingstile(context, 'Payments', Icons.payments_outlined, () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Paymenthistoryscreen()));
      })
    ]),
    customSettingsCategory('Privacy', [
      customSettingstile(
          context, 'Change password', Icons.change_circle_outlined, () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Changepasswordscreen()));
      }),
      customSettingstile(
          context, 'Privacy & Policy', Icons.privacy_tip_outlined, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()));
      }),
      customSettingstile(context, 'About', Icons.info_outline, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Aboutpage()));
      })
    ]),
    customSettingsCategory('Profile', [
      customSettingstile(context, 'Edit profile', Icons.person_2_outlined, () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Profilescreen(tag: 'img', usermodel: usermodel)));
      }),
      customSettingstile(context, 'Share', Icons.share_outlined, () {})
    ]),
    customSettingsCategory('Report a problem', [
      customSettingstile(context, 'Report', Icons.report_outlined, () {
        reportproblem(context);
      })
    ]),
    customSettingsCategory('Exit', [
      customSettingstile(context, 'Logout', Icons.exit_to_app_outlined, () {
        log('logout clicked');
        customPopups.alertboxforconfirmation(
            context, () => authservices.signout(context, user!));
      })
    ])
  ]));
}

Widget customSettingsCategory(String category, List<ListTile> listtile) {
  return Row(children: [
    Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
          child: Customtext(
              text: category, fontWeight: FontWeight.bold, fontsize: 20)),
      ...listtile,
      const Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
          child: Divider())
    ]))
  ]);
}

ListTile customSettingstile(
    BuildContext context, String title, IconData icon, void Function()? onTap) {
  return ListTile(
      leading: Icon(icon), title: Customtext(text: title), onTap: onTap);
}

// Future<void> launchtaskprourl() async {
//   const url =
//       'https://www.termsfeed.com/live/78bf261e-f5d2-404b-b294-2b7758a86db6';
//   final uri = Uri.parse(url);

//   // Try launching in an external application first
//   if (await canLaunchUrl(uri)) {
//     bool launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

//     // Fallback to in-app webview if external application fails
//     if (!launched) {
//       launched = await launchUrl(uri, mode: LaunchMode.inAppWebView);
//     }

//     // Fallback to in-app browser if webview fails
//     if (!launched) {
//       launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
//     }

//     if (!launched) {
//       log('Could not launch the URL: $url');
//     }
//   } else {
//     log('Could not launch the URL: $url');
//   }
// }
reportproblem(BuildContext context) async {
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  final Uri emailurl = Uri(
      scheme: 'mailto',
      path: 'abhinraj8086@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Reporting Mail',
        'body': 'How can i help you'
      }));
  if (await canLaunchUrl(emailurl)) {
    launchUrl(emailurl);
  } else {
    CustomPopups.authenticationresultsnakbar(
        context, 'Unable to open Mail', Colors.red);
  }
}
