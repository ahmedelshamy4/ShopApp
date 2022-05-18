import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_store/persentation/auth/login/cubit/login_cubit.dart';
import 'package:flutter_shop_store/persentation/auth/logout/cubit/logout_cubit.dart';

import '../../../route/route_constant.dart';
import '../../../shared/components/custom_card.dart';
import '../../../shared/components/custom_text.dart';
import '../../../shared/components/navigate.dart';
import '../../../shared/components/toast.dart';
import '../../../shared/constants/colors.dart';

class SignOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutCubit, LogoutState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            BlocProvider.of<LogoutCubit>(context).userLogout();
          },
          child: CustomCard(
            height: 65.0,
            width: double.infinity,
            widget: Column(
              children: const [
                ListTile(
                  title: CustomText(
                    text: 'Sign out',
                    textColor: red,
                    fontSize: 15.0,
                  ),
                  trailing: Icon(
                    Icons.logout,
                    color: red,
                    size: 32.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          showToast(message: 'logout success', state: ToastStates.success);
          navigatorAndFinish(context, RouteConstant.loginRoute);
        } else if (state is LogoutErrorState) {
          showToast(message: state.message, state: ToastStates.error);
        }
      },
    );
  }
}
