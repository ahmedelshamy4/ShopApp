import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_store/persentation/address/cubit/address_cubit.dart';
import 'package:flutter_shop_store/shared/components/custom_button.dart';
import 'package:flutter_shop_store/shared/components/empty_screen.dart';
import 'package:flutter_shop_store/shared/components/network_disconnected.dart';

import '../../../route/route_constant.dart';
import '../../../shared/components/custom_dotedLine.dart';
import '../../../shared/components/custom_text.dart';
import '../../../shared/components/loading.dart';
import '../../../shared/components/navigate.dart';
import '../../../shared/components/toast.dart';
import '../../../shared/constants/colors.dart';

class MyAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'My Address',
          textColor: mainColor,
          textAlign: TextAlign.center,
          fontSize: 20.0,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_sharp, color: mainColor),
        ),
      ),
      body: RefreshIndicator(
          child: BlocConsumer<AddressCubit, AddressState>(
            listener: (context, state) {
              if (state is DeleteAddressOrderSuccess) {
                showToast(
                  state: ToastStates.success,
                  message: 'address deleted successfully',
                );
              } else if (state is DeleteAddressError) {
                showToast(
                  state: ToastStates.error,
                  message: 'something wrong please try again later',
                );
              }
            },
            builder: (context, state) {
              if (state is GetAddressLoading) {
                return const Center(child: CustomLoading());
              } else {
                if (state is GetAddressError) {
                  return NetworkDisconnected(
                    onPress: () {
                      addressCubit.getMyAddressData();
                    },
                  );
                } else {
                  if (addressCubit.addressModel.data.isEmpty) {
                    return SingleChildScrollView(
                      child: EmptyScreen(
                        textBtn: 'Add new address',
                        onPress: () {
                          addressCubit.clearTextFromField();
                          navigateTo(context, RouteConstant.addAddressRoute);
                        },
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CustomText(
                                        text: '${index + 1} - City : ',
                                        fontSize: 18,
                                        textColor: mainColor,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: CustomText(
                                          text:
                                              ' ${addressCubit.addressModel.data[index].city}',
                                          fontSize: 18,
                                          textColor: black,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Color(0XFF5AA0E0),
                                          size: 25.0,
                                        ),
                                        onPressed: () {
                                          addressCubit.initialTextFromField(
                                            city: addressCubit
                                                .addressModel.data[index].city,
                                            addressDetails: addressCubit
                                                .addressModel
                                                .data[index]
                                                .details,
                                            region: addressCubit.addressModel
                                                .data[index].region,
                                            buildingNumber: addressCubit
                                                .addressModel
                                                .data[index]
                                                .buildingNumber,
                                            notes: addressCubit
                                                .addressModel.data[index].notes,
                                          );
                                          navigateWithArgument(
                                            context,
                                            RouteConstant.updateAddressRoute,
                                            index,
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 5.0),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: mainColor,
                                          size: 25.0,
                                        ),
                                        onPressed: () {
                                          addressCubit.deleteAddressData(
                                            addressId: addressCubit
                                                .addressModel.data[index].id,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const CustomDotedLine(),
                              itemCount: addressCubit.addressModel.data.length,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CustomButton(
                            onPressed: () {
                              addressCubit.clearTextFromField();
                              navigateTo(
                                  context, RouteConstant.addAddressRoute);
                            },
                            text: 'Add new address',
                          ),
                        )
                      ],
                    );
                  }
                }
              }
            },
          ),
          onRefresh: () async {
            await Future.wait(
              [addressCubit.getMyAddressData()],
            );
          }),
    );
  }
}
