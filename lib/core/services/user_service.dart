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
      "image_url": "https://firebasestorage.googleapis.com/v0/b/ouaflutter33.appspot.com/o/images%2Fnone-pp.png?alt=media&token=64eeecb0-8d11-4b3c-ab42-2225f5857472",
      "birth_day": 0,
      "create_date": 0,
      "isActive": true,
      "follower_count": 0,
      "product_count": 0,
      "post_count": 0,
      "follower_ids": [],
      "favored_product_ids": [],
      "favored_post_ids": [],
      "recorded_product_ids": [],
      "recorded_post_ids": [],
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
      auth.User? firebaseUser = _auth.currentUser;
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

  Future<void> increaseCountOfProduct() async {
    User? user = await getUserData();
    await firestore
        .collection(collectionName)
        .doc(user?.uid)
        .update({"product_count": (user!.productCount + 1)});
  }

  Future<void> followUser(User? targetUser) async {
    final auth.User? currentUser = _auth.currentUser;

    if (currentUser == null || targetUser == null) {
      throw Exception("Current user is not logged in.");
    }

    final String currentUserId = currentUser.uid;

    // Get current user document
    DocumentReference currentUserDocRef =
        firestore.collection(collectionName).doc(currentUserId);

    // Get target user document
    DocumentReference targetUserDocRef =
        firestore.collection(collectionName).doc(targetUser.uid);

    await firestore.runTransaction((transaction) async {
      DocumentSnapshot currentUserSnapshot =
          await transaction.get(currentUserDocRef);
      DocumentSnapshot targetUserSnapshot =
          await transaction.get(targetUserDocRef);

      if (!currentUserSnapshot.exists || !targetUserSnapshot.exists) {
        throw Exception("User does not exist.");
      }

      // Update current user's follower list
      List<dynamic> currentUserFollowerIds =
          currentUserSnapshot['follower_ids'];
      currentUserFollowerIds.add({
        'id': targetUser.uid,
        'title': "${targetUser.name} ${targetUser.surname}",
        'image_url': targetUser.imageUrl,
      });
      transaction
          .update(currentUserDocRef, {'follower_ids': currentUserFollowerIds});

      // Update target user's follower count
      int targetUserFollowerCount = targetUserSnapshot['follower_count'];
      targetUserFollowerCount += 1;
      transaction.update(
          targetUserDocRef, {'follower_count': targetUserFollowerCount});
    });
  }

  Future<User?> getUserByProductId(String productId) async {
    try {
      // Ürünü ID'si ile alın
      DocumentSnapshot productDoc =
          await firestore.collection(collectionName).doc(productId).get();
      if (productDoc.exists) {
        // Kullanıcı ID'sini (uid) alın
        String uid = productDoc['uid'];
        // Kullanıcı detaylarını alın
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(uid).get();
        return User.fromDocumentSnapshot(userDoc);
      } else {
        print("Ürün bulunamadı");
        return null;
      }
    } catch (e) {
      print("Error getting user by product ID: $e");
      return null;
    }
  }

  Future<void> unfollowUser(String targetUserId) async {
    final auth.User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception("Current user is not logged in.");
    }

    final String currentUserId = currentUser.uid;

    // Get current user document
    DocumentReference currentUserDocRef =
        firestore.collection(collectionName).doc(currentUserId);

    // Get target user document
    DocumentReference targetUserDocRef =
        firestore.collection(collectionName).doc(targetUserId);

    await firestore.runTransaction((transaction) async {
      DocumentSnapshot currentUserSnapshot =
          await transaction.get(currentUserDocRef);
      DocumentSnapshot targetUserSnapshot =
          await transaction.get(targetUserDocRef);

      if (!currentUserSnapshot.exists || !targetUserSnapshot.exists) {
        throw Exception("User does not exist.");
      }

      // Update current user's follower list
      List<dynamic> currentUserFollowerIds =
          currentUserSnapshot['follower_ids'];
      currentUserFollowerIds.removeWhere((item) => item['id'] == targetUserId);
      transaction
          .update(currentUserDocRef, {'follower_ids': currentUserFollowerIds});

      // Update target user's follower count
      int targetUserFollowerCount = targetUserSnapshot['follower_count'];
      targetUserFollowerCount -= 1;
      transaction.update(
          targetUserDocRef, {'follower_count': targetUserFollowerCount});
    });
  }

  Future<bool> isFollowing(String targetUserId) async {
    final auth.User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception("Current user is not logged in.");
    }

    final String currentUserId = currentUser.uid;

    DocumentSnapshot currentUserSnapshot =
        await firestore.collection('users').doc(currentUserId).get();

    if (!currentUserSnapshot.exists) {
      throw Exception("Current user does not exist.");
    }

    List<dynamic> currentUserFollowerIds = currentUserSnapshot['follower_ids'];
    return currentUserFollowerIds.any((item) => item['id'] == targetUserId);
  }
}
