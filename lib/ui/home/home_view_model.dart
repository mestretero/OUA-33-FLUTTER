import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/services/user_service.dart';

class HomeViewModel extends AppBaseViewModel {
  final UserService _userService = getIt<UserService>();
  User? userData;

  @override
  void initialise() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? data = await _userService.getUserData();
    userData = data;
    notifyListeners();
  }
}
