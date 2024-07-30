// ignore_for_file: deprecated_member_use
import 'package:dotted_border/dotted_border.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/common/helpers/string_functions.dart';
import 'package:oua_flutter33/common/widgets/post_carosel.dart';
import 'package:oua_flutter33/core/models/post_model.dart';
import 'package:oua_flutter33/core/models/view_model/post_view_model.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/widgets/my_appbar.dart';
import 'package:oua_flutter33/ui/post/post_detail/post_detail_view_model.dart';
import 'package:stacked/stacked.dart';

class PostDetailView extends StatelessWidget {
  final String postId;
  const PostDetailView({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostDetailViewModel>.reactive(
      viewModelBuilder: () => PostDetailViewModel(),
      onModelReady: (model) => model.init(postId),
      builder: (context, model, widget) => Scaffold(
        body: model.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      MyAppBarWidget(
                        isBackButton: true,
                        title: "Gönderi",
                        routeName: "",
                      ),
                      const SizedBox(height: 16),
                      _buildPost(context, model),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildPost(BuildContext context, PostDetailViewModel model) {
    PostViewModel view = model.postView!;
    Post item = model.postView!.post;

    bool isFavored = model.userData!.favoredPostIds
            .where((element) => element.id == item.id)
            .toList()
            .isEmpty
        ? false
        : true;

    return Column(
      children: [
        Container(
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
                        GestureDetector(
                          onTap: () => model.goToProfil(item.uid),
                          child: Container(
                            height: 48,
                            width: 48,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.onPrimary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(999.0),
                              image: view.user != null
                                  ? DecorationImage(
                                      image: NetworkImage(view.user!.imageUrl),
                                      fit: BoxFit.cover,
                                    )
                                  : const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/none-pp.png"),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${view.user?.name.capitalize()} ${view.user?.surname.capitalize()}",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '@${'${view.user?.name}_${view.user?.surname}'}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.4),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          onPressed: () => isFavored
                              ? model.unfavoriedPost(view)
                              : model.favoriedPost(view),
                          icon: Icon(
                            isFavored
                                ? Icons.favorite_rounded
                                : Icons.favorite_outline_rounded,
                            color: isFavored
                                ? Colors.red
                                : Theme.of(context).colorScheme.primary,
                            size: 24,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    item.medias.length == 1
                        ? Container(
                            width: Scaler.width(1, context),
                            height: Scaler.width(0.8, context),
                            alignment: Alignment.bottomRight,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(item.medias[0].url),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: _popupMenuButtonForProducts(
                              context,
                              model,
                              item,
                            ),
                          )
                        : PostCarousel(
                            post: item,
                            model: model,
                          ),

                    const SizedBox(height: 8),
                    Text(
                      item.explanation,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildActionButtons(context, model, view),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _popupMenuButtonForProducts(
      BuildContext context, PostDetailViewModel model, Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (model.isShowProducts && model.showProductPostId == post.id)
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
              children: List.generate(post.relatedProducts.length, (i) {
                final element = post.relatedProducts[i];
                return InkWell(
                  onTap: () => model.goToProductDetail(element.productId),
                  child: Container(
                    margin: (post.relatedProducts.length - 1) == i
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
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        IconButton(
          onPressed: () => model.changeShowProduct(post),
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
      BuildContext context, PostDetailViewModel model, PostViewModel data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => model.showBottomSheetForUsersWhoLike(context, data),
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite_rounded,
                    color: Colors.red,
                    size: 24,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    data.post.countOfLikes.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 16),

            //
            GestureDetector(
              onTap: () => model.showBottomSheetForComments(context, data),
              child: Row(
                children: [
                  Icon(
                    Icons.chat_bubble_outline_sharp,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    data.post.countOfComments.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
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
