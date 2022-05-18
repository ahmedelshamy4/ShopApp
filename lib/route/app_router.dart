import 'package:flutter/material.dart';
import 'package:flutter_shop_store/persentation/auth/login/screen/login_screen.dart';
import 'package:flutter_shop_store/persentation/home/screen/home_screen.dart';
import 'package:flutter_shop_store/persentation/notifications/screen/notifications_screen.dart';
import 'package:flutter_shop_store/persentation/on_boarding/screen/on_boarding_screen.dart';
import 'package:flutter_shop_store/persentation/product_details.dart/screen/product_details.dart';
import 'package:flutter_shop_store/persentation/profile/screen/profile_screen.dart';
import 'package:flutter_shop_store/route/route_constant.dart';

import '../data/repository/home_repository/home_repo.dart';
import '../data/repository/product_details_repository/product_details_repository.dart';
import '../data/repository/user_repository/login_repo.dart';
import '../data/repository/user_repository/logout.dart';
import '../data/repository/user_repository/profile_repo.dart';
import '../data/repository/user_repository/register_repo.dart';
import '../data/web_services/local/pref/user_pref.dart';
import '../persentation/auth/signUp/screen/register_screen.dart';
import '../persentation/bottom_NavBar_screen/screen/shop_layout.dart';

class AppRouter {
  late UserPrefs userPrefs;
  late HomeRepository homeRepository;
  late LoginRepository loginRepo;
  late ProfileRepository profileRepository;
  late RegisterRepository registerRepository;
  late ProductDetailsRepository productDetailsRepository;
  late LogoutRepository logoutRepository;

  void initAppSettings() {
    userPrefs = UserPrefs();
    homeRepository = HomeRepository();
    loginRepo = LoginRepository();
    registerRepository = RegisterRepository();
    productDetailsRepository = ProductDetailsRepository();
    profileRepository = ProfileRepository(userPrefs);
    logoutRepository = LogoutRepository(userPrefs);
  }

  Route? generateRoute(RouteSettings settings) {
    initAppSettings();
    switch (settings.name) {
      case RouteConstant.onBoardingRoute:
        return MaterialPageRoute(
          builder: (_) => OnBoardingScreen(),
        );

      case RouteConstant.loginRoute:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

      case RouteConstant.registerRoute:
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(),
        );

      case RouteConstant.homeRoute:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );

      case RouteConstant.shopLayoutRoute:
        if (userPrefs.isUserLoggedIn()) {
          return MaterialPageRoute(
            builder: (_) => const BottomNavBarScreen(),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => LoginScreen(),
          );
        }

      case RouteConstant.productDetailsRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return ProductDetailsScreen(
              productId: settings.arguments! as int,
            );
          },
        );

      case RouteConstant.notificationsRoute:
        return MaterialPageRoute(
          builder: (_) => NotificationsScreen(),
        );

      case RouteConstant.profileRoute:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Route Defined For${settings.name}'),
            ),
          ),
        );
    }
  }
}
