// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:oua_flutter33/ui/chat_list/chat_list_view.dart';
import 'package:oua_flutter33/ui/home/home_view.dart';
import 'package:oua_flutter33/ui/profile/profile_view.dart';
import 'package:oua_flutter33/ui/search/search_view.dart';

BottomNavigationBarItem createNavItem(TabItem tabItem) {
  final currentTab = TabItemData.tabs[tabItem]!;
  return BottomNavigationBarItem(
    icon: currentTab.icon,
    label: currentTab.title,
    activeIcon: currentTab.activeIcon,
  );
}

enum TabItem { Home, Search, Profile, Chat }

class TabItemData {
  String title;
  Widget icon;
  Widget? activeIcon;

  TabItemData({
    required this.title,
    required this.icon,
    required this.activeIcon,
  });
  static Map<TabItem, TabItemData> tabs = {
    TabItem.Home: TabItemData(
      icon: const Icon(Icons.home_outlined),
      title: "Home",
      activeIcon: const Row(
        children: [
          Icon(Icons.home),
          Icon(
            Icons.circle,
            size: 6,
          )
        ],
      ),
    ),
    TabItem.Search: TabItemData(
      icon: const Icon(Icons.search),
      title: "Search",
      activeIcon: const Row(
        children: [
          Icon(Icons.search),
          Icon(
            Icons.circle,
            size: 6,
          )
        ],
      ),
    ),
    TabItem.Chat: TabItemData(
      icon: const Icon(Icons.chat_outlined),
      title: "Chat",
      activeIcon: const Row(
        children: [
          Icon(Icons.chat),
          Icon(
            Icons.circle,
            size: 6,
          )
        ],
      ),
    ),
    TabItem.Profile: TabItemData(
      icon: const Icon(Icons.person_outline),
      title: "Profile",
      activeIcon: const Row(
        children: [
          Icon(Icons.person),
          Icon(
            Icons.circle,
            size: 6,
          )
        ],
      ),
    ),
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
