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
                                    "Ara...",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.5),
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
              ? Column(
                  children: [
                    const SizedBox(height: 8),
                    ...model.user!.favoredProductIds.map((item) {
                      return Container(
                        width: Scaler.width(1, context),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 48,
                                  width: 48,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage(item.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Scaler.width(0.5, context),
                                  child: Text(
                                    item.title,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ),

                            //
                            IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor:
                                    Colors.red.shade100.withOpacity(0.5),
                              ),
                              onPressed: () => model.unfavored(item.id),
                              icon: Transform.rotate(
                                angle: 27.5,
                                child: const Icon(
                                  Icons.add_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                )
              : Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    ...model.products.map(
                      (item) {
                        bool isFavorited = model.user!.favoredProductIds
                                .where((e) => e.id == item.product.id)
                                .toList()
                                .isEmpty
                            ? false
                            : true;

                        return GestureDetector(
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
                                  alignment: Alignment.topRight,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          item.product.mainImageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: IconButton(
                                      style: IconButton.styleFrom(
                                        padding: const EdgeInsets.all(0),
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      onPressed: () => isFavorited
                                          ? model.unfavored(item.product.id)
                                          : model.favored(item.product),
                                      icon: Icon(
                                        isFavorited
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_border_rounded,
                                        color: isFavorited
                                            ? Colors.red
                                            : Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  item.product.name,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                                          image:
                                              NetworkImage(item.user.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
