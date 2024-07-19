// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/common/helpers/string_functions.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
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
                    )),
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
    return Container();
  }
}
