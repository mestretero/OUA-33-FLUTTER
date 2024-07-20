import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oua_flutter33/core/models/category_model.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Category>> getMainCategories() async {
    QuerySnapshot snapshot = await _firestore.collection('categories').get();
    return snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return Category.fromMap(data, doc.id);
    }).toList();
  }

  Future<List<SubCategory>> getSubCategories(String categoryId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('categories')
        .doc(categoryId)
        .collection('subcategories')
        .get();
    return snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return SubCategory.fromMap(data, doc.id);
    }).toList();
  }

  Future<List<SubSubCategory>> getSubSubCategories(
      String categoryId, String subCategoryId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('categories')
        .doc(categoryId)
        .collection('subcategories')
        .doc(subCategoryId)
        .collection('subsubcategories')
        .get();
    return snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return SubSubCategory.fromMap(data);
    }).toList();
  }
}
