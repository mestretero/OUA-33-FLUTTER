import 'package:oua_flutter33/core/models/message_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';

class ChatHistoryUsersViewModel {
  final Message lastMessage;
  final User receiverUser;

  ChatHistoryUsersViewModel({
    required this.lastMessage,
    required this.receiverUser,
  });
}
