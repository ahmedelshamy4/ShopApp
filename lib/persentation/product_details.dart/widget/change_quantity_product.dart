import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/custom_text.dart';

import '../../../shared/constants/colors.dart';
import '../cubit/product_details_cubit.dart';

class ChangeQuantityProduct extends StatelessWidget {
  const ChangeQuantityProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetailsCubit = BlocProvider.of<ProductDetailsCubit>(context);
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  primary: mainColor,
                ),
                child: const Icon(
                  Icons.remove,
                  color: white,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  primary: mainColor,
                ),
                child: const Icon(
                  Icons.add,
                  color: white,
                  size: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
