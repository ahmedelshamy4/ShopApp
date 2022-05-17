import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_store/data/web_services/local/pref/pref_setup.dart';
import 'package:flutter_shop_store/data/web_services/local/pref/routing_prefs.dart';
import 'package:flutter_shop_store/data/web_services/remote/dio_helper.dart';
import 'package:flutter_shop_store/my_bloc_observer.dart';
import 'package:flutter_shop_store/route/app_router.dart';

import 'my_app.dart';
import 'shared/constants/constant.dart';

Future<void> main() async {
  // to ensure that all method  in project finish loading then open app
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await SharedPrefs.init();

  log('token:$userToken');
  BlocOverrides.runZoned(
    () {
      runApp(
        ShopApp(
          appRouter: AppRouter(),
          initialRoute: RoutingPrefs.getInitialRoute(),
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}
