// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, unused_field

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/auth_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/services/auth_service.dart';

class UserService {
  static final authService = getIt<AuthServices>();
  static final firestore = FirebaseFirestore.instance;
  static final firestorage = FirebaseStorage.instance;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  static const String collectionName = "users";
  User? user;

  init() {
    if (authService.user!.uid.isEmpty) {
      return null;
    }

    getUserData().then((onValue) => user = onValue);
  }

  addUser(String uid, Auth auth) {
    firestore.collection(collectionName).doc(uid).set({
      "name": auth.name.toLowerCase(),
      "surname": auth.surname.toLowerCase(),
      "email": auth.email,
      "phone_number": "",
      "image_url": "",
      "birth_day": 0,
      "create_date": 0,
      "isActive": true,
      "follower_count": 0,
      "product_count": 0,
      "post_count": 0,
      "follower_ids": [
        {
          "id": "",
          "title": "",
          "image_url": "",
        }
      ],
      "favored_product_ids": [
        {
          "id": "",
          "title": "",
          "image_url": "",
        }
      ],
      "favored_post_ids": [
        {
          "id": "",
          "title": "",
          "image_url": "",
        }
      ],
      "recorded_product_ids": [
        {
          "id": "",
          "title": "",
          "image_url": "",
        }
      ],
      "recorded_post_ids": [
        {
          "id": "",
          "title": "",
          "image_url": "",
        }
      ],
    });
  }

  deleteUser(String uid) {
    firestore.collection(collectionName).doc(uid).update({"isActive": false});
  }

  updateUser(String uid, User user) {
    firestore.collection(collectionName).doc(uid).update({
      "name": user.name.toLowerCase(),
      "surname": user.surname.toLowerCase(),
      "email": user.email,
      "phone_number": user.phoneNumber,
      "birth_day": user.birthDay,
    });
  }

  Future<User?> getUserDetail(String uid) async {
    try {
      var item;
      await firestore.collection(collectionName).doc(uid).get().then((value) {
        item = User.fromMap(value.data() as Map<String, dynamic>, uid);
      });
      user = item;
      return item;
    } catch (e) {
      print("Error getting document: $e");
      return null;
    }
  }

  Future<List<User>> getUsers() async {
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection(collectionName).get();

      List<User> users = querySnapshot.docs
          .map(
              (doc) => User.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
      return users;
    } catch (e) {
      print("Error getting document: $e");
      return [];
    }
  }

  Future uploadFile(String filePath) async {
    final path = "images/user_profile/${authService.user!.displayName}";
    final file = File(filePath);

    final ref = firestorage.ref().child(path);

    UploadTask uploadTask = ref.putFile(file);

    final snapshot = await uploadTask.whenComplete(() {});

    final url = await snapshot.ref.getDownloadURL();

    firestore
        .collection(collectionName)
        .doc(authService.user!.uid)
        .update({"image_url": url});
  }

  Future<User?> getUserData() async {
    try {
      auth.User? firebaseUser = authService.user;
      if (firebaseUser != null) {
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(firebaseUser.uid).get();
        if (userDoc.exists) {
          return User.fromMap(
              userDoc.data() as Map<String, dynamic>, userDoc.id);
        }
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
    return null;
  }

  increaseCountOfProduct() async {
    User? user = await getUserData();
    await firestore
        .collection(collectionName)
        .doc(user?.uid)
        .update({"product_counts": (user!.productCount + 1)});
  }

}
