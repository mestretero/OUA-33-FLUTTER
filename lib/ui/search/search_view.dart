// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/ui/search/search_view_model.dart';
import 'package:stacked/stacked.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, model, widget) => Scaffold(
        body: model.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
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
                          SizedBox(
                            width: Scaler.width(0.72, context),
                            child: TextField(
                              onChanged: (value) => model.searchChange(value),
                              controller: model.searchController,
                              decoration: InputDecoration(
                                isDense: true,
                                suffixIcon: GestureDetector(
                                  onTap: () => model.showFilterDialog(context),
                                  child: Icon(
                                    Icons.more_horiz,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 24,
                                  ),
                                ),
                                prefixIcon: GestureDetector(
                                  onTap: () => model.searchChange(
                                      model.searchController.text),
                                  child: Icon(
                                    Icons.search,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                hintText: "Ara...",
                                hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    width: 1,
                                  ),
                                ),
                                enabled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildPostAndProduct(context, model),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildPostAndProduct(BuildContext context, SearchViewModel model) {
    return Column(
      children: [
        _buildSegmentedControl(context, model),

        //Grid
        SizedBox(
          child: model.filteredGrid == "favored"
              ? const Column(
                  children: [],
                )
              : Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    ...model.products.map(
                      (item) => GestureDetector(
                        onTap: () => model.goToProductDetail(item.product),
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
                                    image:
                                        NetworkImage(item.product.mainImageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () => model.favored(item.product),
                                  icon: const Icon(
                                    Icons.favorite_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                item.product.name,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${item.product.price} ${item.product.priceUnit}",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        width: 1.5,
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(item.user.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildSegmentedControl(BuildContext context, SearchViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSegmentButton(context, model, 'Bana Özel', 'specialforme'),
          _buildSegmentButton(context, model, 'Favorilerim', 'favored'),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(
      BuildContext context, SearchViewModel model, String text, String filter) {
    return Container(
      width: Scaler.width(0.4, context),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: model.filteredGrid == filter
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
        ),
      ),
      child: ElevatedButton(
        onPressed: () => model.setFilterGrid(filter),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: model.filteredGrid == filter
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.secondary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
