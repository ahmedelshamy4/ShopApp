import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../route/route_constant.dart';
import '../../../shared/components/custom_favourite_icon.dart';
import '../../../shared/components/custom_text.dart';
import '../../../shared/components/navigate.dart';
import '../../../shared/constants/colors.dart';
import '../../product_details.dart/cubit/product_details_cubit.dart';
import '../cubit/home_cubit.dart';

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
          BlocProvider.of<ProductDetailsCubit>(context)
              .changeSmallPhotoIndex(0);
          BlocProvider.of<ProductDetailsCubit>(context)
              .getProductDetailsData(productId: data.id);
          navigateWithArgument(
            context,
            RouteConstant.productDetailsRoute,
            data.id,
          );
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
                ],
              ),
              if (index.isOdd) const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  left: 10.0,
                  right: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: data.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14,
                      height: 1.3,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'EGP ${data.price}',
                              fontSize: 14,
                              height: 1.3,
                              fontWeight: FontWeight.w400,
                              textColor: mainColor,
                            ),
                            if (data.discount != 0)
                              CustomText(
                                text: ' ${data.oldPrice} EGP',
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13,
                                height: 1.3,
                                textColor: grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                          ],
                        ),
                        const Spacer(),
                        CustomFavouriteIcon(
                          productId: data.id,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
