// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/helpers/datetime_extension.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/common/helpers/string_functions.dart';
import 'package:oua_flutter33/common/widgets/my_appbar.dart';
import 'package:oua_flutter33/core/models/notification_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:stacked/stacked.dart';
import 'notification_view_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      viewModelBuilder: () => NotificationViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, widget) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: MyAppBarWidget(
                  isBackButton: true,
                  title: "Bildirimler",
                  routeName: "",
                ),
              ),
              _buildSegmentedControl(context, model),
              Expanded(child: _buildNotificationList(model)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentedControl(
      BuildContext context, NotificationViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSegmentButton(context, model, 'All', 'all'),
          _buildSegmentButton(context, model, 'Follows', 'follows'),
          _buildSegmentButton(
              context, model, 'Likes & Comments', 'likes_comments'),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(BuildContext context, NotificationViewModel model,
      String text, String filter) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: model.filter == filter
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
        ),
      ),
      child: ElevatedButton(
        onPressed: () => model.setFilter(filter),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: model.filter == filter
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.secondary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationList(NotificationViewModel model) {
    if (model.notifications == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final todayNotifications = model.notifications
        .where((n) =>
            n.notification.createDate.toDate().isToday() &&
            _applyFilter(model.filter, n.notification))
        .toList();
    final weekNotifications = model.notifications
        .where((n) =>
            n.notification.createDate.toDate().isThisWeek() &&
            _applyFilter(model.filter, n.notification))
        .toList();
    final monthNotifications = model.notifications
        .where((n) =>
            n.notification.createDate.toDate().isThisMonth() &&
            _applyFilter(model.filter, n.notification))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        children: [
          if (todayNotifications.isNotEmpty)
            _buildSection('Today', todayNotifications, model),
          if (weekNotifications.isNotEmpty)
            _buildSection('This Week', weekNotifications, model),
          if (monthNotifications.isNotEmpty)
            _buildSection('Last Month', monthNotifications, model),
        ],
      ),
    );
  }

  bool _applyFilter(String filter, NotificationModel notification) {
    if (filter == 'all') return true;
    if (filter == 'follows' && notification.type == 'follow') return true;
    if (filter == 'likes_comments' &&
        (notification.type == 'like' || notification.type == 'comment')) {
      return true;
    }
    return false;
  }

  Widget _buildSection(String title, List<NotificationListModel> notifications,
      NotificationViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        ...notifications
            .map((n) => NotificationTile(
                  notification: n.notification,
                  model: model,
                  sendedUser: n.sendedUser,
                ))
            .toList(),
      ],
    );
  }
}

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final User sendedUser;
  final NotificationViewModel model;

  const NotificationTile(
      {super.key,
      required this.notification,
      required this.model,
      required this.sendedUser});

  @override
  Widget build(BuildContext context) {
    if (notification.type != "system") {
      return Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //User Image
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(sendedUser.imageUrl),
                ),
              ),
            ),
            const SizedBox(width: 8),

            //User Info + Notification Info
            SizedBox(
              width: Scaler.width(
                  notification.type == "follow" ? 0.65 : 0.54, context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${sendedUser.name.capitalize()} ${sendedUser.surname.capitalize()}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        timeago
                            .format(
                              notification.createDate.toDate(),
                            )
                            .capitalize(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  Text(
                    (notification.type == "comment"
                        ? "comment on your post: ${notification.commentText.substring(0, notification.commentText.length > 50 ? 50 : notification.commentText.length)}"
                        : notification.type == "liked"
                            ? "Liked your post."
                            : "sent a request to follow you."),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),

                  //Buttons If Follow
                  if (notification.type == "follow")
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.onSecondary,
                            elevation: 0,
                            minimumSize: Size(Scaler.width(0.31, context), 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Follow",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                            elevation: 0,
                            minimumSize: Size(Scaler.width(0.31, context), 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Deny",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),

            const SizedBox(width: 8),

            //Releated Post or Product Image
            if (notification.type != "follow")
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(notification.relatedImageUrl),
                  ),
                ),
              ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
