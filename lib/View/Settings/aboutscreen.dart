import 'package:flutter/material.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Aboutpage extends StatelessWidget {
  const Aboutpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Customtext(
                text: 'About', fontsize: 20, fontWeight: FontWeight.bold),
            centerTitle: true),
        body: const Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome to Taskpro Worker',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Text(
                    'Taskpro Worker is designed to empower freelance professionals by streamlining their workflow, from client communication to job scheduling, and payment processing.',
                    style: TextStyle(fontSize: 14)),
                SizedBox(height: 20),
                Text('Account Creation:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                  'As a freelance worker, create an account by filling out a simple registration form, making it easier for clients to connect with you.',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),
                Text('Messaging System:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                  'Receive messages from potential clients, discuss project details, timelines, and other important information.',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),
                Text('Work Scheduling:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                    'Clients can book your services for a specific date. Confirm the request to add the job to your schedule.',
                    style: TextStyle(fontSize: 14)),
                SizedBox(height: 20),
                Text('Job Completion and Payment:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                  'After completing a job, send a payment request to the client. Once payment is received, it is added to your history.',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),
                Text('Payment and Work History:',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                    'Keep a detailed history of your jobs and payments. Track your income, monitor job completion, and maintain an organized record of your freelance work.',
                    style: TextStyle(fontSize: 14))
              ],
            ))));
  }
}
