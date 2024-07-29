import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/common/widgets/category_selectors/category_view_model.dart';
import 'package:oua_flutter33/core/models/category_model.dart';
import 'package:oua_flutter33/ui/product/product_add/product_add_view_model.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CategorySelectorBody extends StatelessWidget {
  final Function(String category, String subCategory, String subSubCategory)
      onChangedCategory;

  final ProductAddViewModel? model;

  const CategorySelectorBody({
    super.key,
    required this.onChangedCategory,
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Main Category
            _buildDropdownForMainCategory(context, viewModel),

            //SubCategory
            if (viewModel.selectedMainCategory != null &&
                viewModel.subCategories.isNotEmpty)
              _buildDropdownForSubCategory(context, viewModel),

            //SubSubCategory
            if (viewModel.selectedSubCategory != null &&
                viewModel.subSubCategories.isNotEmpty)
              const SizedBox(height: 16),

            if (viewModel.selectedSubCategory != null &&
                viewModel.subSubCategories.isNotEmpty)
              _buildDropdownForSubSubCategory(context, viewModel),

            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildDropdownForMainCategory(
      BuildContext context, CategoryViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButton<String>(
        hint: Text(
          'Bir Kategori Seçiniz',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 14,
          ),
        ),
        value: model.selectedMainCategory,
        elevation: 0,
        isExpanded: true,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Theme.of(context).colorScheme.secondary,
          size: 32,
        ),
        underline: const SizedBox(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 14,
        ),
        onChanged: (String? newValue) {
          model.selectMainCategory(newValue!);
          onChangedCategory(newValue, "", "");
        },
        items: model.mainCategories.map((category) {
          return DropdownMenuItem<String>(
            value: category.id,
            child: Text(category.name),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDropdownForSubCategory(
      BuildContext context, CategoryViewModel model) {
    return Container(
      margin: const EdgeInsets.only(left: 24.0, top: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButton<String>(
        hint: Text(
          'Alt Kategori Seçin',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 14,
          ),
        ),
        elevation: 0,
        isExpanded: true,
        underline: const SizedBox(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 14,
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Theme.of(context).colorScheme.secondary,
          size: 32,
        ),
        value: model.selectedSubCategory,
        onChanged: (String? newValue) {
          model.selectSubCategory(newValue!);
          onChangedCategory(
              model.selectedMainCategory.toString(), newValue, "");
        },
        items: model.subCategories.map((subCategory) {
          return DropdownMenuItem<String>(
            value: subCategory.id,
            child: Text(subCategory.name),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDropdownForSubSubCategory(context, viewModel) {
    final CarouselController controller = CarouselController();

    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: controller,
          options: CarouselOptions(
            height: Scaler.width(0.25, context),
            initialPage: 0,
            autoPlay: false,
            aspectRatio: 1.5,
            enlargeCenterPage: false,
            viewportFraction: 0.35,
            enableInfiniteScroll: false,
            padEnds: false,
          ),
          itemCount: viewModel.subSubCategories.length,
          itemBuilder: (context, index, realIndex) {
            SubSubCategory subSubCategory = viewModel.subSubCategories[index];
            bool isSelected =
                subSubCategory.id == viewModel.selectedSubSubCategory;

            return GestureDetector(
              onTap: () {
                viewModel.selectSubSubCategory(subSubCategory.id);
                onChangedCategory(
                  viewModel.selectedMainCategory.toString(),
                  viewModel.selectedSubCategory.toString(),
                  subSubCategory.id,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: Scaler.width(0.25, context),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                    width: isSelected ? 3 : 1,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  image: isSelected
                      ? const DecorationImage(
                          image: AssetImage(
                              "assets/images/bg-category-selected.png"),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    subSubCategory.icon == ""
                        ? const Icon(Icons.check_box_outline_blank)
                        : Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(subSubCategory.icon),
                              ),
                            ),
                          ),
                    const SizedBox(height: 4),
                    Text(
                      subSubCategory.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
