// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/helpers/create_bottom_nav_item.dart';
import 'package:oua_flutter33/ui/main/main_view_model.dart';
import 'package:stacked/stacked.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, model, child) => Scaffold(
        extendBody: true,
        body: getViewForIndex(model.currentTabIndex),
        bottomNavigationBar: Container(
          height: 64,
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.green[900],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.green[100],
            unselectedItemColor: Colors.white,
            selectedFontSize: 13,
            unselectedFontSize: 13,
            items: [
              createNavItem(TabItem.Home),
              createNavItem(TabItem.Search),
              createNavItem(TabItem.Chat),
              createNavItem(TabItem.Profile),
            ],
            onTap: (value) {
              model.setTabIndex(value);
            },
            currentIndex: model.currentTabIndex,
          ),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 4),
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.lightGreenAccent,
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () {},
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
