import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oua_flutter33/core/models/auth_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';

class UserService {
  static final firestore = FirebaseFirestore.instance;
  static const String collectionName = "users";

  addUser(String uid, Auth auth) {
    firestore.collection(collectionName).doc(uid).set({
      "name": auth.name.toLowerCase(),
      "surname": auth.surname.toLowerCase(),
      "email": auth.email,
      "phone_number": "",
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

  getUserDetail(String uid) {
    return firestore.collection(collectionName).doc(uid).get().then((data) {
      return <String, dynamic>{uid: data.id, ...?data.data()};
    });
  }
}
