import 'package:cloud_firestore/cloud_firestore.dart';

class Messagemodel {
  final String senderid;
  final String sendername;
  final String reciverid;
  final String message;
  final Timestamp timestamp;
  final String type;
  final String status;

  Messagemodel({
    required this.senderid,
    required this.sendername,
    required this.reciverid,
    required this.message,
    required this.timestamp,
    required this.type,
    required this.status,
  });
  Map<String, dynamic> tomap() {
    return {
      'senderid': senderid,
      'sendername': sendername,
      'reciverid': reciverid,
      'message': message,
      'timestamp': timestamp,
      'type': type,
      'status': status
    };
  }
}
