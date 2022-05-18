import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_store/data/repository/home_repository/home_repo.dart';
import 'package:flutter_shop_store/data/repository/notification_repository/notification_repository.dart';
import 'package:flutter_shop_store/data/repository/product_details_repository/product_details_repository.dart';

import 'package:flutter_shop_store/data/repository/user_repository/login_repo.dart';
import 'package:flutter_shop_store/data/repository/user_repository/logout.dart';
import 'package:flutter_shop_store/data/repository/user_repository/profile_repo.dart';
import 'package:flutter_shop_store/data/repository/user_repository/register_repo.dart';
import 'package:flutter_shop_store/data/web_services/local/pref/user_pref.dart';
import 'package:flutter_shop_store/persentation/auth/login/cubit/login_cubit.dart';
import 'package:flutter_shop_store/persentation/auth/logout/cubit/logout_cubit.dart';
import 'package:flutter_shop_store/persentation/auth/signUp/cubit/singup_cubit.dart';
import 'package:flutter_shop_store/persentation/home/cubit/home_cubit.dart';
import 'package:flutter_shop_store/persentation/notifications/cubit/notification_cubit.dart';
import 'package:flutter_shop_store/persentation/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:flutter_shop_store/persentation/product_details.dart/cubit/product_details_cubit.dart';
import 'package:flutter_shop_store/persentation/profile/cubit/profile_cubit.dart';

import 'persentation/bottom_NavBar_screen/cubit/bottom_nav_bar_cubit.dart';
import 'route/app_router.dart';
import 'shared/styles/themes.dart';

class ShopApp extends StatelessWidget {
  final AppRouter appRouter;
  final String? initialRoute;
  const ShopApp({
    Key? key,
    required this.appRouter,
    required this.initialRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnBoardingCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(LoginRepository()),
        ),
        BlocProvider(
          create: (context) => SingupCubit(RegisterRepository()),
        ),
        BlocProvider(
          create: (context) => LogoutCubit(LogoutRepository(UserPrefs())),
        ),
        BlocProvider(
          create: (context) => ProductDetailsCubit(ProductDetailsRepository()),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(ProfileRepository(UserPrefs())),
        ),
        BlocProvider(
          create: (context) => BottomNavBarCubit(),
        ),
        BlocProvider(
          create: (context) => NotificationCubit(NotificationsRepository())
            ..getNotificationsData(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(HomeRepository())..getHomeData(),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
          title: 'Shop App',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          initialRoute: initialRoute,
          onGenerateRoute: appRouter.generateRoute,
        ),
      ),
    );
  }
}
