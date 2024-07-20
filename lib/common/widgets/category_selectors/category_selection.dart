import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/widgets/category_selectors/category_view_model.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CategorySelectorBody extends StatelessWidget {
  const CategorySelectorBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<String>(
                hint: const Text('Kategori Seçin'),
                value: viewModel.selectedMainCategory,
                onChanged: (String? newValue) {
                  viewModel.selectMainCategory(newValue!);
                },
                items: viewModel.mainCategories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category.id,
                    child: Text(category.name),
                  );
                }).toList(),
              ),
              if (viewModel.selectedMainCategory != null &&
                  viewModel.subCategories.isNotEmpty)
                DropdownButton<String>(
                  hint: const Text('Alt Kategori Seçin'),
                  value: viewModel.selectedSubCategory,
                  onChanged: (String? newValue) {
                    viewModel.selectSubCategory(newValue!);
                  },
                  items: viewModel.subCategories.map((subCategory) {
                    return DropdownMenuItem<String>(
                      value: subCategory.id,
                      child: Text(subCategory.name),
                    );
                  }).toList(),
                ),
              if (viewModel.selectedSubCategory != null &&
                  viewModel.subSubCategories.isNotEmpty)
                SizedBox(
                  height: 200, // Belirli bir yükseklik verin
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 200,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.5,
                    ),
                    itemCount: viewModel.subSubCategories.length,
                    itemBuilder: (context, index, realIndex) {
                      String subSubCategory =
                          viewModel.subSubCategories[index].name;
                      bool isSelected =
                          subSubCategory == viewModel.selectedSubSubCategory;
                      return GestureDetector(
                        onTap: () {
                          viewModel.selectSubSubCategory(subSubCategory);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? Colors.green
                                  : Colors.grey.shade300,
                              width: isSelected ? 3 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image, // Simgelerinizi buraya ekleyin
                                size: 40,
                                color: isSelected ? Colors.green : Colors.black,
                              ),
                              const SizedBox(height: 8),
                              Text(subSubCategory),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
