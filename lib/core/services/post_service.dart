// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/post_model.dart';
import 'package:oua_flutter33/core/services/auth_service.dart';

class PostService {
  static final authService = getIt<AuthServices>();
  static final _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  
  static const _collectionName = "posts";

  Future<void> addPost(Post post) async {
    try {
      await _firestore.collection(_collectionName).add(post.toMap());
    } catch (e) {
      print("Error adding post: $e");
    }
  }

  Future<String> uploadImage(XFile image) async {
    try {
      final ref = _storage.ref().child('images/posts/${image.name}');
      await ref.putFile(File(image.path));
      return await ref.getDownloadURL();
    } catch (e) {
      print("Error uploading image: $e");
      return "";
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
