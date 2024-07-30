// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/common/helpers/string_functions.dart';
import 'package:oua_flutter33/common/helpers/toast_functions.dart';
import 'package:oua_flutter33/common/widgets/product_detail_carousel.dart';
import 'package:oua_flutter33/ui/product/product-detail/product_view_model.dart';
import 'package:stacked/stacked.dart';

class ProductDetailView extends StatelessWidget {
  final String productId;

  const ProductDetailView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
      viewModelBuilder: () => ProductDetailViewModel(),
      onModelReady: (model) => model.init(productId),
      builder: (context, model, widget) => Scaffold(
        body: model.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  padding: model.productView == null ||
                          !model.productView!.product.isActive
                      ? const EdgeInsets.all(24)
                      : const EdgeInsets.all(0),
                  // No Found Product And Product Detail
                  child: model.productView == null ||
                          !model.productView!.product.isActive
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                              ),
                              onPressed: () => model.navigationService.back(),
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24,
                              ),
                            ),
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 128),
                                  Image.asset(
                                    "assets/icons/no-products-found-icon.png",
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                  Text(
                                    "Ürün Bulunamadı",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Scaler.width(0.7, context),
                                    child: Text(
                                      "Aradığınız ürün, ürün sahibi tarafından satıştan kaldırılmış olabilir...",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildProductMediaCarousel(context, model),
                            _buildProductInfoBox(context, model)
                          ],
                        ),
                ),
              ),
      ),
    );
  }

  Widget _buildProductMediaCarousel(
      BuildContext context, ProductDetailViewModel model) {
    return CarouselWithProduct(
      product: model.productView!.product,
      model: model,
    );
  }

  Widget _buildProductInfoBox(
      BuildContext context, ProductDetailViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Scaler.width(0.8, context),
                child: Text(
                  model.productView!.product.name.capitalize(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Column(
                children: [
                  Icon(
                    Icons.favorite_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 24,
                  ),
                  Text(
                    model.productView!.product.countOfFavored.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
          _buildSegmentedControl(context, model),
          const SizedBox(height: 8),
          Text(
            model.segmentText,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          if (model.isMine == false &&
              model.productView!.product.isActive == true)
            _buildActionButtons(context, model),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl(
      BuildContext context, ProductDetailViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildSegmentButton(context, model, 'Ürün Açıklaması', 'description'),
          // _buildSegmentButton(context, model, 'İletişim', 'communication'),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(BuildContext context, ProductDetailViewModel model,
      String text, String filter) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: model.segmentValue == filter
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
        ),
      ),
      child: TextButton(
        onPressed: () => model.changeSegment(filter),
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: model.segmentValue == filter
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.secondary,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context, ProductDetailViewModel model) {
    return Column(
      children: [
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '₺${model.productView!.product.price}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 1,
                ),
                elevation: 0,
              ),
              onPressed: () {
                model.addToCart();
                MyToast.showErrorTost(context,
                    "${model.productView!.product.name} sepete eklendi");
              },
              child: Text(
                'Sepete Ekle',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
              ),
              onPressed: () => model.sendMessage(),
              child: const Row(
                children: [
                  Icon(
                    Icons.chat,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Mesaj',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
