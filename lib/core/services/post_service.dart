// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/comment_model.dart';
import 'package:oua_flutter33/core/models/post_model.dart';
import 'package:oua_flutter33/core/models/view_model/post_view_model.dart';
import 'package:oua_flutter33/core/services/auth_service.dart';

class PostService {
  static final authService = getIt<AuthServices>();
  static final _firestore = FirebaseFirestore.instance;

  static const _collectionName = "posts";

  Future<void> addPost(Post post) async {
    try {
      await _firestore.collection(_collectionName).add(post.toMap());
    } catch (e) {
      print("Error adding post: $e");
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(postId)
          .update({'is_active': false});
    } catch (e) {
      print("Error deleting post: $e");
    }
  }

  Future<void> updatePost(Post post) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(post.id)
          .update(post.toMap());
    } catch (e) {
      print("Error updating post: $e");
    }
  }

  Future<Post?> getPostById(String id) async {
    DocumentSnapshot doc =
        await _firestore.collection(_collectionName).doc(id).get();
    if (doc.exists) {
      return Post.fromDocumentSnapshot(doc);
    }
    return null;
  }

  // UID'ye göre postları getirme
  Future<List<Post>> getPostsByUid(String uid) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection(_collectionName)
        .where('uid', isEqualTo: uid)
        .get();
    return querySnapshot.docs
        .map((doc) => Post.fromDocumentSnapshot(doc))
        .toList();
  }

  // Post'a bağlı comment'leri getirme
  Future<List<Comment>> getCommentsByPostId(String postId) async {
    CollectionReference commentCollection = _firestore
        .collection(_collectionName)
        .doc(postId)
        .collection('comments');
    QuerySnapshot querySnapshot = await commentCollection.get();
    return querySnapshot.docs
        .map((doc) => Comment.fromDocumentSnapshot(doc))
        .toList();
  }

  // Post'a bağlı peopleWhoLike'ı getirme
  Future<List<PepoleWhoLike>> getPeopleWhoLikeByPostId(String postId) async {
    CollectionReference peopleWhoLikeCollection = _firestore
        .collection(_collectionName)
        .doc(postId)
        .collection('people_who_like');
    QuerySnapshot querySnapshot = await peopleWhoLikeCollection.get();
    return querySnapshot.docs
        .map((doc) => PepoleWhoLike.fromDocumentSnapshot(doc))
        .toList();
  }

  // Post, comment ve peopleWhoLike bilgilerini tek bir view model olarak alma
  Future<PostViewModel?> getPostViewModelById(String id) async {
    Post? post = await getPostById(id);
    if (post != null) {
      List<Comment> comments = await getCommentsByPostId(id);
      List<PepoleWhoLike> peopleWhoLike = await getPeopleWhoLikeByPostId(id);
      return PostViewModel(
        post: post,
        comments: comments,
        peopleWhoLike: peopleWhoLike,
      );
    }
    return null;
  }
}
