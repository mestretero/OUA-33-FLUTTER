// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i26;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as _i28;
import 'package:oua_flutter33/core/models/product_model.dart' as _i29;
import 'package:oua_flutter33/core/models/user_model.dart' as _i27;
import 'package:oua_flutter33/example/example_view.dart' as _i10;
import 'package:oua_flutter33/ui/auth/login/login_view.dart' as _i8;
import 'package:oua_flutter33/ui/auth/register/register_view.dart' as _i9;
import 'package:oua_flutter33/ui/cart/cart_list_view.dart' as _i19;
import 'package:oua_flutter33/ui/chat_list/chat/chat_view.dart' as _i16;
import 'package:oua_flutter33/ui/chat_list/chat_list_view.dart' as _i15;
import 'package:oua_flutter33/ui/chat_list/new_chat/new_chat_view.dart' as _i23;
import 'package:oua_flutter33/ui/home/home_view.dart' as _i4;
import 'package:oua_flutter33/ui/main/main_view.dart' as _i3;
import 'package:oua_flutter33/ui/notification/notification_view.dart' as _i11;
import 'package:oua_flutter33/ui/onboarding/onboarding_one/onboarding_one_view.dart'
    as _i6;
import 'package:oua_flutter33/ui/onboarding/onboarding_two/onboarding_two_view.dart'
    as _i7;
import 'package:oua_flutter33/ui/onboarding/onboarding_view.dart' as _i5;
import 'package:oua_flutter33/ui/post/last_edit_post/last_edit_post_view.dart'
    as _i22;
import 'package:oua_flutter33/ui/post/post_detail/post_detail_view.dart'
    as _i25;
import 'package:oua_flutter33/ui/post/send_post/send_post_view.dart' as _i20;
import 'package:oua_flutter33/ui/product/product-detail/product_view.dart'
    as _i17;
import 'package:oua_flutter33/ui/product/product_add/product_add_view.dart'
    as _i18;
import 'package:oua_flutter33/ui/profile/edited_profile/edited_profile_view.dart'
    as _i21;
import 'package:oua_flutter33/ui/profile/profile_view.dart' as _i12;
import 'package:oua_flutter33/ui/profile/settings/settings_view.dart' as _i13;
import 'package:oua_flutter33/ui/search/search_result/search_result_view.dart'
    as _i24;
import 'package:oua_flutter33/ui/search/search_view.dart' as _i14;
import 'package:oua_flutter33/ui/splash/splash_view.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i30;

class Routes {
  static const splashView = '/';

  static const mainView = '/main-view';

  static const homeView = '/home-view';

  static const onboardingView = '/onboarding-view';

  static const onboardingOneView = '/onboarding-one-view';

  static const onboardingTwoView = '/onboarding-two-view';

  static const loginView = '/login-view';

  static const registerView = '/register-view';

  static const exampleView = '/example-view';

  static const notificationView = '/notification-view';

  static const profileView = '/profile-view';

  static const settingsView = '/settings-view';

  static const searchView = '/search-view';

  static const chatListView = '/chat-list-view';

  static const chatView = '/chat-view';

  static const productDetailView = '/product-detail-view';

  static const productAddView = '/product-add-view';

  static const cartListView = '/cart-list-view';

  static const sendPostView = '/send-post-view';

  static const editedProfileView = '/edited-profile-view';

  static const lastEditPostView = '/last-edit-post-view';

  static const newChatView = '/new-chat-view';

  static const searchResultView = '/search-result-view';

  static const postDetailView = '/post-detail-view';

