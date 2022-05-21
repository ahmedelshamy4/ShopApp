import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../route/route_constant.dart';
import '../../../shared/components/custom_text.dart';
import '../../../shared/components/empty_screen.dart';
import '../../../shared/components/loading.dart';
import '../../../shared/components/navigate.dart';
import '../../../shared/components/network_disconnected.dart';
import '../../../shared/constants/colors.dart';
import '../../bottom_NavBar_screen/cubit/bottom_nav_bar_cubit.dart';
import '../cubit/basket_cubit.dart';
import '../widget/basket_Item.dart';

class BasketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final basketCubit = BlocProvider.of<BasketCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'My Basket',
          textColor: mainColor,
          textAlign: TextAlign.center,
          fontSize: 20.0,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_sharp, color: mainColor),
        ),
      ),
      body: RefreshIndicator(
        child: BlocBuilder<BasketCubit, BasketState>(
          builder: (context, state) {
            if (state is BasketGetOrderLoading) {
              return const Center(child: CustomLoading());
            } else if (state is BasketGetOrderError) {
              return NetworkDisconnected(
                onPress: () {
                  basketCubit.getMyBasketData();
                },
              );
            } else {
              return basketCubit.myBasketOrders.data.cartItems.isEmpty
                  ? EmptyScreen(onPress: () {
                      BlocProvider.of<BottomNavBarCubit>(context)
                          .changeCurrentIndex(2);
                      navigatorAndFinish(
                        context,
                        RouteConstant.shopLayoutRoute,
                      );
                    })
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return BasketItem(index: index);
                            },
                            itemCount: basketCubit
                                .myBasketOrders.data.cartItems.length,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: 110.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              CustomText(
                                text:
                                    ' Total: ${basketCubit.myBasketOrders.data.total} EGP',
                                fontSize: 18.0,
                                textColor: mainColor,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            }
          },
        ),
        onRefresh: () async {
          Future.wait([basketCubit.getMyBasketData()]);
        },
      ),
    );
  }
}
