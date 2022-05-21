import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../data/models/favourite_model/favourites_model.dart';
import 'custom_card.dart';
import 'custom_favourite_icon.dart';
import 'custom_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/constants/colors.dart';

class BuildItem extends StatelessWidget {
  final int itemId;
  final bool? isFavouriteScreen;
  final FavouriteDataDetails model;
  const BuildItem({
    Key? key,
    required this.itemId,
    this.isFavouriteScreen,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      height: MediaQuery.of(context).size.height / 8.0,
      width: MediaQuery.of(context).size.width,
      widget: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                CachedNetworkImage(
                  width: 80,
                  height: 80,
                  imageUrl: model.image,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[100]!,
                    highlightColor: Colors.grey[300]!,
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                  ),
                ),
                if (model.discount != 0)
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10,
                  right: 10,
                  left: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14,
                      height: 1.3,
                      fontWeight: FontWeight.w400,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        CustomText(
                          text: 'EGP ${model.price.toString()}',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          textColor: mainColor,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (model.discount != 0)
                          CustomText(
                            text: 'EGP ${model.oldPrice.toString()}',
                            fontSize: 13,
                            textColor: grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        const Spacer(),
                        CustomFavouriteIcon(
                          productId: model.id,
                          isFavouriteScreen: isFavouriteScreen,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
