// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:oua_flutter33/ui/cart/cart_list_view.dart';
import 'package:oua_flutter33/ui/chat_list/chat_list_view.dart';
import 'package:oua_flutter33/ui/home/home_view.dart';
import 'package:oua_flutter33/ui/product/product_add/product_add_view.dart';
import 'package:oua_flutter33/ui/profile/profile_view.dart';

BottomNavigationBarItem createNavItem(TabItem tabItem) {
  final currentTab = TabItemData.tabs[tabItem]!;
  return BottomNavigationBarItem(
    icon: currentTab.icon,
    label: currentTab.title,
    activeIcon: currentTab.activeIcon,
  );
}

enum TabItem { Home, Search, Profile, Chat, AddProduct, Basket }

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
      icon: const Icon(
        Icons.home_outlined,
        size: 24,
      ),
      title: "Home",
      activeIcon: const Column(
        children: [
          Icon(
            Icons.home,
            size: 20,
          ),
          Icon(
            Icons.circle,
            size: 6,
          )
        ],
      ),
    ),
    TabItem.Search: TabItemData(
      icon: const Icon(
        Icons.search,
        size: 24,
      ),
      title: "Search",
      activeIcon: const Column(
        children: [
          Icon(
            Icons.search,
            size: 20,
          ),
          Icon(
            Icons.circle,
            size: 6,
          )
        ],
      ),
    ),
    TabItem.Chat: TabItemData(
      icon: const Icon(
        Icons.chat_outlined,
        size: 24,
      ),
      title: "Chat",
      activeIcon: const Column(
        children: [
          Icon(
            Icons.chat,
            size: 20,
          ),
          Icon(
            Icons.circle,
            size: 6,
          )
        ],
      ),
    ),
    TabItem.Profile: TabItemData(
      icon: const Icon(
        Icons.person_outline,
        size: 24,
      ),
      title: "Profile",
      activeIcon: const Column(
        children: [
          Icon(
            Icons.person,
            size: 20,
          ),
          Icon(
            Icons.circle,
            size: 6,
          )
        ],
      ),
    ),
    TabItem.AddProduct: TabItemData(
      icon: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(100),
          color: Colors.transparent,
        ),
        child: const Icon(
          Icons.add_rounded,
          size: 20,
        ),
      ),
      title: "AddProduct",
      activeIcon: Column(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(100),
              color: Colors.transparent,
            ),
            child: const Icon(
              Icons.add_rounded,
              size: 20,
            ),
          )
        ],
      ),
    ),
    TabItem.Basket: TabItemData(
      icon: const Icon(
        Icons.shopping_cart_outlined,
        size: 24,
      ),
      title: "Basket",
      activeIcon: const Column(
        children: [
          Icon(
            Icons.shopping_cart_rounded,
            size: 20,
          ),
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
      return  CartListView();
    case 2:
      return  const ProductAddView();
    case 3:
      return const ChatListView();
    case 4:
      return const ProfileView();
    default:
      return const HomeView();
  }
}
