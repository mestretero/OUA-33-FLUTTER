// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({
    required this.uid,
    required this.name,
    required this.surname,
    required this.email,
    required this.imageUrl,
    required this.phoneNumber,
    required this.birthDay,
    required this.createDate,
    required this.isActive,
    required this.followerCount,
    required this.productCount,
    required this.postCount,
    required this.followerIds,
    required this.favoredPostIds,
    required this.favoredProductIds,
    required this.recordedProductIds,
    required this.recordedPostIds,
  });

  final String uid;
  String name;
  String surname;
  String email;
  String imageUrl;
  final String phoneNumber;
  final int birthDay;
  final int createDate;
  final bool isActive;
  final int followerCount;
  final int productCount;
  final int postCount;
  final List<ListObjectOfIds> followerIds;
  final List<ListObjectOfIds> favoredProductIds;
  final List<ListObjectOfIds> favoredPostIds;
  final List<ListObjectOfIds> recordedProductIds;
  final List<ListObjectOfIds> recordedPostIds;

  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    List<ListObjectOfIds> convertToListObjectOfIds(List<dynamic>? dataList) {
      if (dataList == null) {
        return [];
      }
      return dataList.map((item) => ListObjectOfIds.fromMap(item)).toList();
    }

    return User(
      uid: documentId,
      name: data['name'] ?? '',
      surname: data['surname'] ?? '',
      email: data['email'] ?? '',
      imageUrl: data['image_url'] ?? '',
      phoneNumber: data['phone_number'] ?? '',
      birthDay: data['birth_day'] ?? 0,
      createDate: data['create_date'] ?? 0,
      isActive: data['is_active'] ?? false,
      followerCount: data['follower_count'] ?? 0,
      productCount: data['product_count'] ?? 0,
      postCount: data['post_count'] ?? 0,
      followerIds: convertToListObjectOfIds(data['follower_ids'] ?? []),
      favoredProductIds:
          convertToListObjectOfIds(data['favored_product_ids'] ?? []),
      favoredPostIds: convertToListObjectOfIds(data['favored_post_ids'] ?? []),
      recordedProductIds:
          convertToListObjectOfIds(data['recorded_product_ids'] ?? []),
      recordedPostIds:
          convertToListObjectOfIds(data['recorded_post_ids'] ?? []),
    );
  }

  factory User.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return User(
      uid: doc.id,
      name: data['name'] ?? '',
      surname: data['surname'] ?? '',
      email: data['email'] ?? '',
      imageUrl: data['image_url'] ?? '',
      phoneNumber: data['phone_number'] ?? '',
      birthDay: data['birth_day'] ?? 0,
      createDate: data['create_date'] ?? 0,
      isActive: data['is_active'] ?? false,
      followerCount: data['follower_count'] ?? 0,
      productCount: data['product_count'] ?? 0,
      postCount: data['post_count'] ?? 0,
      followerIds: (data['follower_ids'] as List)
          .map((item) => ListObjectOfIds.fromMap(item))
          .toList(),
      favoredProductIds: (data['favored_product_ids'] as List)
          .map((item) => ListObjectOfIds.fromMap(item))
          .toList(),
      favoredPostIds: (data['favored_post_ids'] as List)
          .map((item) => ListObjectOfIds.fromMap(item))
          .toList(),
      recordedProductIds: (data['recorded_product_ids'] as List)
          .map((item) => ListObjectOfIds.fromMap(item))
          .toList(),
      recordedPostIds: (data['recorded_post_ids'] as List)
          .map((item) => ListObjectOfIds.fromMap(item))
          .toList(),
    );
  }
}

class ListObjectOfIds {
  ListObjectOfIds({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String imageUrl;

  factory ListObjectOfIds.fromMap(Map<String, dynamic> data) {
    return ListObjectOfIds(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      imageUrl: data['image_url'] ?? '',
    );
  }
}
