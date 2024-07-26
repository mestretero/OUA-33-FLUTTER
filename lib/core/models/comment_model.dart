import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String? id;
  final String uid;
  final String comment;
  final Timestamp createDate;
  final bool isActive;

  Comment({
    this.id,
    required this.uid,
    required this.comment,
    required this.createDate,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'comment': comment,
      'create_date': createDate,
      'is_active': isActive,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map, {String? id}) {
    return Comment(
      id: id,
      uid: map['uid'],
      comment: map['comment'],
      createDate: map['create_date'],
      isActive: map['is_active'],
    );
  }

  factory Comment.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Comment.fromMap(doc.data() as Map<String, dynamic>, id: doc.id);
  }
}
