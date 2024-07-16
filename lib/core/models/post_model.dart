import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oua_flutter33/core/models/comment_model.dart';
import 'package:oua_flutter33/core/models/media_model.dart';

class Post {
  final String? id;
  final String uid;
  final bool isActive;
  final Timestamp createDate;
  final String description;
  final List<Media> medias;
  final List<String> productIds;
  final int countOfLikes;
  final List<String> likesUserId;
  final int countOfComments;
  final List<Comment> comments;

  Post({
    this.id,
    required this.uid,
    required this.description,
    required this.medias,
    required this.isActive,
    required this.createDate,
    required this.productIds,
    required this.likesUserId,
    required this.countOfLikes,
    required this.countOfComments,
    required this.comments,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'description': description,
      'isActive': isActive,
      'createDate': createDate,
      'medias': medias.map((media) => media.toMap()).toList(),
      'productIds': productIds,
      'likesUserId': likesUserId,
      'countOfLikes': countOfLikes,
      'countOfComments': countOfComments,
      'comments': comments.map((comment) => comment.toMap()).toList(),
    };
  }

  factory Post.fromMap(Map<String, dynamic> map, {String? id}) {
    return Post(
      id: id,
      uid: map['uid'],
      description: map['description'],
      isActive: map['isActive'],
      createDate: map['createDate'],
      medias:
          (map['medias'] as List).map((media) => Media.fromMap(media)).toList(),
      productIds: List<String>.from(map['productIds']),
      likesUserId: List<String>.from(map['likesUserId']),
      countOfLikes: map['countOfLikes'],
      countOfComments: map['countOfComments'],
      comments: (map['comments'] as List)
          .map((comment) => Comment.fromMap(comment))
          .toList(),
    );
  }

  factory Post.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Post.fromMap(doc.data() as Map<String, dynamic>, id: doc.id);
  }
}
