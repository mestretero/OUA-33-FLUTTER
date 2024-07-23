import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/ui/chat_list/new_chat_view_model.dart';
import 'package:stacked/stacked.dart';
class NewChatView extends StatelessWidget {
  const NewChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewChatViewModel>.reactive(
      viewModelBuilder: () => NewChatViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Container(
              padding: EdgeInsets.only(left:70,),
              child: Text('New Chat',
              style: TextStyle(
                fontSize: 20,),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter username or email...',
                    border: OutlineInputBorder(
                  
                    ),
                    enabledBorder: OutlineInputBorder( 
                       borderRadius: BorderRadius.circular(40),
                       borderSide: BorderSide(color: Color(0xFFD3F4BF),),
                     )
                  ),
                  onChanged: model.onSearchTextChanged,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: model.searchResults.length,
                    itemBuilder: (context, index) {
                      final user = model.searchResults[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.imageUrl),
                        ),
                        title: Text('${user.name} ${user.surname}'),
                        onTap: () {
                          model.navigationService.navigateTo(
                                  Routes.chatView,
                                  arguments: ChatViewArguments(
                                    receiverUser: user,
                                  ),
                                );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
