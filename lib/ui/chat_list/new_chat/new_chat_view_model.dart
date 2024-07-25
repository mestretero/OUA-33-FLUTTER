import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';

class NewChatViewModel extends AppBaseViewModel {
  TextEditingController searchController = TextEditingController();

  List<User> _users = [];
  List<User> _filteredUsers = [];
  List<User> get users => _filteredUsers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void init() {
    _loadData();
  }

  Future<void> _loadData() async {
    _isLoading = true;
    _users = await userService.getUsers();
    _filteredUsers = _users;
    _isLoading = false;
    notifyListeners();
  }

  void onSearchTextChanged(String text) async {
    if (text.isEmpty) {
      _filteredUsers = _users;
    } else {
      _filteredUsers = _users
          .where(
            (item) =>
                item.name.contains(text) ||
                item.surname.contains(text) ||
                item.email.contains(text),
          )
          .toList();
    }

    notifyListeners();
  }

  void startChat(User user) {
    navigationService.navigateTo(
      Routes.chatView,
      arguments: ChatViewArguments(
        receiverUser: user,
      ),
    );
  }
}
