import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oua_flutter33/core/models/media_model.dart';

class Post {
  final String? id;
  final String uid;
  final Timestamp createDate;
  final bool isActive;
  final String explanation;
  final List<Media> medias;
  final List<RelatedProducts> relatedProducts;
  final String location;
  int countOfLikes;
  int countOfComments;

  Post({
    this.id,
    required this.uid,
    required this.createDate,
    required this.isActive,
    required this.explanation,
    required this.medias,
    required this.relatedProducts,
    required this.location,
    required this.countOfLikes,
    required this.countOfComments,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'create_date': createDate,
      'is_active': isActive,
      'explanation': explanation,
      'medias': medias.map((media) => media.toMap()).toList(),
      'related_products':
          relatedProducts.map((product) => product.toMap()).toList(),
      'location': location,
      'count_of_likes': countOfLikes,
      'count_of_comments': countOfComments,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map, {String? id}) {
    return Post(
      id: id,
      uid: map['uid'] ?? '',
      createDate: map['create_date'] ?? Timestamp.now(),
      isActive: map['is_active'] ?? false,
      explanation: map['explanation'] ?? '',
      medias:
          (map['medias'] as List).map((media) => Media.fromMap(media)).toList(),
      relatedProducts: (map['related_products'] as List)
          .map((product) => RelatedProducts.fromMap(product))
          .toList(),
      location: map['location'] ?? '',
      countOfLikes: map['count_of_likes'] ?? 0,
      countOfComments: map['count_of_comments'] ?? 0,
    );
  }

  factory Post.fromDocumentSnapshot(DocumentSnapshot doc) {
    return Post.fromMap(doc.data() as Map<String, dynamic>, id: doc.id);
  }
}

class RelatedProducts {
  final String productId;
  final String name;
  final String imageUrl;

  RelatedProducts({
    required this.productId,
    required this.name,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'name': name,
      'image_url': imageUrl,
    };
  }

  factory RelatedProducts.fromMap(Map<String, dynamic> map) {
    return RelatedProducts(
      productId: map['product_id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['image_url'] ?? '',
    );
  }
}

class PepoleWhoLike {
  final String uid;
  final String name;
  final String surname;
  final String imageUrl;
  final Timestamp createDate;

  PepoleWhoLike({
    required this.uid,
    required this.name,
    required this.surname,
    required this.imageUrl,
    required this.createDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'surname': surname,
      'image_url': imageUrl,
      'create_date': createDate,
    };
  }

  factory PepoleWhoLike.fromMap(Map<String, dynamic> map) {
    return PepoleWhoLike(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      imageUrl: map['image_url'] ?? '',
      createDate: map['create_date'] ?? Timestamp.now(),
    );
  }

  factory PepoleWhoLike.fromDocumentSnapshot(DocumentSnapshot doc) {
    return PepoleWhoLike.fromMap(doc.data() as Map<String, dynamic>);
  }
}
