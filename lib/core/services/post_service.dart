// ignore_for_file: use_build_context_synchronously, avoid_print, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/comment_model.dart';
import 'package:oua_flutter33/core/models/post_model.dart';
import 'package:oua_flutter33/core/models/response_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/models/view_model/comment_view.dart';
import 'package:oua_flutter33/core/models/view_model/post_view_model.dart';
import 'package:oua_flutter33/core/services/auth_service.dart';
import 'package:oua_flutter33/core/services/user_service.dart';

class PostService {
  static final authService = getIt<AuthServices>();
  static final _userService = getIt<UserService>();

  static final _firestore = FirebaseFirestore.instance;

  static const _collectionName = "posts";

  Future<ResponseModel> addPost(Post post) async {
    try {
      await _firestore.collection(_collectionName).add(post.toMap());
      return ResponseModel(success: true, message: "");
    } catch (e) {
      print("Error adding post: $e");
      return ResponseModel(
          success: false, message: "Hata! Gönderi oluşturulamadı...");
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

  Future<Post?> getPostById(String id) async {
    DocumentSnapshot doc =
        await _firestore.collection(_collectionName).doc(id).get();
    if (doc.exists) {
      return Post.fromDocumentSnapshot(doc);
    }
    return null;
  }

  // UID'ye göre postları getirme
  Future<List<Post>> getPostsByUid(String uid) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection(_collectionName)
        .where('uid', isEqualTo: uid)
        .orderBy("create_date", descending: true)
        .get();
    return querySnapshot.docs
        .map((doc) => Post.fromDocumentSnapshot(doc))
        .toList();
  }

  // Post'a bağlı comment'leri getirme
  Future<List<CommentView>> getCommentsByPostId(String postId) async {
    CollectionReference commentCollection = _firestore
        .collection(_collectionName)
        .doc(postId)
        .collection('comments');
    QuerySnapshot querySnapshot =
        await commentCollection.orderBy("create_date", descending: true).get();

    List<Future<CommentView>> list = querySnapshot.docs.map((doc) async {
      Comment comment = Comment.fromDocumentSnapshot(doc);
      User? user = await _userService.getUserDetail(comment.uid);

      return CommentView(user: user!, comment: comment);
    }).toList();

    return await Future.wait(list);
  }

  // Post'a bağlı peopleWhoLike'ı getirme
  Future<List<PepoleWhoLike>> getPeopleWhoLikeByPostId(String postId) async {
    CollectionReference peopleWhoLikeCollection = _firestore
        .collection(_collectionName)
        .doc(postId)
        .collection('people_who_like');
    QuerySnapshot querySnapshot = await peopleWhoLikeCollection.get();
    return querySnapshot.docs
        .map((doc) => PepoleWhoLike.fromDocumentSnapshot(doc))
        .toList();
  }

  // Post, comment ve peopleWhoLike bilgilerini tek bir view model olarak alma
  Future<PostViewModel?> getPostViewModelById(String id) async {
    Post? post = await getPostById(id);
    if (post != null) {
      User? user = await _userService.getUserDetail(post.uid);

      List<CommentView> comments = await getCommentsByPostId(id);
      List<PepoleWhoLike> peopleWhoLike = await getPeopleWhoLikeByPostId(id);
      return PostViewModel(
        user: user!,
        post: post,
        comments: comments,
        peopleWhoLike: peopleWhoLike,
      );
    }
    return null;
  }

  Future<List<PostViewModel>> getAllPosts() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection(_collectionName)
        .orderBy("create_date", descending: true)
        .get();

    List<PostViewModel> postViewModels = [];

    for (var doc in querySnapshot.docs) {
      Post post = Post.fromDocumentSnapshot(doc);

      User? user = await _userService.getUserDetail(post.uid);

      List<CommentView> comments = await getCommentsByPostId(post.id!);
      List<PepoleWhoLike> peopleWhoLike =
          await getPeopleWhoLikeByPostId(post.id!);

      postViewModels.add(PostViewModel(
        user: user!,
        post: post,
        comments: comments,
        peopleWhoLike: peopleWhoLike,
      ));
    }

    return postViewModels.where((item) => item.user != null).toList();
  }