  static const all = <String>{
    splashView,
    mainView,
    homeView,
    onboardingView,
    onboardingOneView,
    onboardingTwoView,
    loginView,
    registerView,
    exampleView,
    notificationView,
    profileView,
    settingsView,
    searchView,
    chatListView,
    chatView,
    productDetailView,
    productAddView,
    cartListView,
    sendPostView,
    editedProfileView,
    lastEditPostView,
    newChatView,
    searchResultView,
    postDetailView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.mainView,
      page: _i3.MainView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i4.HomeView,
    ),
    _i1.RouteDef(
      Routes.onboardingView,
      page: _i5.OnboardingView,
    ),
    _i1.RouteDef(
      Routes.onboardingOneView,
      page: _i6.OnboardingOneView,
    ),
    _i1.RouteDef(
      Routes.onboardingTwoView,
      page: _i7.OnboardingTwoView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i8.LoginView,
    ),
    _i1.RouteDef(
      Routes.registerView,
      page: _i9.RegisterView,
    ),
    _i1.RouteDef(
      Routes.exampleView,
      page: _i10.ExampleView,
    ),
    _i1.RouteDef(
      Routes.notificationView,
      page: _i11.NotificationView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i12.ProfileView,
    ),
    _i1.RouteDef(
      Routes.settingsView,
      page: _i13.SettingsView,
    ),
    _i1.RouteDef(
      Routes.searchView,
      page: _i14.SearchView,
    ),
    _i1.RouteDef(
      Routes.chatListView,
      page: _i15.ChatListView,
    ),
    _i1.RouteDef(
      Routes.chatView,
      page: _i16.ChatView,
    ),
    _i1.RouteDef(
      Routes.productDetailView,
      page: _i17.ProductDetailView,
    ),
    _i1.RouteDef(
      Routes.productAddView,
      page: _i18.ProductAddView,
    ),
    _i1.RouteDef(
      Routes.cartListView,
      page: _i19.CartListView,
    ),
    _i1.RouteDef(
      Routes.sendPostView,
      page: _i20.SendPostView,
    ),
    _i1.RouteDef(
      Routes.editedProfileView,
      page: _i21.EditedProfileView,
    ),
    _i1.RouteDef(
      Routes.lastEditPostView,
      page: _i22.LastEditPostView,
    ),
    _i1.RouteDef(
      Routes.newChatView,
      page: _i23.NewChatView,
    ),
    _i1.RouteDef(
      Routes.searchResultView,
      page: _i24.SearchResultView,
    ),
    _i1.RouteDef(
      Routes.postDetailView,
      page: _i25.PostDetailView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashView(),
        settings: data,
      );
    },
    _i3.MainView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.MainView(),
        settings: data,
      );
    },
    _i4.HomeView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.HomeView(),
        settings: data,
      );
    },
    _i5.OnboardingView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.OnboardingView(),
        settings: data,
      );
    },
    _i6.OnboardingOneView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.OnboardingOneView(),
        settings: data,
      );
    },
    _i7.OnboardingTwoView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.OnboardingTwoView(),
        settings: data,
      );
    },
    _i8.LoginView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.LoginView(),
        settings: data,
      );
    },
    _i9.RegisterView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.RegisterView(),
        settings: data,
      );
    },
    _i10.ExampleView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.ExampleView(),
        settings: data,
      );
    },
    _i11.NotificationView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.NotificationView(),
        settings: data,
      );
    },
    _i12.ProfileView: (data) {
      final args = data.getArgs<ProfileViewArguments>(
        orElse: () => const ProfileViewArguments(),
      );
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i12.ProfileView(key: args.key, profileUid: args.profileUid),
        settings: data,
      );
    },
    _i13.SettingsView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.SettingsView(),
        settings: data,
      );
    },
    _i14.SearchView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.SearchView(),
        settings: data,
      );
    },
    _i15.ChatListView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.ChatListView(),
        settings: data,
      );
    },
    _i16.ChatView: (data) {
      final args = data.getArgs<ChatViewArguments>(nullOk: false);
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i16.ChatView(key: args.key, receiverUser: args.receiverUser),
        settings: data,
      );
    },
    _i17.ProductDetailView: (data) {
      final args = data.getArgs<ProductDetailViewArguments>(nullOk: false);
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i17.ProductDetailView(key: args.key, productId: args.productId),
        settings: data,
      );
    },
    _i18.ProductAddView: (data) {
      final args = data.getArgs<ProductAddViewArguments>(
        orElse: () => const ProductAddViewArguments(),
      );
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i18.ProductAddView(key: args.key, productId: args.productId),
        settings: data,
      );
    },
    _i19.CartListView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i19.CartListView(),
        settings: data,
      );
    },
    _i20.SendPostView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i20.SendPostView(),
        settings: data,
      );
    },
    _i21.EditedProfileView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i21.EditedProfileView(),
        settings: data,
      );
    },
    _i22.LastEditPostView: (data) {
      final args = data.getArgs<LastEditPostViewArguments>(nullOk: false);
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => _i22.LastEditPostView(
            key: args.key, images: args.images, products: args.products),
        settings: data,
      );
    },
    _i23.NewChatView: (data) {
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => const _i23.NewChatView(),
        settings: data,
      );
    },
    _i24.SearchResultView: (data) {
      final args = data.getArgs<SearchResultViewArguments>(nullOk: false);
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) => _i24.SearchResultView(
            key: args.key,
            searchText: args.searchText,
            location: args.location,
            searchType: args.searchType,
            category: args.category,
            subcategory: args.subcategory,
            subSubCategory: args.subSubCategory),
        settings: data,
      );
    },
    _i25.PostDetailView: (data) {
      final args = data.getArgs<PostDetailViewArguments>(nullOk: false);
      return _i26.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i25.PostDetailView(key: args.key, postId: args.postId),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class ProfileViewArguments {
  const ProfileViewArguments({
    this.key,
    this.profileUid,
  });

  final _i26.Key? key;

  final String? profileUid;

  @override
  String toString() {
    return '{"key": "$key", "profileUid": "$profileUid"}';
  }

  @override
  bool operator ==(covariant ProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.profileUid == profileUid;
  }

  @override
  int get hashCode {
    return key.hashCode ^ profileUid.hashCode;
  }
}

class ChatViewArguments {
  const ChatViewArguments({
    this.key,
    required this.receiverUser,
  });

  final _i26.Key? key;

  final _i27.User receiverUser;

  @override
  String toString() {
    return '{"key": "$key", "receiverUser": "$receiverUser"}';
  }

  @override
  bool operator ==(covariant ChatViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.receiverUser == receiverUser;
  }

  @override
  int get hashCode {
    return key.hashCode ^ receiverUser.hashCode;
  }
}

class ProductDetailViewArguments {
  const ProductDetailViewArguments({
    this.key,
    required this.productId,
  });

  final _i26.Key? key;

  final String productId;

  @override
  String toString() {
    return '{"key": "$key", "productId": "$productId"}';
  }

  @override
  bool operator ==(covariant ProductDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.productId == productId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ productId.hashCode;
  }
}

class ProductAddViewArguments {
  const ProductAddViewArguments({
    this.key,
    this.productId,
  });

  final _i26.Key? key;

  final String? productId;

  @override
  String toString() {
    return '{"key": "$key", "productId": "$productId"}';
  }

  @override
  bool operator ==(covariant ProductAddViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.productId == productId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ productId.hashCode;
  }
}

class LastEditPostViewArguments {
  const LastEditPostViewArguments({
    this.key,
    required this.images,
    required this.products,
  });

  final _i26.Key? key;

  final List<_i28.XFile> images;

  final List<_i29.Product> products;

  @override
  String toString() {
    return '{"key": "$key", "images": "$images", "products": "$products"}';
  }

  @override
  bool operator ==(covariant LastEditPostViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.images == images &&
        other.products == products;
  }

  @override
  int get hashCode {
    return key.hashCode ^ images.hashCode ^ products.hashCode;
  }
}

class SearchResultViewArguments {
  const SearchResultViewArguments({
    this.key,
    this.searchText,
    this.location,
    required this.searchType,
    this.category,
    this.subcategory,
    this.subSubCategory,
  });

  final _i26.Key? key;

  final String? searchText;

  final String? location;

  final String searchType;

  final String? category;

  final String? subcategory;

  final String? subSubCategory;

  @override
  String toString() {
    return '{"key": "$key", "searchText": "$searchText", "location": "$location", "searchType": "$searchType", "category": "$category", "subcategory": "$subcategory", "subSubCategory": "$subSubCategory"}';
  }

  @override
  bool operator ==(covariant SearchResultViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.searchText == searchText &&
        other.location == location &&
        other.searchType == searchType &&
        other.category == category &&
        other.subcategory == subcategory &&
        other.subSubCategory == subSubCategory;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        searchText.hashCode ^
        location.hashCode ^
        searchType.hashCode ^
        category.hashCode ^
        subcategory.hashCode ^
        subSubCategory.hashCode;
  }
}

class PostDetailViewArguments {
  const PostDetailViewArguments({
    this.key,
    required this.postId,
  });

  final _i26.Key? key;

  final String postId;

  @override
  String toString() {
    return '{"key": "$key", "postId": "$postId"}';
  }

  @override
  bool operator ==(covariant PostDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.postId == postId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ postId.hashCode;
  }
}

extension NavigatorStateExtension on _i30.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.mainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOnboardingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.onboardingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOnboardingOneView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.onboardingOneView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOnboardingTwoView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.onboardingTwoView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExampleView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.exampleView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNotificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.notificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView({
    _i26.Key? key,
    String? profileUid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.profileView,
        arguments: ProfileViewArguments(key: key, profileUid: profileUid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSearchView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.searchView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChatListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.chatListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChatView({
    _i26.Key? key,
    required _i27.User receiverUser,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.chatView,
        arguments: ChatViewArguments(key: key, receiverUser: receiverUser),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProductDetailView({
    _i26.Key? key,
    required String productId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.productDetailView,
        arguments: ProductDetailViewArguments(key: key, productId: productId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProductAddView({
    _i26.Key? key,
    String? productId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.productAddView,
        arguments: ProductAddViewArguments(key: key, productId: productId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCartListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.cartListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSendPostView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.sendPostView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditedProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.editedProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLastEditPostView({
    _i26.Key? key,
    required List<_i28.XFile> images,
    required List<_i29.Product> products,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.lastEditPostView,
        arguments: LastEditPostViewArguments(
            key: key, images: images, products: products),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNewChatView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.newChatView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSearchResultView({
    _i26.Key? key,
    String? searchText,
    String? location,
    required String searchType,
    String? category,
    String? subcategory,
    String? subSubCategory,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.searchResultView,
        arguments: SearchResultViewArguments(
            key: key,
            searchText: searchText,
            location: location,
            searchType: searchType,
            category: category,
            subcategory: subcategory,
            subSubCategory: subSubCategory),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPostDetailView({
    _i26.Key? key,
    required String postId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.postDetailView,
        arguments: PostDetailViewArguments(key: key, postId: postId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMainView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.mainView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOnboardingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.onboardingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOnboardingOneView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.onboardingOneView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOnboardingTwoView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.onboardingTwoView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExampleView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.exampleView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNotificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.notificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView({
    _i26.Key? key,
    String? profileUid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.profileView,
        arguments: ProfileViewArguments(key: key, profileUid: profileUid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSearchView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.searchView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChatListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.chatListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChatView({
    _i26.Key? key,
    required _i27.User receiverUser,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.chatView,
        arguments: ChatViewArguments(key: key, receiverUser: receiverUser),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProductDetailView({
    _i26.Key? key,
    required String productId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.productDetailView,
        arguments: ProductDetailViewArguments(key: key, productId: productId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProductAddView({
    _i26.Key? key,
    String? productId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.productAddView,
        arguments: ProductAddViewArguments(key: key, productId: productId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCartListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.cartListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSendPostView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.sendPostView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditedProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.editedProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLastEditPostView({
    _i26.Key? key,
    required List<_i28.XFile> images,
    required List<_i29.Product> products,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.lastEditPostView,
        arguments: LastEditPostViewArguments(
            key: key, images: images, products: products),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNewChatView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.newChatView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSearchResultView({
    _i26.Key? key,
    String? searchText,
    String? location,
    required String searchType,
    String? category,
    String? subcategory,
    String? subSubCategory,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.searchResultView,
        arguments: SearchResultViewArguments(
            key: key,
            searchText: searchText,
            location: location,
            searchType: searchType,
            category: category,
            subcategory: subcategory,
            subSubCategory: subSubCategory),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPostDetailView({
    _i26.Key? key,
    required String postId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.postDetailView,
        arguments: PostDetailViewArguments(key: key, postId: postId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
