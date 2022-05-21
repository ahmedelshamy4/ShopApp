import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';

import '../../persentation/favourites/cubit/favourite_cubit.dart';
import '../../persentation/home/cubit/home_cubit.dart';
import '../constants/colors.dart';

class CustomFavouriteIcon extends StatelessWidget {
  final double iconSize;
  final bool? isFavouriteScreen;
  final int productId;
  const CustomFavouriteIcon({
    Key? key,
    this.iconSize = 25.0,
    this.isFavouriteScreen,
    required this.productId,
  }) : super(key: key);

  Future<bool> onLikeButtonTap({
    required bool isLiked,
    required BuildContext context,
    required int productId,
  }) async {
    BlocProvider.of<HomeCubit>(context).changeHomeFavourites(productId);
    BlocProvider.of<FavouriteCubit>(context).changeFavourites(productId);
    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return LikeButton(
      circleColor: const CircleColor(
        start: Colors.redAccent,
        end: Colors.orange,
      ),
      onTap: (bool isLiked) {
        return onLikeButtonTap(
          isLiked: isLiked,
          context: context,
          productId: productId,
        );
      },
      likeBuilder: (_) => Icon(
        Icons.favorite,
        size: iconSize,
        color: isFavouriteScreen != null
            ? red
            : homeCubit.favourites[productId]!
                ? red
                : grey,
      ),
    );
  }
}
