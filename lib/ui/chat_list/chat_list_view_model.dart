import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/services/chat_service.dart';

class ChatListViewModel extends AppBaseViewModel {
  final ChatService _chatService = getIt<ChatService>();

  List<User> _users = [];
  List<User> get users => _users;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  init(BuildContext context) {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    _users = await _chatService.getChatUsers();

    _isLoading = false;
    notifyListeners();
  }

  navigatePage() {
    // navigationService.navigateTo(Routes.exampleView);
  }
}
