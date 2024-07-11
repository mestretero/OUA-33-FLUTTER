// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:oua_flutter33/ui/chat_list/chat_list_view.dart';
import 'package:oua_flutter33/ui/home/home_view.dart';
import 'package:oua_flutter33/ui/profile/profile_view.dart';
import 'package:oua_flutter33/ui/search/search_view.dart';

BottomNavigationBarItem createNavItem(TabItem tabItem) {
  final currentTab = TabItemData.tabs[tabItem]!;
  return BottomNavigationBarItem(
      icon: currentTab.icon, label: currentTab.title);
}

enum TabItem { Home, Search, Profile, Chat }

class TabItemData {
  String title;
  Widget icon;
  TabItemData({
    required this.title,
    required this.icon,
  });
  static Map<TabItem, TabItemData> tabs = {
    TabItem.Home: TabItemData(icon: const Icon(Icons.home), title: "Home"),
    TabItem.Search:
        TabItemData(icon: const Icon(Icons.search), title: "Search"),
    TabItem.Chat:
        TabItemData(icon: const Icon(Icons.chat_rounded), title: "Chat"),
    TabItem.Profile:
        TabItemData(icon: const Icon(Icons.person), title: "Profile"),
  };
}

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return const HomeView();
    case 1:
      return const SearchView();
    case 2:
      return const ChatListView();
    case 3:
      return const ProfileView();
    default:
      return const HomeView();
  }
}
