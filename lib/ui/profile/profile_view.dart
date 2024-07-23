// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/common/helpers/string_functions.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/ui/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, model, widget) => Scaffold(
        body: model.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Top Bar
                      _buildTopBar(context, model, model.user),
                      const SizedBox(height: 24),
                      _buildUserProfilInfo(context, model, model.user),
                      const SizedBox(height: 24),
                      // _buildPostAndProduct(context, model)
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //User Info
        Text(
          "@${user?.name}_${user?.surname}",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),

        //Action Buttons
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
        Row(
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
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('https://master-hands/uid:${user.uid}'),
                            const SizedBox(height: 15),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Text(
                  "Profili Paylaş",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
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
}
