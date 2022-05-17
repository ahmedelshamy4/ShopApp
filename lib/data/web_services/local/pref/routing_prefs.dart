import 'package:flutter_shop_store/data/web_services/local/pref/pref_setup.dart';
import 'package:flutter_shop_store/route/route_constant.dart';

class RoutingPrefs {
  RoutingPrefs._();

  static void setOnBoardingSeen() =>
      SharedPrefs.preferences.setBool("seen", true);

  static bool getOnBoardindSeen() =>
      SharedPrefs.preferences.getBool("seen") ?? false;

  static String getInitialRoute() => getOnBoardindSeen() == true
      ? RouteConstant.shopLayoutRoute
      : RouteConstant.onBoardingRoute;
}
