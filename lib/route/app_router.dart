import 'package:flutter/material.dart';
import 'package:flutter_shop_store/persentation/auth/login/screen/login_screen.dart';
import 'package:flutter_shop_store/persentation/on_boarding/screen/on_boarding_screen.dart';
import 'package:flutter_shop_store/persentation/product_details.dart/screen/product_details.dart';
import 'package:flutter_shop_store/route/route_constant.dart';

import '../data/web_services/local/pref/user_pref.dart';
import '../persentation/auth/signUp/screen/register_screen.dart';
import '../persentation/bottom_NavBar_screen/screen/shop_layout.dart';

class AppRouter {
  late UserPrefs userPrefs;
  void initAppSettings() {
    userPrefs = UserPrefs();
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
