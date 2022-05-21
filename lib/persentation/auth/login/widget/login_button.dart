import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../route/route_constant.dart';
import '../../../../shared/components/custom_button.dart';
import '../../../../shared/components/loading.dart';
import '../../../../shared/components/navigate.dart';
import '../../../../shared/components/toast.dart';
import '../../../bottom_NavBar_screen/cubit/bottom_nav_bar_cubit.dart';
import '../cubit/login_cubit.dart';

class SubmitLogin extends StatelessWidget {
  const SubmitLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.status) {
            navigatorAndFinish(context, RouteConstant.shopLayoutRoute);
          }
        } else if (state is LoginErrorState) {
          showToast(state: ToastStates.error, message: state.error);
        }
      },
      builder: (context, state) => ConditionalBuilder(
        condition: state is! LoginLoadingState,
        builder: (context) => CustomButton(
          onPressed: () {
            BlocProvider.of<BottomNavBarCubit>(context).changeCurrentIndex(2);
            if (loginCubit.formKey.currentState!.validate()) {
              loginCubit.userLogin();
            }
          },
          text: 'Login',
        ),
        fallback: (context) => const Center(
          child: CustomLoading(),
        ),
      ),
    );
  }
}
