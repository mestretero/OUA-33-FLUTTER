// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  Message({
    this.id,
    required this.senderUserId,
    required this.senderUserEmail,
    required this.receiverUserId,
    required this.message,
    required this.timestamp,
  });

  final String? id;
  final String senderUserId;
  final String senderUserEmail;
  final String receiverUserId;
  final String message;
  final Timestamp timestamp;

  factory Message.fromMap(Map<String, dynamic> data, String documentId) {
    return Message(
      id: documentId,
      senderUserId: data['sender_user_id'] ?? '',
      senderUserEmail: data['sender_user_email'] ?? '',
      receiverUserId: data['receiver_user_id'] ?? '',
      message: data['message'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp(0, 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "sender_user_id": senderUserId,
      "sender_user_email": senderUserEmail,
      "receiver_user_id": receiverUserId,
      "message": message,
      "timestamp": timestamp,
    };
  }
}
