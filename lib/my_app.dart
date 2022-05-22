import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_store/data/repository/address_repository/address_repository.dart';
import 'package:flutter_shop_store/data/repository/orders_repository/orders_Repository.dart';
import 'package:flutter_shop_store/persentation/Orders/cubit/orders_cubit.dart';
import 'package:flutter_shop_store/persentation/address/cubit/address_cubit.dart';
import 'package:flutter_shop_store/persentation/update_profile/cubit/update_profile_cubit.dart';

import 'data/repository/basket_repository/basket_repository.dart';
import 'data/repository/favourite_repository/favourite_repository.dart';
import 'data/repository/home_repository/home_repo.dart';
import 'data/repository/notification_repository/notification_repository.dart';
import 'data/repository/product_details_repository/product_details_repository.dart';
import 'data/repository/search_repository/search_repository.dart';
import 'data/repository/user_repository/login_repo.dart';
import 'data/repository/user_repository/logout.dart';
import 'data/repository/user_repository/profile_repo.dart';
import 'data/repository/user_repository/register_repo.dart';
import 'data/web_services/local/pref/user_pref.dart';
import 'persentation/auth/login/cubit/login_cubit.dart';
import 'persentation/auth/logout/cubit/logout_cubit.dart';
import 'persentation/auth/signUp/cubit/singup_cubit.dart';
import 'persentation/basket/cubit/basket_cubit.dart';
import 'persentation/bottom_NavBar_screen/cubit/bottom_nav_bar_cubit.dart';
import 'persentation/favourites/cubit/favourite_cubit.dart';
import 'persentation/home/cubit/home_cubit.dart';
import 'persentation/notifications/cubit/notification_cubit.dart';
import 'persentation/on_boarding/cubit/on_boarding_cubit.dart';
import 'persentation/product_details.dart/cubit/product_details_cubit.dart';
import 'persentation/profile/cubit/profile_cubit.dart';
import 'persentation/search/cubit/search_cubit.dart';
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
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
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
          create: (context) => SearchCubit(SearchRepository()),
        ),
        BlocProvider(
          create: (context) =>
              OrdersCubit(OrdersRepository(UserPrefs()))..getOrder(),
        ),
        BlocProvider(
          create: (context) =>
              BasketCubit(BasketRepository(UserPrefs()))..getMyBasketData(),
        ),
        BlocProvider(
          create: (context) =>
              UpdateProfileCubit(ProfileRepository(UserPrefs())),
        ),
        BlocProvider(
          create: (context) => FavouriteCubit(FavouriteRepository(UserPrefs()))
            ..getFavouritesData(),
        ),
        BlocProvider(
          create: (context) => LogoutCubit(LogoutRepository(UserPrefs())),
        ),
        BlocProvider(
          create: (context) =>
              AddressCubit(AddressRepository(UserPrefs()))..getMyAddressData(),
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
