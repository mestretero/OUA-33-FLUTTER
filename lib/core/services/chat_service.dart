// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/message_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/models/view_model/chat_history_users.dart';
import 'package:oua_flutter33/core/services/auth_service.dart';

class ChatService extends ChangeNotifier {
  static final authService = getIt<AuthServices>();
  static final _firestore = FirebaseFirestore.instance;

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

    DocumentReference chatRoomDoc =
        _firestore.collection("chat_rooms").doc(chatRoomId);

    await chatRoomDoc.set({
      'receiverUid': receireverId,
      'senderUid': currentUser.uid,
      'lastMessage': message,
      'timestamp': timestamp,
    }, SetOptions(merge: true));

    //add new message to database
    await chatRoomDoc.collection("messages").add(newMessage.toMap());
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

  Future<List<ChatHistoryUsersViewModel>> getAllChatContacts() async {
    final currentUser = authService.user;
    if (currentUser == null) {
      throw Exception("Current user is not logged in.");
    }

    final String currentUserId = currentUser.uid;

    // Query for chat rooms where the current user is either the sender or the receiver
    QuerySnapshot senderQuerySnapshot = await _firestore
        .collection("chat_rooms")
        .where('senderUid', isEqualTo: currentUserId)
        .get();

    QuerySnapshot receiverQuerySnapshot = await _firestore
        .collection("chat_rooms")
        .where('receiverUid', isEqualTo: currentUserId)
        .get();

    Set<String> contactIds = {};
    Map<String, DocumentSnapshot> chatRoomDocs = {};

    // Add all receiver UIDs from chat rooms where current user is the sender
    for (var doc in senderQuerySnapshot.docs) {
      contactIds.add(doc['receiverUid'] as String);
      chatRoomDocs[doc['receiverUid'] as String] = doc;
    }

    // Add all sender UIDs from chat rooms where current user is the receiver
    for (var doc in receiverQuerySnapshot.docs) {
      contactIds.add(doc['senderUid'] as String);
      chatRoomDocs[doc['senderUid'] as String] = doc;
    }

    List<ChatHistoryUsersViewModel> chatHistory = [];

    for (String contactId in contactIds) {
      // Get user data
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(contactId).get();
      User receiverUser = User.fromDocumentSnapshot(userDoc);

      // Get last message
      DocumentSnapshot chatRoomDoc = chatRoomDocs[contactId]!;
      Message lastMessage = Message(
        senderUserId: chatRoomDoc['senderUid'],
        senderUserEmail:
            "", // email bilgisini Message sınıfından alırsanız buraya ekleyin
        receiverUserId: chatRoomDoc['receiverUid'],
        message: chatRoomDoc['lastMessage'],
        timestamp: chatRoomDoc['timestamp'],
      );

      // Add to chat history list
      chatHistory.add(ChatHistoryUsersViewModel(
        lastMessage: lastMessage,
        receiverUser: receiverUser,
      ));
    }

    return chatHistory;
  }
}
