// ignore_for_file: deprecated_member_use
import 'package:timeago/timeago.dart' as timeago;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/helpers/string_functions.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/ui/chat_list/chat/chat_view_model.dart';
import 'package:stacked/stacked.dart';

class ChatView extends StatefulWidget {
  final User receiverUser;
  const ChatView({
    super.key,
    required this.receiverUser,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final User receiverUser = widget.receiverUser;

    return ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => ChatViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, model, viewwidget) => Scaffold(
        body: receiverUser.uid.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            style: IconButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                              elevation: 0,
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            onPressed: () => model.navigationService.back(),
                            icon: Icon(
                              Icons.keyboard_arrow_left_rounded,
                              color: Theme.of(context).colorScheme.primary,
                              size: 40,
                            ),
                          ),

                          const SizedBox(width: 16),

                          //User Image
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(999),
                              image: DecorationImage(
                                image: NetworkImage(receiverUser.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          //User Info
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${receiverUser.name.capitalize()} ${receiverUser.surname.capitalize()}",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "@${receiverUser.name.toLowerCase()}_${receiverUser.surname.toLowerCase()}",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: model.chatService.getMessages(
                            model.authServices.user!.uid, receiverUser.uid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.chat_rounded,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    size: 48,
                                  ),
                                  Text(
                                    "No message yet",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var message = snapshot.data!.docs[index];
                              var isMe = message['sender_user_id'] ==
                                  model.authServices.user!.uid;

                              return Align(
                                alignment: isMe
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: isMe
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 24),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 16,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isMe
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                        borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(8),
                                          topRight: const Radius.circular(8),
                                          bottomLeft: isMe
                                              ? const Radius.circular(8)
                                              : const Radius.circular(2),
                                          bottomRight: isMe
                                              ? const Radius.circular(2)
                                              : const Radius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        message['message'],
                                        style: TextStyle(
                                            color: isMe
                                                ? Colors.white
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                      ),
                                    ),
                                    Padding(
                                      padding: isMe
                                          ? const EdgeInsets.only(right: 24)
                                          : const EdgeInsets.only(left: 24),
                                      child: Text(
                                        timeago.format(
                                            message["timestamp"].toDate()),
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.6),
                                          fontSize: 10,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    _buildMessageInput(context, model),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context, ChatViewModel model) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Row(
        children: [
          // IconButton(
          //   style: IconButton.styleFrom(
          //     backgroundColor: Theme.of(context).colorScheme.secondary,
          //   ),
          //   onPressed: () => model.sendFileMessage(),
          //   icon: Icon(
          //     Icons.image_rounded,
          //     color: Theme.of(context).colorScheme.primary,
          //     size: 16,
          //   ),
          // ),
          const SizedBox(width: 16.0),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Mesaj...',
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white),
              onSubmitted: (value) => model.sendMessage(
                  _messageController, widget.receiverUser.uid),
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(0.6),
            ),
            icon: const Icon(
              Icons.send,
              color: Colors.white,
              size: 16,
            ),
            onPressed: () =>
                model.sendMessage(_messageController, widget.receiverUser.uid),
          ),
        ],
      ),
    );
  }
}
