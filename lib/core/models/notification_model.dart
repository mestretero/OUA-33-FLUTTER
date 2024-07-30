import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oua_flutter33/core/models/user_model.dart';

class NotificationModel {
  final String? id;
  final String type; // comment || liked || follow || system
  final Timestamp createDate;
  final String receiverUid;
  final String sendedUid;
  final String relatedId;
  final String relatedCollection; // posts || products
  final String relatedImageUrl;
  final String commentText;
  final bool isRead;
  final bool isActive;

  NotificationModel({
    this.id,
    required this.type,
    required this.createDate,
    required this.receiverUid,
    required this.sendedUid,
    required this.relatedId,
    required this.relatedCollection,
    required this.relatedImageUrl,
    required this.commentText,
    required this.isRead,
    required this.isActive,
  });

  factory NotificationModel.fromMap(
      Map<String, dynamic> map, String documentId) {
    return NotificationModel(
      id: documentId,
      type: map['type'],
      createDate: map['create_date'],
      receiverUid: map['receiver_uid'],
      sendedUid: map['sended_uid'],
      relatedId: map['related_id'],
      relatedCollection: map['related_collection'],
      relatedImageUrl: map['related_image_url'],
      commentText: map['comment_text'],
      isRead: map['is_read'],
      isActive: map['is_active'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type, // system - follow - comment - liked
      'create_date': createDate,
      'receiver_uid': receiverUid,
      'sended_uid': sendedUid,
      'related_id': relatedId,
      'related_collection': relatedCollection,
      'related_image_url': relatedImageUrl,
      'comment_text': commentText,
      'is_read': isRead,
      'is_active': isActive,
    };
  }
}

class NotificationListModel {
  NotificationModel notification;
  User sendedUser;

  NotificationListModel({
    required this.notification,
    required this.sendedUser,
  });
}
