import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_store/shared/components/loading.dart';
import 'package:flutter_shop_store/shared/components/network_disconnected.dart';
import '../cubit/home_cubit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widget/banner_item.dart';
import '../widget/product_Item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(
            child: CustomLoading(),
          );
        } else {
          if (state is HomeError) {
            return NetworkDisconnected(
              onPress: () {
                homeCubit.getHomeData();
              },
            );
          } else {
            return RefreshIndicator(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      BannerWidget(),
                      StaggeredGridView.countBuilder(
                        padding: const EdgeInsets.only(bottom: 70.0),
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        itemCount: homeCubit.homeModel.data.productData.length,
                        itemBuilder: (BuildContext context, index) =>
                            ProductItem(
                          index: index,
                        ),
                        staggeredTileBuilder: (int index) =>
                            const StaggeredTile.fit(1),
                      )
                    ],
                  ),
                ),
                onRefresh: () async {
                  await Future.wait([
                    homeCubit.getHomeData(),
                  ]);
                });
          }
        }
      },
    );
  }
}
