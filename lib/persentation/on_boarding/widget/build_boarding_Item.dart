import 'package:flutter/cupertino.dart';
import '../../../shared/components/custom_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/constants/colors.dart';
import '../cubit/on_boarding_cubit.dart';

class BuildBoardingItem extends StatelessWidget {
  final OnBoardingModel model;
  final int splashLength;
  final PageController controller;
  const BuildBoardingItem({
    Key? key,
    required this.model,
    required this.splashLength,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 40, right: 20, left: 20, bottom: 20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: SvgPicture.asset(
                model.image,
                fit: BoxFit.fitWidth,
              ),
            ),
            SmoothPageIndicator(
              count: 3,
              controller: controller,
              effect: const WormEffect(
                dotWidth: 15,
                activeDotColor: mainColor,
                dotColor: Color(0xffE4C6A9),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 50),
              child: CustomText(
                text: model.title,
                fontSize: size.width >= 500 ? 25 : size.width / 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            CustomText(
              text: model.body,
              textAlign: TextAlign.center,
              fontSize: size.width >= 500 ? 18 : size.width / 22,
              textColor: grey,
            ),
          ],
        ),
      ),
    );
  }
}
