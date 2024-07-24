import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/core/models/post_model.dart';
import 'package:oua_flutter33/ui/home/home_view_model.dart';

class PostCarousel extends StatefulWidget {
  final Post post;
  final HomeViewModel model;
  const PostCarousel({super.key, required this.post, required this.model});

  @override
  State<StatefulWidget> createState() {
    return _PostCaroseulState();
  }
}

class _PostCaroseulState extends State<PostCarousel> {
  int currentIndex = 0;
  final CarouselController controller = CarouselController();

  @override
  Widget build(context) {
    Post post = widget.post;
    List<Widget> items = post.medias
        .map(
          (item) => Container(
            width: Scaler.width(1, context),
            height: Scaler.width(1, context),
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(item.url),
              ),
            ),
            child: item.url == post.medias[0].url
                ? _popupMenuButtonForProducts(
                    context,
                    widget.model,
                    post.relatedProducts,
                  )
                : null,
          ),
        )
        .toList();

    return Column(
      children: [
        CarouselSlider(
          items: items,
          carouselController: controller,
          options: CarouselOptions(
              aspectRatio: 0.9,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              autoPlay: false,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: post.medias
              .asMap()
              .map(
                (index, value) => MapEntry(
                  index,
                  GestureDetector(
                    onTap: () => controller.animateToPage(index),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: currentIndex == index
                            ? Theme.of(context).colorScheme.onPrimary
                            : Colors.grey.shade200,
                      ),
                    ),
                  ),
                ),
              )
              .values
              .toList(),
        ),
      ],
    );
  }

  Widget _popupMenuButtonForProducts(BuildContext context, HomeViewModel model,
      List<RelatedProducts> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (model.isShowProducts)
          Container(
            width: Scaler.width(0.55, context),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.4),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ...products
                    .asMap()
                    .map(
                      (i, element) => MapEntry(
                        i,
                        Container(
                          margin: (products.length - 1) == i
                              ? null
                              : const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(element.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: Scaler.width(0.4, context),
                                child: Text(
                                  element.name,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ],
            ),
          ),
        IconButton(
          onPressed: () => model.changeShowProduct(),
          icon: Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.4),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