  Future<void> addPostToFavorites(String? postId) async {
    String currentUserId = authService.user!.uid;
    DocumentReference userRef =
        _firestore.collection("users").doc(currentUserId);

    DocumentReference postRef =
        _firestore.collection(_collectionName).doc(postId);

    await _firestore.runTransaction((transaction) async {
      // Kullanıcı belgesini getir
      DocumentSnapshot userSnapshot = await transaction.get(userRef);
      if (!userSnapshot.exists) {
        throw Exception("User does not exist!");
      }

      User user = User.fromDocumentSnapshot(userSnapshot);

      // Ürün belgesini getir
      DocumentSnapshot postSnapshot = await transaction.get(postRef);
      if (!postSnapshot.exists) {
        throw Exception("Product does not exist!");
      }

      Post post = Post.fromDocumentSnapshot(postSnapshot);

      // Ürün verisini kullanıcı favorilerine ekle
      transaction.update(userRef, {
        'favored_post_ids': FieldValue.arrayUnion([
          {
            'id': post.id,
            'title': post.uid,
            'image_url': post.medias[0].url,
          }
        ])
      });

      // Ürünün favori sayısını arttır
      transaction.update(postRef, {'count_of_likes': FieldValue.increment(1)});

      // Ürünü favori bilgisini ekler

      await postRef.collection("people_who_like").add(PepoleWhoLike(
            uid: post.uid,
            name: user.name,
            surname: user.surname,
            imageUrl: user.imageUrl,
            createDate: Timestamp.now(),
          ).toMap());
    });
  }

  Future<void> removePostFromFavorites(String? postId) async {
    String currentUserId = authService.user!.uid;
    DocumentReference userRef =
        _firestore.collection("users").doc(currentUserId);
    DocumentReference postRef =
        _firestore.collection(_collectionName).doc(postId);

    await _firestore.runTransaction((transaction) async {
      // Kullanıcı belgesini getir
      DocumentSnapshot userSnapshot = await transaction.get(userRef);
      if (!userSnapshot.exists) {
        throw Exception("User does not exist!");
      }

      // Ürün belgesini getir
      DocumentSnapshot postSnapshot = await transaction.get(postRef);
      if (!postSnapshot.exists) {
        throw Exception("Product does not exist!");
      }

      Post post = Post.fromDocumentSnapshot(postSnapshot);

      // Ürün verisini kullanıcı favorilerinden çıkar
      transaction.update(userRef, {
        'favored_post_ids': FieldValue.arrayRemove([
          {
            'id': post.id,
            'title': post.uid,
            'image_url': post.medias[0].url,
          }
        ])
      });

      // Ürünün favori sayısını azalt
      transaction.update(postRef, {'count_of_likes': FieldValue.increment(-1)});

      // Ürünü eklenen collectiondan silme
      QuerySnapshot querySnapshot = await postRef
          .collection("people_who_like")
          .where("uid", isEqualTo: post.uid)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    });

    //Add notification
  }

  Future<ResponseModel> sendComment(String postId, Comment comment) async {
    DocumentReference postRef =
        _firestore.collection(_collectionName).doc(postId);

    try {
      await _firestore
          .collection(_collectionName)
          .doc(postId)
          .collection("comments")
          .add(comment.toMap());

      await _firestore.runTransaction((transaction) async {
        transaction
            .update(postRef, {'count_of_comments': FieldValue.increment(-1)});
      });

      return ResponseModel(success: true, message: "");
    } catch (e) {
      return ResponseModel(
        success: false,
        message: "Error adding post: $e",
      );
    }
  }
}
