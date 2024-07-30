import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/services/chat_service.dart';

class ChatViewModel extends AppBaseViewModel {
  final ChatService chatService = getIt<ChatService>();

  final ScrollController controller = ScrollController();

  init(BuildContext context) {}
  navigatePage() {}

  void sendMessage(
      TextEditingController controller, String receireverId) async {
    if (controller.text.isNotEmpty) {
      await chatService.sendMessage(receireverId, controller.text);
      controller.clear();
      scrollOnBottom();
    }
  }

  void scrollOnBottom() {
    controller.animateTo(
      controller.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
    // notifyListeners();
  }

  void sendFileMessage() {}
}
