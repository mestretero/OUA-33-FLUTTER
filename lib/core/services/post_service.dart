// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/post_model.dart';
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
}
