// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:oua_flutter33/ui/home/home_view.dart';

BottomNavigationBarItem createNavItem(TabItem tabItem) {
  final currentTab = TabItemData.tabs[tabItem]!;
  return BottomNavigationBarItem(icon: currentTab.icon, label: currentTab.title);
}

enum TabItem { Home, Search, Orders, Favorite }

class TabItemData {
  String title;
  Widget icon;
  TabItemData({
    required this.title,
    required this.icon,
  });
  static Map<TabItem, TabItemData> tabs = {
    TabItem.Home: TabItemData(icon: const Icon(Icons.home), title: "Home"),
    TabItem.Search: TabItemData(icon: const Icon(Icons.search), title: "Search"),
    TabItem.Orders: TabItemData(icon: const Icon(Icons.add_box), title: "Orders"),
    TabItem.Favorite: TabItemData(icon: const Icon(Icons.favorite), title: "Profile"),
  };
}

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return const HomeView();
    case 1:
      return HomeView();
    case 2:
      return HomeView();
    case 3:
      return HomeView();
    default:
      return const HomeView();
  }
}
