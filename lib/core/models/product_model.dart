import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oua_flutter33/core/models/media_model.dart';

class Product {
  final String? id;
  final String uid;
  final String name;
  final String description;
  final String shortDescription;
  final String mainImageUrl;
  final double price;
  final String priceUnit;
  final String categoryId;
  final String subCategoryId;
  final String subSubCategoryId;
  final int countOfFavored;
  final List<Media> medias;
  final bool isActive;
  final bool isArchive;
  final Timestamp createDate;

  Product({
    this.id,
    required this.uid,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.mainImageUrl,
    required this.price,
    required this.priceUnit,
    required this.categoryId,
    required this.subCategoryId,
    required this.subSubCategoryId,
    required this.countOfFavored,
    required this.medias,
    required this.isActive,
    required this.isArchive,
    required this.createDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'description': description,
      'short_description': shortDescription,
      'main_image_url': mainImageUrl,
      'price': price,
      'price_unit': priceUnit,
      'category_id': categoryId,
      'sub_category_id': subCategoryId,
      'sub_sub_category_id': subSubCategoryId,
      'count_of_favored': countOfFavored,
      'medias': medias.map((media) => media.toMap()).toList(),
      'is_active': isActive,
      'is_archive': isArchive,
      'create_date': createDate,
    };
  }

  factory Product.fromMap(Map<String, dynamic> data, String documentId) {
    return Product(
      id: documentId,
      uid: data['uid'],
      name: data['name'],
      description: data['description'],
      shortDescription: data['short_description'],
      mainImageUrl: data['main_image_url'],
      price: data['price'],
      priceUnit: data['price_unit'],
      categoryId: data['category_id'],
      subCategoryId: data['sub_category_id'],
      subSubCategoryId: data['sub_sub_category_id'],
      countOfFavored: data['count_of_favored'],
      medias: (data['medias'] as List)
          .map((media) => Media.fromMap(media))
          .toList(),
      isActive: data['is_active'],
      isArchive: data['is_archive'],
      createDate: data['create_date'],
    );
  }

  factory Product.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      uid: data['uid'],
      name: data['name'] ?? "",
      description: data['description'] ?? "",
      shortDescription: data['short_description'] ?? "",
      mainImageUrl: data['main_image_url'] ?? "",
      price: data['price'] ?? 0,
      priceUnit: data['price_unit'] ?? "",
      countOfFavored: data['count_of_favored'] ?? 0,
      categoryId: data['category_id'] ?? "",
      subCategoryId: data['sub_category_id'] ?? "",
      subSubCategoryId: data['sub_sub_category_id'] ?? "",
      medias: (data['medias'] as List)
          .map((media) => Media.fromMap(media))
          .toList(),
      isActive: data['is_active'] ?? true,
      isArchive: data['is_archive'] ?? false,
      createDate: data['create_date'] ?? Timestamp.now(),
    );
  }
}
