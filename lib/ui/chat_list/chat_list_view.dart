// ignore_for_file: deprecated_member_use
import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/common/helpers/string_functions.dart';
import 'package:oua_flutter33/ui/chat_list/chat_list_view_model.dart';
import 'package:stacked/stacked.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatListViewModel>.reactive(
      viewModelBuilder: () => ChatListViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, model, widget) => Scaffold(
        body: model.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mesajlar',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${model.user!.name}_${model.user!.surname}",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              elevation: 0,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "New Chat",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.edit,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 16,
                                ),
                              ],
                            ),
                            onPressed: () => model.navigationService
                                .navigateTo(Routes.newChatView),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        onChanged: (value) => model.searchChange(value),
                        controller: model.searchController,
                        decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: const Icon(Icons.search),
                          hintText: "Ara...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...model.filterHistory.map(
                        (item) => GestureDetector(
                          onTap: () => model.goToChat(item),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              item.receiverUser.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${item.receiverUser.name.capitalize()} ${item.receiverUser.surname.capitalize()}",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          item.lastMessage.message.substring(
                                              0,
                                              item.lastMessage.message.length <
                                                      32
                                                  ? null
                                                  : 32),
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  timeago
                                      .format(
                                          item.lastMessage.timestamp.toDate())
                                      .toString()
                                      .capitalize(),
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
