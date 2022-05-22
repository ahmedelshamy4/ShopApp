import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_store/persentation/address/cubit/address_cubit.dart';
import 'package:flutter_shop_store/shared/components/custom_button.dart';

import '../../../shared/components/custom_text.dart';
import '../../../shared/components/loading.dart';
import '../../../shared/components/toast.dart';
import '../../../shared/constants/colors.dart';
import '../widget/form_address.dart';

class AddAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const CustomText(
          text: 'new address',
          textColor: mainColor,
          fontSize: 20.0,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_sharp, color: mainColor),
        ),
      ),
      body: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state is AddAddressSuccess) {
            showToast(
              state: ToastStates.success,
              message: 'address added successfully',
            );
            Navigator.pop(context);
            addressCubit.clearTextFromField();
          } else if (state is AddAddressError) {
            showToast(
              state: ToastStates.error,
              message: 'something wrong try again later',
            );
          }
        },
        builder: (context, state) {
          if (state is AddAddressLoading) {
            return const CustomLoading();
          } else {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      FormAddress(),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 30.0,
                          left: 30.0,
                          top: 50.0,
                        ),
                        child: CustomButton(
                          onPressed: () {
                            if (addressCubit.formKey.currentState!.validate()) {
                              addressCubit.addNewAddressData();
                            }
                          },
                          text: 'Save new address',
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
