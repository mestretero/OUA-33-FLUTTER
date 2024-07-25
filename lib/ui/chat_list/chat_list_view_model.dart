import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/models/view_model/chat_history_users.dart';
import 'package:oua_flutter33/core/services/chat_service.dart';

class ChatListViewModel extends AppBaseViewModel {
  final ChatService _chatService = getIt<ChatService>();
  TextEditingController searchController = TextEditingController();

  User? _user;
  User? get user => _user;

  List<ChatHistoryUsersViewModel> _historyUsers = [];
  List<ChatHistoryUsersViewModel> _filterHistoryUsers = [];
  List<ChatHistoryUsersViewModel> get filterHistory => _filterHistoryUsers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  init(BuildContext context) {
    _loadData();
  }

  Future<void> _loadData() async {
    _isLoading = true;
    _user = await userService.getUserData();
    _historyUsers = await _chatService.getAllChatContacts();
    _filterHistoryUsers = _historyUsers;
    _isLoading = false;
    notifyListeners();
  }

  void searchChange(String value) {
    if (value.isEmpty) {
      _filterHistoryUsers = _historyUsers;
    } else {
      _filterHistoryUsers = _historyUsers
          .where(
            (item) =>
                item.receiverUser.name.contains(value) ||
                item.receiverUser.surname.contains(value),
          )
          .toList();
    }
  }

  void goToChat(ChatHistoryUsersViewModel model) {
    navigationService.navigateTo(
      Routes.chatView,
      arguments: ChatViewArguments(
        receiverUser: model.receiverUser,
      ),
    );
  }
}
