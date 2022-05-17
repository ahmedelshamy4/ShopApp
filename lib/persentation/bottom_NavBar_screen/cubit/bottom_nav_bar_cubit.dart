import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../shared/constants/colors.dart';
import '../../Account/screen/account_screen.dart';
import '../../Orders/screen/my_orders_screen.dart';
import '../../favourites/screen/favourites_screen.dart';
import '../../home/screen/home_screen.dart';
import '../../notifications/screen/notifications_screen.dart';
import '../screen/app_bar.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarInitial());

  int currentPageIndex = 2;

  List<PreferredSizeWidget> appBarScreen = [
    NotificationsAppBar(),
    FavouriteAppBar(),
    HomeAppBar(),
    OrdersAppBar(),
    AccountAppBar(),
  ];

  List<Widget> bodyScreen = [
    const NotificationsScreen(),
    const FavouritesScreen(),
    HomeScreen(),
    const MyOrdersScreen(),
    const AccountScreen(),
  ];
  List<Widget> bottomNavIcons = [
    const Icon(Icons.notifications, color: lightMainColor, size: 30.0),
    const Icon(Icons.favorite, color: lightMainColor, size: 30),
    const Icon(Icons.home, color: lightMainColor, size: 30.0),
    SizedBox(
      height: 30.0,
      width: 30.0,
      child: Image.asset(
        'assets/icons/bag.png',
        color: lightMainColor,
      ),
    ),
    const Icon(Icons.person, color: lightMainColor, size: 30.0),
  ];
  void changeCurrentIndex(int index) {
    currentPageIndex = index;
    emit(ChangeBottomNavState());
  }
}
