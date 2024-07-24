// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/ui/chat_list/chat_list_view_model.dart';
import 'package:stacked/stacked.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController=TextEditingController();
    return ViewModelBuilder<ChatListViewModel>.reactive(
        viewModelBuilder: () => ChatListViewModel(),
        onModelReady: (model) => model.init(context),
        builder: (context, model, widget) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Column(
                    children: [
                      const Text('Mesajlar',style: TextStyle(fontSize: 20,),),
                      Text("@james_norm",style: TextStyle(color: Color(0xFF7DBE48),
                      fontSize: 10,),),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Theme.of(context).colorScheme.secondary,
                    ),
                    label: Text("New Chat"),
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      model.navigationService.navigateTo(Routes.newChatView);
                    },
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: model.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
          
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: Icon(Icons.search),
                          hintText: "Ara...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
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
