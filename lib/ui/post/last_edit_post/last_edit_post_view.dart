// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/common/helpers/string_functions.dart';
import 'package:oua_flutter33/common/widgets/my_appbar.dart';
import 'package:oua_flutter33/common/widgets/my_button.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/ui/post/last_edit_post/last_edit_post_view_model.dart';
import 'package:stacked/stacked.dart';

class LastEditPostView extends StatelessWidget {
  final List<XFile> images;
  final List<Product> products;

  const LastEditPostView(
      {super.key, required this.images, required this.products});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LastEditPostViewModel>.reactive(
      viewModelBuilder: () => LastEditPostViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, model, widget) => Scaffold(
        body: model.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        MyAppBarWidget(
                          isBackButton: true,
                          title: "Yeni Gönderi",
                          routeName: "",
                        ),
                        const SizedBox(height: 8),
                        _buildPostReview(context, model),
                        const SizedBox(height: 16),
                        _dropdownForLocation(context, model),
                        const SizedBox(height: 32),
                        MyButton(
                          text: "Paylaş",
                          onTap: () =>
                              model.sharePost(context, images, products),
                          isExpanded: true,
                          buttonStyle: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildPostReview(BuildContext context, LastEditPostViewModel model) {
    if (model.user == null) {
      return Container();
    }
    return Container(
      width: Scaler.width(1, context),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          // Post Top Bar
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(999.0),
                  image: DecorationImage(
                    image: NetworkImage(model.user!.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model.user!.name.capitalize()} ${model.user!.surname.capitalize()}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '@${'${model.user?.name}_${model.user?.surname}'}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),
          images.length == 1
              ? Container(
                  width: Scaler.width(1, context),
                  height: Scaler.width(0.9, context),
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                        File(images[0].path),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: _popupMenuButtonForProducts(context, model),
                )
              : Container(), //Carousel eklenecek,

          const SizedBox(height: 8),
          TextFormField(
            enabled: true,
            controller: model.explanationController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 4,
            maxLength: 256,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              isDense: true,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: "Birşeyler yaz ....",
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
              counterText: "",
            ),
          ),
        ],
      ),
    );
  }

  Widget _popupMenuButtonForProducts(
      BuildContext context, LastEditPostViewModel model) {
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
                                    image: NetworkImage(element.mainImageUrl),
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

  Widget _dropdownForLocation(
      BuildContext context, LastEditPostViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Konum",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButton<String>(
            elevation: 0,
            underline: const SizedBox(),
            isExpanded: true,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 14,
            ),
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Theme.of(context).colorScheme.secondary,
              size: 32,
            ),
            value: model.location,
            onChanged: (String? newValue) {
              if (newValue != null) {
                model.setLocation(newValue);
              }
            },
            items: <String>[
              "Lütfen Seçiniz",
              'İstanbul',
              'Ankara',
              'İzmir',
              'Antalya',
              'Sivas',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
