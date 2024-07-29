// ignore_for_file: avoid_unnecessary_containers

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/ui/product/product-detail/product_view_model.dart';

class CarouselWithProduct extends StatefulWidget {
  final Product? product;
  final ProductDetailViewModel model;
  const CarouselWithProduct(
      {super.key, required this.product, required this.model});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithProductState();
  }
}

class _CarouselWithProductState extends State<CarouselWithProduct> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    Product? product = widget.product;
    final ProductDetailViewModel model = widget.model;

    final List<Widget> sliders = product!.medias
        .map(
          (item) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(item.url),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
        .toList();

    return Stack(
      children: [
        CarouselSlider(
          items: sliders,
          carouselController: _controller,
          options: CarouselOptions(
            autoPlay: false,
            enableInfiniteScroll: false,
            aspectRatio: 0.8,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Positioned(
          top: 24,
          left: 16,
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () => model.navigationService.back(),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
          ),
        ),
        Positioned(
          top: 24,
          right: 16,
          child: model.isMine
              ? Column(
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor:
                            const Color(0xffe5f2da).withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color(0xffd3f4bf), width: 2),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      onPressed: () =>
                          model.deleteProduct(context, product.id ?? ""),
                      icon: Image.asset(
                        "assets/icons/trash-icon.png",
                        width: 20,
                        height: 20,
                        fit: BoxFit.cover,
                      ),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor:
                            const Color(0xffe5f2da).withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color(0xffd3f4bf), width: 2),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      onPressed: () => model.editProduct(product),
                      icon: Icon(
                        Icons.edit_rounded,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: product.isArchive
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5)
                            : const Color(0xffe5f2da).withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: product.isArchive
                                  ? Theme.of(context).colorScheme.primary
                                  : const Color(0xffd3f4bf),
                              width: 2),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      onPressed: () {
                        if (product.isArchive) {
                          model.unarchiveProduct(context, product.id ?? "");
                        } else {
                          model.archiveProduct(context, product.id ?? "");
                        }

                        setState(() {
                          model;
                        });
                      },
                      icon: Image.asset(
                        "assets/icons/archive-icon.png",
                        width: 20,
                        height: 20,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                )
              : IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xffe5f2da).withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(color: Color(0xffd3f4bf), width: 2),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  onPressed: () {
                    if (model.isFavoride) {
                      model.unfavored(context, product.id);
                    } else {
                      model.favored(product, context);
                    }

                    setState(() {
                      model;
                    });
                  },
                  icon: Icon(
                    model.isFavoride
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: model.isFavoride
                        ? Colors.red
                        : Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                ),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: sliders.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: _current == entry.key ? 36.0 : 8,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: _current == entry.key
                        ? Theme.of(context).colorScheme.onPrimary
                        : Colors.white70,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
