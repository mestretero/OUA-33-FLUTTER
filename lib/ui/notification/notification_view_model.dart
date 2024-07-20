import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/notification_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/services/notification_service.dart';

class NotificationViewModel extends AppBaseViewModel {
  final NotificationService _notificationService = getIt<NotificationService>();
  List<NotificationListModel> notifications = [];
  String filter = 'all'; // all, follows, likes_comments

  void init() {
    getNotifications();
  }

  void setFilter(String filter) {
    this.filter = filter;
    notifyListeners();
  }

  void getNotifications() {
    _notificationService.getNotifications().listen((notis) async {
      for (NotificationModel noti in notis) {
        User? sendedUser = await userService.getUserDetail(noti.sendedUid);
        notifications.add(
            NotificationListModel(notification: noti, sendedUser: sendedUser!));
      }

      notifyListeners();
    });
  }

  void acceptFollowRequest(String notificationId) {
    _notificationService.acceptFollowRequest(notificationId);
  }

  void denyFollowRequest(String notificationId) {
    _notificationService.denyFollowRequest(notificationId);
  }
}
