// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/common/helpers/string_functions.dart';
import 'package:oua_flutter33/ui/search/search_result/search_result_view_model.dart';
import 'package:stacked/stacked.dart';

class SearchResultView extends StatelessWidget {
  final String? searchText;
  final String? location;
  final String searchType;
  final String? category;
  final String? subcategory;
  final String? subSubCategory;

  const SearchResultView({
    super.key,
    this.searchText,
    this.location,
    required this.searchType,
    this.category,
    this.subcategory,
    this.subSubCategory,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchResultViewModel>.reactive(
      viewModelBuilder: () => SearchResultViewModel(),
      onModelReady: (model) => model.init(
        searchText,
        searchType,
        location,
        category,
        subcategory,
        subSubCategory,
      ),
      builder: (context, model, widget) => Scaffold(
        body: model.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                            onPressed: () {
                              model.navigationService.back();
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_left_rounded,
                              size: 32,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => model.showFilterDialog(context),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              width: Scaler.width(0.72, context),
                              height: 44,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                borderRadius: BorderRadius.circular(40),
                                color: model.searchController.text.isEmpty
                                    ? null
                                    : Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.4),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    model.searchController.text.isEmpty
                                        ? "Ara..."
                                        : model.searchController.text,
                                    style: TextStyle(
                                      color: searchText!.isEmpty
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.5)
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildListProducts(context, model),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildListProducts(BuildContext context, SearchResultViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (model.data!.users.isNotEmpty)
          Text(
            "İlgili Profiller",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (model.data!.users.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...model.data!.users.map(
                  (item) => Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(
                                item.imageUrl,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Scaler.width(0.3, context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item.name.capitalize()} ${item.surname.capitalize()}",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "@${item.name.toLowerCase()}_${item.surname.toLowerCase()}",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => model.goToProfile(item.uid),
                          icon: Icon(
                            Icons.arrow_circle_right,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 32,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: 16),

        if (model.data!.products.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              "İlgili Ürünler",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

        model.searchType == "all"
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...model.data!.products.map(
                      (item) => GestureDetector(
                        onTap: () => model.goToProductDetail(item),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(right: 8),
                          width: Scaler.width(0.4, context),
                          height: Scaler.width(0.6, context),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Scaler.width(1, context),
                                height: Scaler.width(0.32, context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                    image: NetworkImage(item.mainImageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                item.name,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${item.price} ${item.priceUnit}",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : SizedBox(
                height: Scaler.height(
                    model.data!.posts.length.ceilToDouble(), context),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...model.data!.products.map(
                      (item) => GestureDetector(
                        onTap: () => model.goToProductDetail(item),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: Scaler.width(0.4, context),
                          height: Scaler.width(0.6, context),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Scaler.width(1, context),
                                height: Scaler.width(0.32, context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                    image: NetworkImage(item.mainImageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                item.name,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${item.price} ${item.priceUnit}",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

        const SizedBox(height: 16),

        if (model.data!.posts.isNotEmpty)
          Text(
            "İlgili Gönderiler",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        //
        if (model.data!.posts.isNotEmpty)
          SizedBox(
            height:
                Scaler.height(model.data!.posts.length.ceilToDouble(), context),
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.only(top: 8),
              children: [
                ...model.data!.posts.map(
                  (item) => Container(
                    padding: const EdgeInsets.all(4),
                    alignment: Alignment.topRight,
                    width: Scaler.width(0.27, context),
                    height: Scaler.width(0.27, context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(item.medias[0].url),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: item.medias.length > 1
                        ? Icon(
                            Icons.collections_sharp,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : Container(),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
