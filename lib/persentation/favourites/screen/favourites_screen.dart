import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../route/route_constant.dart';
import '../../../shared/components/build_item.dart';
import '../../../shared/components/empty_screen.dart';
import '../../../shared/components/loading.dart';
import '../../../shared/components/navigate.dart';
import '../../../shared/components/network_disconnected.dart';
import '../../bottom_NavBar_screen/cubit/bottom_nav_bar_cubit.dart';
import '../cubit/favourite_cubit.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favouriteCubit = BlocProvider.of<FavouriteCubit>(context);
    return RefreshIndicator(
      onRefresh: () async {
        Future.wait([
          BlocProvider.of<FavouriteCubit>(context).getFavouritesData(),
        ]);
      },
      child: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          if (state is GetFavoritesLoading) {
            return const Center(child: CustomLoading());
          } else {
            if (state is GetFavoritesError) {
              return NetworkDisconnected(
                onPress: () {
                  BlocProvider.of<FavouriteCubit>(context).getFavouritesData();
                },
              );
            } else {
              if (favouriteCubit.favouritesModel.data.isEmpty) {
                return SingleChildScrollView(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: EmptyScreen(
                      onPress: () {
                        BlocProvider.of<BottomNavBarCubit>(context)
                            .changeCurrentIndex(2);
                        navigatorAndFinish(
                          context,
                          RouteConstant.shopLayoutRoute,
                        );
                      },
                    ),
                  ),
                );
              } else {
                return ListView.separated(
                  padding: const EdgeInsets.all(10.0).copyWith(bottom: 70.0),
                  itemBuilder: (BuildContext context, int index) => BuildItem(
                    itemId:
                        favouriteCubit.favouritesModel.data[index].product.id,
                    model: favouriteCubit.favouritesModel.data[index].product,
                    isFavouriteScreen: true,
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 5.0),
                  itemCount: favouriteCubit.favouritesModel.data.length,
                );
              }
            }
          }
        },
      ),
    );
  }
}
