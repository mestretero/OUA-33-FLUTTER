// ignore_for_file: deprecated_member_use
import 'package:timeago/timeago.dart' as timeago;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/common/helpers/string_functions.dart';
import 'package:oua_flutter33/core/models/post_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/models/view_model/post_view_model.dart';
import 'package:oua_flutter33/ui/home/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: model.userData == null
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Top Bar
                      _buildTopBar(context, model, model.userData),
                      const SizedBox(height: 24),
                      _buildInfoBox(context),
                      const SizedBox(height: 24),
                      _buildPost(context, model)
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, HomeViewModel model, User? user) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //User Info
        Row(
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.onPrimary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(999.0),
                image: DecorationImage(
                  image: NetworkImage(user!.imageUrl),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${user.name.capitalize()} ${user.surname.capitalize()}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "@${user.name}_${user.surname}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          ],
        ),

        //Action Buttons
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.secondary),
                ),
                onPressed: () =>
                    model.navigationService.navigateTo(Routes.searchView),
                icon: Icon(
                  Icons.search_rounded,
                  color: Theme.of(context).colorScheme.primary,
                )),
            IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.secondary),
                ),
                onPressed: () =>
                    model.navigationService.navigateTo(Routes.notificationView),
                icon: Icon(
                  Icons.notifications,
                  color: Theme.of(context).colorScheme.primary,
                )),
          ],
        )
      ],
    );
  }

  Widget _buildInfoBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 88,
            width: 88,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999.0),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/master-hands-logo.png"),
              ),
            ),
          ),
          SizedBox(
            width: 210.0,
            child: Text(
              "Usta Eller, el yapımı ürünlerinizi sergileyip satabileceğiniz, benzersiz ve kişisel dokunuşları paylaşabileceğiniz bir platformdur.",
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPost(BuildContext context, HomeViewModel model) {
    return Column(
      children: [
        ...model.posts.map(
          (item) => Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: DottedBorder(
              color: Theme.of(context).colorScheme.secondary,
              radius: const Radius.circular(24),
              borderType: BorderType.RRect,
              strokeWidth: 3,
              dashPattern: const [8, 4],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  width: Scaler.width(1, context),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                image: NetworkImage(model.userData!.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${model.userData!.name.capitalize()} ${model.userData!.surname.capitalize()}",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '@${'${model.userData?.name}_${model.userData?.surname}'}',
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
                      item.post.medias.length == 1
                          ? Container(
                              width: Scaler.width(1, context),
                              height: Scaler.width(0.8, context),
                              alignment: Alignment.bottomRight,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(item.post.medias[0].url),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: _popupMenuButtonForProducts(
                                context,
                                model,
                                item.post.relatedProducts,
                              ),
                            )
                          : Container(), //Carousel eklenecek,
            
                      const SizedBox(height: 8),
                      Text(
                        item.post.explanation,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildActionButtons(context, model, item),
                    ],
                  ),
                ),
              ),
            ),
          ),
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

  Widget _buildActionButtons(
      BuildContext context, HomeViewModel model, PostViewModel data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.favorite_rounded,
                  color: Colors.red,
                  size: 24,
                ),
                Text(
                  data.post.countOfLikes.toString(),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            const SizedBox(width: 8),
            Row(
              children: [
                Icon(
                  Icons.chat_bubble_outline_sharp,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                Text(
                  data.post.countOfComments.toString(),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                )
              ],
            )
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.history_sharp,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
            Text(
              timeago.format(data.post.createDate.toDate()),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            )
          ],
        )
      ],
    );
  }
}
