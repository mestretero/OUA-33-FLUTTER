import 'package:oua_flutter33/core/di/get_it.dart';
import 'package:oua_flutter33/core/services/auth_service.dart';
import 'package:oua_flutter33/core/services/firebase_service.dart';
import 'package:oua_flutter33/core/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppBaseViewModel extends BaseViewModel {
  final NavigationService navigationService = getIt<NavigationService>();
  final FirebaseService firebaseService = getIt<FirebaseService>();
  final AuthServices authServices = getIt<AuthServices>();
  final UserService userService = getIt<UserService>();

  initialise() {}
}
