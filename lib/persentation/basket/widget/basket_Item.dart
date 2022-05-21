import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/basket_cubit.dart';
import '../../../shared/components/custom_card.dart';
import '../../../shared/components/custom_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/constants/colors.dart';

class BasketItem extends StatelessWidget {
  final int index;
  const BasketItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = BlocProvider.of<BasketCubit>(context)
        .myBasketOrders
        .data
        .cartItems[index];
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
      child: InkWell(
        onTap: () {},
        child: CustomCard(
          height: 140,
          paddingTop: 15.0,
          paddingBottom: 10.0,
          widget: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  CachedNetworkImage(
                    height: 80.0,
                    width: 80.0,
                    imageUrl: data.product.image,
                    placeholder: (context, url) => Container(
                      height: 80.0,
                      width: 80.0,
                      color: Colors.white,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[100]!,
                        highlightColor: Colors.grey[300]!,
                        child: Image.asset(
                          'assets/images/logo.png',
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                    ),
                  ),
                  if (data.product.discount != 0)
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/icons/discount.svg',
                        fit: BoxFit.cover,
                        height: 30,
                        width: 30,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 10.0),
              Expanded(
                  child: Column(
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: 'EGP ${data.product.price.toString()}',
                        fontSize: 15.0,
                        height: 1.0,
                        fontWeight: FontWeight.w600,
                        textColor: mainColor,
                      ),
                      const SizedBox(width: 5.0),
                      if (data.product.discount != 0)
                        CustomText(
                          text: 'EGP ${data.product.oldPrice.toString()}',
                          fontSize: 13.0,
                          height: 1.0,
                          textColor: grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: CustomText(
                      text: data.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 13.0,
                      height: 1.3,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
