// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/ui/chat_list/chat_list_view_model.dart';
import 'package:stacked/stacked.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatListViewModel>.reactive(
        viewModelBuilder: () => ChatListViewModel(),
        onModelReady: (model) => model.init(context),
        builder: (context, model, widget) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  const Text('Mesajlar'),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.green),
                    onPressed: () {},
                  ),
                  const Text('New Chat', style: TextStyle(color: Colors.green)),
                ],
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: model.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Ara...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: model.users.length,
                          itemBuilder: (context, index) {
                            final user = model.users[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(user.imageUrl),
                              ),
                              onTap: () {
                                model.navigationService.navigateTo(
                                  Routes.chatView,
                                  arguments: ChatViewArguments(
                                    receiverUser: user,
                                  ),
                                );
                              },
                              title: Text('${user.name} ${user.surname}'),
                              subtitle: const Text('Thank you :)'),
                              trailing: const Text('2m ago'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          );
        });
  }
}
