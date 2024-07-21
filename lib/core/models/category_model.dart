class Category {
  final String id;
  final String name;
  final List<SubCategory> subCategories;

  Category({
    required this.id,
    required this.name,
    required this.subCategories,
  });

  factory Category.fromMap(Map<String, dynamic> map, String id) {
    return Category(
      id: id,
      name: map['name'] ?? '',
      subCategories: map['subcategories'] == null
          ? []
          : List<SubCategory>.from(
              (map['subcategories'] as List<dynamic>).map(
                (subCategory) => SubCategory.fromMap(subCategory, id),
              ),
            ),
    );
  }
}

class SubCategory {
  final String id;
  final String name;
  final List<SubSubCategory> subSubCategories;

  SubCategory({
    required this.id,
    required this.name,
    required this.subSubCategories,
  });

  factory SubCategory.fromMap(Map<String, dynamic> map, String id) {
    return SubCategory(
      id: id,
      name: map['name'] ?? '',
      subSubCategories: map['subsubcategories'] == null
          ? []
          : List<SubSubCategory>.from(
              (map['subsubcategories'] as List<dynamic>).map(
                (subSubCategory) => SubSubCategory.fromMap(subSubCategory, id),
              ),
            ),
    );
  }
}

class SubSubCategory {
  final String id;
  final String name;
  final String icon;

  SubSubCategory({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory SubSubCategory.fromMap(Map<String, dynamic> map, String id) {
    return SubSubCategory(
      id: id, // Eğer id null ise boş string olarak atanacak
      name: map['name'] ?? '', // Eğer name null ise boş string olarak atanacak
      icon: map['icon'] ?? '',
    );
  }
}
