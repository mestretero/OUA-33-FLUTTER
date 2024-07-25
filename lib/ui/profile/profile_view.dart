// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/common/helpers/string_functions.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/ui/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  final String? profileUid;
  const ProfileView({super.key, this.profileUid});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) => model.init(
        context,
        profileUid,
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
                      //Top Bar
                      _buildTopBar(context, model, model.user),
                      const SizedBox(height: 24),
                      _buildUserProfilInfo(context, model, model.user),
                      const SizedBox(height: 24),
                      _buildPostAndProduct(context, model),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildTopBar(
      BuildContext context, ProfileViewModel model, User? user) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: profileUid != null
          ? MainAxisAlignment.start
          : MainAxisAlignment.spaceBetween,
      children: [
        if (profileUid != null)
          IconButton(
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(0),
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            onPressed: () => model.navigationService.back(),
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 40,
            ),
          ),
        //User Info
        Text(
          "@${user?.name.toLowerCase()}_${user?.surname.toLowerCase()}",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),

        //Action Buttons
        if (profileUid == null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _popupMenuButton(context, model),
              PopupMenuButton<String>(
                onSelected: (String result) {
                  if (result == 'Ayarlar') {
                    // Ayarlar sayfasına yönlendirin veya işlemleri burada yapın
                    print('Ayarlar seçildi');
                  } else if (result == 'Yardım ve Destek') {
                    // Yardım ve Destek sayfasına yönlendirin veya işlemleri burada yapın
                    print('Yardım ve Destek seçildi');
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Ayarlar',
                    child: Text('Ayarlar'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Yardım ve Destek',
                    child: Text('Yardım ve Destek'),
                  ),
                ],
              ),
            ],
          )
      ],
    );
  }

  Widget _buildUserProfilInfo(
      BuildContext context, ProfileViewModel model, User? user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //UserInfo
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 104,
              width: 104,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.onPrimary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(999.0),
                image: DecorationImage(
                  image: NetworkImage(user!.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.user!.postCount.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Gönderi",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.user!.productCount.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Ürün",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.user!.followerCount.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Takipçi",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 8),

        //User Name
        Text(
          "${user.name.capitalize()} ${user.surname.capitalize()}",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 16),
        //Buttons
        profileUid != null
            ? _buildAnotherProfileButtons(context, model)
            : _buildMyProfileButtons(context, model),

        const SizedBox(height: 16),
        //Post And Product
      ],
    );
  }

  Widget _popupMenuButton(BuildContext context, ProfileViewModel model) {
    return MenuAnchor(
      alignmentOffset: Offset.fromDirection(0, -100),
      style: const MenuStyle(
          elevation: WidgetStatePropertyAll(0.7),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 8))),
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.primary,
              size: 18,
            ),
          ),
        );
      },
      menuChildren: [
        PopupMenuItem(
          onTap: () {
            model.navigationService.navigateTo(Routes.sendPostView);
          },
          child: ListTile(
            leading: Icon(
              Icons.grid_on_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Gönderi Ekle',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            model.navigationService.navigateTo(Routes.productAddView);
          },
          child: ListTile(
            leading: Icon(
              Icons.add_circle_outline_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Ürün Ekleme',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMyProfileButtons(BuildContext context, ProfileViewModel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 170,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              elevation: 0,
            ),
            onPressed: () {
              model.navigationService.navigateTo(Routes.editedProfileView);
            },
            child: Text(
              "Profili Düzenle",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 170,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              elevation: 0,
            ),
            onPressed: () => model.shareLink(context),
            child: Text(
              "Profili Paylaş",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnotherProfileButtons(
      BuildContext context, ProfileViewModel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 170,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: model.isFollow
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.4)
                  : Theme.of(context).colorScheme.onPrimary,
              elevation: 0,
            ),
            onPressed: () {
              model.isFollow ? model.unfollowUser() : model.followUser();
            },
            child: Text(
              model.isFollow ? "Takipten Çık" : "Takip Et",
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 170,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              elevation: 0,
            ),
            onPressed: () => model.goToChat(),
            child: Text(
              "Mesaj",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPostAndProduct(BuildContext context, ProfileViewModel model) {
    return Column(
      children: [
        _buildSegmentedControl(context, model),

        //Grid
        SizedBox(
          height: Scaler.height(model.posts.length.ceilToDouble(), context),
          child: model.filter == "posts"
              ? GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  padding: const EdgeInsets.all(10),
                  children: [
                    ...model.posts.map(
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
                )
              : Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    ...model.products.map(
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
      ],
    );
  }

  Widget _buildSegmentedControl(BuildContext context, ProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSegmentButton(context, model, 'Gönderi', 'posts'),
          _buildSegmentButton(context, model, 'Ürünler', 'products'),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(BuildContext context, ProfileViewModel model,
      String text, String filter) {
    return Container(
      width: Scaler.width(0.4, context),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: model.filter == filter
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
        ),
      ),
      child: ElevatedButton(
        onPressed: () => model.setFilter(filter),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: model.filter == filter
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.secondary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
