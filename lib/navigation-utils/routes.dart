import 'package:get/get.dart';
import 'package:splitify/user_detail_page/home_page/bottom_navigation.dart';

import '../user_detail_page/database/signin_page.dart';
import '../user_detail_page/first_screen/user_detail.dart';
import '../user_detail_page/splash_secreen/splash_screen.dart';
import '../user_detail_page/second_secreen/userlist_page.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;
  static const splashscreen = "/splashscreen";
  static const bottomPage = "/BottomPage";
  static const userListPage = "/UserListPage";
  static const signInPage = "/SignInPage";
  static const userDetail = "/UserDetail";

  static List<GetPage<dynamic>> pages = [
    GetPage<dynamic>(
      name: splashscreen,
      page: () => SplashScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: bottomPage,
      page: () => BottomPage(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: userListPage,
      page: () => UserListPage(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: signInPage,
      page: () => SignInPage(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: signInPage,
      page: () => UserDetail(),
      transition: defaultTransition,
    ),
  ];
}
