import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_store/shared/components/custom_text.dart';

import '../../../shared/components/custom_favourite_icon.dart';
import '../../../shared/constants/colors.dart';
import '../cubit/product_details_cubit.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetailsCubit = BlocProvider.of<ProductDetailsCubit>(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10.0, top: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFC4C4C4).withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(
                text:
                    'EGP ${productDetailsCubit.productDetailsModel.data.price}',
                textColor: mainColor,
              ),
              if (productDetailsCubit.productDetailsModel.data.discount != 0)
                CustomText(
                  text:
                      'EGP ${productDetailsCubit.productDetailsModel.data.oldPrice}',
                  fontSize: 14.0,
                  decoration: TextDecoration.lineThrough,
                  textColor: mainColor,
                ),
              const Spacer(),
              CustomFavouriteIcon(
                productId: productDetailsCubit.productDetailsModel.data.id,
                iconSize: 40.0,
              ),
              const SizedBox(width: 10.0),
            ],
          )
        ],
      ),
    );
  }
}
