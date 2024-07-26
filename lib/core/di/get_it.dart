import 'package:get_it/get_it.dart';
import 'package:oua_flutter33/app/app_base_view_model.dart';
import 'package:oua_flutter33/core/services/auth_service.dart';
import 'package:oua_flutter33/core/services/cart_service.dart';
import 'package:oua_flutter33/core/services/category_service.dart';
import 'package:oua_flutter33/core/services/chat_service.dart';
import 'package:oua_flutter33/core/services/firebase_service.dart';
import 'package:oua_flutter33/core/services/media_service.dart';
import 'package:oua_flutter33/core/services/notification_service.dart';
import 'package:oua_flutter33/core/services/post_service.dart';
import 'package:oua_flutter33/core/services/product_service.dart';
import 'package:oua_flutter33/core/services/search_service.dart';
import 'package:oua_flutter33/core/services/user_service.dart';
import 'package:stacked_services/stacked_services.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerLazySingleton(()=>CartService());
  getIt.registerLazySingleton(() => AppBaseViewModel());
  getIt.registerLazySingleton(() => NavigationService());

  //Firebase Service
  getIt.registerLazySingleton(() => FirebaseService());
  getIt.registerLazySingleton(() => AuthServices());
  getIt.registerLazySingleton(() => UserService());
  getIt.registerLazySingleton(() => ChatService());
  getIt.registerLazySingleton(() => ProductService());
  getIt.registerLazySingleton(() => PostService());
  getIt.registerLazySingleton(() => NotificationService());
  getIt.registerLazySingleton(() => CategoryService());
  getIt.registerLazySingleton(() => MediaService());
  getIt.registerLazySingleton(() => SearchService());
}
