import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/services/chat_service.dart';

class ChatViewModel extends AppBaseViewModel {
  final ChatService chatService = getIt<ChatService>();

  init(BuildContext context) {}
  navigatePage() {
    // navigationService.navigateTo(Routes.exampleView);
  }

  void sendMessage(
      TextEditingController controller, String receireverId) async {
    if (controller.text.isNotEmpty) {
      await chatService.sendMessage(receireverId, controller.text);
      controller.clear();
    }
  }
}
