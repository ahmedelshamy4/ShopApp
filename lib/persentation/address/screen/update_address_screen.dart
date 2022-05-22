import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_store/persentation/address/cubit/address_cubit.dart';
import 'package:flutter_shop_store/shared/components/custom_button.dart';

import '../../../shared/components/custom_text.dart';
import '../../../shared/components/toast.dart';
import '../../../shared/constants/colors.dart';
import '../widget/form_address.dart';

class UpdateAddressScreen extends StatelessWidget {
  final int index;

  const UpdateAddressScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const CustomText(
          text: 'Edit address',
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
          if (state is UpdateAddressSuccess) {
            showToast(
              state: ToastStates.success,
              message: 'address updated successfully',
            );
            Navigator.pop(context);
          } else if (state is UpdateAddressError) {
            showToast(
              state: ToastStates.error,
              message: 'something wrong please try again later',
            );
          }
        },
        builder: (context, state) {
          final addressData = addressCubit.addressModel.data[index];
          return SingleChildScrollView(
            child: Column(
              children: [
                FormAddress(),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 30.0,
                    left: 30.0,
                    top: 50.0,
                    bottom: 20.0,
                  ),
                  child: CustomButton(
                    onPressed: () {
                      if (addressCubit.formKey.currentState!.validate()) {
                        addressCubit.updateAddressData(
                          addressId: addressData.id,
                          buildingNumber:
                              addressCubit.buildingNumberControl.text,
                          city: addressCubit.cityControl.text,
                          region: addressCubit.regionControl.text,
                          details: addressCubit.addressDetailsControl.text,
                          notes: addressCubit.notesAddressControl.text,
                        );
                      }
                    },
                    text: 'Update address',
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
