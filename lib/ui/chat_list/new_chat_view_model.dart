import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/services/user_service.dart';
import 'package:oua_flutter33/core/di/get_it.dart';

class NewChatViewModel extends AppBaseViewModel {
  final UserService _userService = getIt<UserService>();

  List<User> searchResults = [];

  void init() {
    // Initialize the view model
  }

  void onSearchTextChanged(String text) async {
    setBusy(true);
    searchResults = await _userService.searchUsers(text);
    setBusy(false);
    notifyListeners();
  }

  void startChat(User user) {
    // Navigate to the chat view with the selected user
    
  }
  
  navigatePage() {
    // navigationService.navigateTo(Routes.exampleView);
  }
}
