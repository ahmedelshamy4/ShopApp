import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/product_details_cubit.dart';
import '../widget/product_details_button.dart';
import '../../../shared/components/loading.dart';
import '../../../shared/components/network_disconnected.dart';

import '../widget/app_bar.dart';
import '../widget/product_description.dart';
import '../widget/product_details_photo.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({required this.productId});
  @override
  Widget build(BuildContext context) {
    final productDetailsCubit = BlocProvider.of<ProductDetailsCubit>(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const Center(child: CustomLoading());
            } else if (state is ProductDetailsError) {
              return NetworkDisconnected(onPress: () {
                productDetailsCubit.getProductDetailsData(productId: productId);
              });
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    const ProductDetailsAppBar(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80.0),
                        ProductDetailsPhotos(),
                        const SizedBox(height: 10.0),
                        Expanded(
                          child: ProductDescription(),
                        ),
                      ],
                    ),
                    ProductDetailsButton(
                      productId:
                          productDetailsCubit.productDetailsModel.data.id,
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
