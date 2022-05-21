import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/web_services/local/pref/routing_prefs.dart';
import '../../../route/route_constant.dart';
import '../../../shared/components/navigate.dart';

import '../../../shared/constants/colors.dart';
import '../cubit/on_boarding_cubit.dart';
import '../widget/build_boarding_Item.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController boardingController = PageController();

  @override
  void initState() {
    super.initState();
    RoutingPrefs.setOnBoardingSeen();
  }

  @override
  Widget build(BuildContext context) {
    final boardingCubit = BlocProvider.of<OnBoardingCubit>(context);
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: PageView.builder(
                itemCount: boardingCubit.items.length,
                controller: boardingController,
                onPageChanged: (int index) {
                  (index == boardingCubit.items.length - 1)
                      ? boardingCubit.checkLastPage(changeText: true)
                      : boardingCubit.checkLastPage(changeText: false);
                },
                itemBuilder: (context, index) {
                  return BuildBoardingItem(
                    model: boardingCubit.items[index],
                    splashLength: boardingCubit.items.length,
                    controller: boardingController,
                  );
                },
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: mainColor,
            onPressed: () {
              (boardingCubit.isLastPage)
                  ? navigatorAndFinish(context, RouteConstant.loginRoute)
                  : boardingController.nextPage(
                      duration: const Duration(microseconds: 5000),
                      curve: Curves.easeIn);
            },
            child: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
