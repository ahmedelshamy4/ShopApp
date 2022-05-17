import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_store/persentation/bottom_NavBar_screen/cubit/bottom_nav_bar_cubit.dart';
import 'package:flutter_shop_store/shared/constants/colors.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        final bottomNavBarCubit = BlocProvider.of<BottomNavBarCubit>(context);
        return Scaffold(
          appBar: bottomNavBarCubit
              .appBarScreen[bottomNavBarCubit.currentPageIndex],
          body: Stack(
            children: [
              bottomNavBarCubit.bodyScreen[bottomNavBarCubit.currentPageIndex],
              Positioned(
                bottom: 0.0,
                right: 0.0,
                left: 0.0,
                child: CurvedNavigationBar(
                  index: bottomNavBarCubit.currentPageIndex,
                  height: 50,
                  backgroundColor: Colors.transparent,
                  color: mainColor,
                  buttonBackgroundColor: mainColor,
                  items: bottomNavBarCubit.bottomNavIcons,
                  onTap: (index) => bottomNavBarCubit.changeCurrentIndex(index),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
