// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

class User {
  User({
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    required this.birthDay,
    required this.createDate,
    required this.isActive,
    required this.followerCount,
    required this.productCount,
    required this.postCount,
    required this.followerIds,
    required this.favored_product_ids,
    required this.favored_post_ids,
    required this.recorded_product_ids,
    required this.recorded_post_ids,
  });

  final String name;
  final String surname;
  final String email;
  final String phoneNumber;
  final int birthDay;
  final int createDate;
  final bool isActive;
  final int followerCount;
  final int productCount;
  final int postCount;
  final List<_ListObjectOfIds> followerIds;
  final List<_ListObjectOfIds> favored_product_ids;
  final List<_ListObjectOfIds> favored_post_ids;
  final List<_ListObjectOfIds> recorded_product_ids;
  final List<_ListObjectOfIds> recorded_post_ids;
}

class _ListObjectOfIds {
  _ListObjectOfIds({
    required this.id,
    required this.title,
    required this.image_url,
  });

  final String id;
  final String title;
  final String image_url;
}
