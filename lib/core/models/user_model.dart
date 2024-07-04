// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

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
  final String name;
  final String surname;
  final String email;
  final String imageUrl;
  final String phoneNumber;
  final int birthDay;
  final int createDate;
  final bool isActive;
  final int followerCount;
  final int productCount;
  final int postCount;
  final List<_ListObjectOfIds> followerIds;
  final List<_ListObjectOfIds> favoredProductIds;
  final List<_ListObjectOfIds> favoredPostIds;
  final List<_ListObjectOfIds> recordedProductIds;
  final List<_ListObjectOfIds> recordedPostIds;

  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    List<_ListObjectOfIds> convertToListObjectOfIds(List<dynamic>? dataList) {
      if (dataList == null) {
        return [];
      }
      return dataList.map((item) => _ListObjectOfIds.fromMap(item)).toList();
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
      isActive: data['isActive'] ?? false,
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
}

class _ListObjectOfIds {
  _ListObjectOfIds({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String imageUrl;

  factory _ListObjectOfIds.fromMap(Map<String, dynamic> data) {
    return _ListObjectOfIds(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      imageUrl: data['image_url'] ?? '',
    );
  }
}
