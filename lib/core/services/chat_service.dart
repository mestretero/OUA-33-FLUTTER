// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/message_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/services/auth_service.dart';

class ChatService extends ChangeNotifier {
  static final authService = getIt<AuthServices>();
  static final _firestore = FirebaseFirestore.instance;

  //Send Message
  Future<void> sendMessage(String receireverId, String message) async {
    //get current user info
    final currentUser = authService.user;
    final Timestamp timestamp = Timestamp.now();
    //create a new message
    Message newMessage = Message(
      senderUserId: currentUser!.uid,
      senderUserEmail: currentUser.email.toString(),
      receiverUserId: receireverId,
      message: message,
      timestamp: timestamp,
    );
    //construct chat room id from current use id and receiver id (sorted to ensure uniquness)
    List<String> ids = [currentUser.uid, receireverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    //add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //Get Message
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  //GetMessageUsers
  Future<List<User>> getChatUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection("users").get();

      List<User> users = [];
      querySnapshot.docs.map((doc) {
        if (doc.id != authService.user!.uid) {
          users.add(User.fromMap(doc.data() as Map<String, dynamic>, doc.id));
        }
      }).toList();

      return users;
    } catch (e) {
      print("Error getting document: $e");
      return [];
    }
  }
}
