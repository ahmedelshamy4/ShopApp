import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_store/persentation/home/cubit/home_cubit.dart';
import 'package:flutter_shop_store/route/route_constant.dart';
import 'package:flutter_shop_store/shared/components/navigate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/constants/colors.dart';

class ProductItem extends StatelessWidget {
  final int index;
  const ProductItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data =
        BlocProvider.of<HomeCubit>(context).homeModel.data.productData[index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          navigateWithArgument(
              context, RouteConstant.productDetailsRoute, data.id);
        },
        child: Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    height: 130.0,
                    width: double.infinity,
                    imageUrl: data.image,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Container(
                      height: 130.0,
                      color: Colors.white,
                      width: double.infinity,
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
                  if (data.discount != 0)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 10.0),
                        child: SvgPicture.asset(
                          'assets/icons/discount.svg',
                          fit: BoxFit.cover,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
