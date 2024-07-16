import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oua_flutter33/core/models/media_model.dart';

class Product {
  final String? id;
  final String uid;
  final String title;
  final String description;
  final String shortDescription;
  final String mainImageUrl;
  final String imageUrl;
  final double price;
  final int amount;
  final String categoryId;
  final int favoriteCount;
  final List<Media> medias;
  final bool isActive;
  final Timestamp createDate;

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.favoriteCount,
    required this.amount,
    required this.categoryId,
    required this.mainImageUrl,
    required this.medias,
    required this.shortDescription,
    required this.uid,
    required this.isActive,
    required this.createDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'description': description,
      'short_description': shortDescription,
      'main_image_url': mainImageUrl,
      'image_url': imageUrl,
      'price': price,
      'amount': amount,
      'category_id': categoryId,
      'favorite_count': favoriteCount,
      'medias': medias.map((media) => media.toMap()).toList(),
      'is_active': isActive,
      'create_date': createDate,
    };
  }

  factory Product.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      title: data['title'],
      description: data['description'],
      imageUrl: data['image_url'],
      price: data['price'],
      favoriteCount: data['favorite_count'],
      amount: data['amount'],
      categoryId: data['category_id'],
      mainImageUrl: data['main_image_url'],
      medias: (data['medias'] as List)
          .map((media) => Media.fromMap(media))
          .toList(),
      shortDescription: data['short_description'],
      uid: data['uid'],
      isActive: data['is_active'],
      createDate: data['create_date'],
    );
  }
}
