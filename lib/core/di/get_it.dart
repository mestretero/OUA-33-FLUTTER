import 'package:get_it/get_it.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/services/auth_service.dart';
import 'package:oua_flutter33/core/services/firebase_service.dart';
import 'package:oua_flutter33/core/services/user_service.dart';
import 'package:stacked_services/stacked_services.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerLazySingleton(() => AppBaseViewModel());
  getIt.registerLazySingleton(() => NavigationService());

  //Firebase Service
  getIt.registerLazySingleton(() => FirebaseService());
  getIt.registerLazySingleton(() => AuthServices());
  getIt.registerLazySingleton(() => UserService());
}
