import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../route/route_constant.dart';
import '../../../../shared/components/custom_button.dart';
import '../../../../shared/components/navigate.dart';
import '../../../../shared/components/toast.dart';
import '../cubit/singup_cubit.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerCubit = BlocProvider.of<SingupCubit>(context);

    return BlocConsumer<SingupCubit, SingupState>(
      listener: (context, sate) {
        if (sate is SingupErrorState) {
          showToast(message: sate.error, state: ToastStates.error);
        } else if (sate is SingupSuccessState) {
          showToast(message: 'Register success', state: ToastStates.success);
          navigateTo(context, RouteConstant.loginRoute);
        }
      },
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: CustomButton(
          onPressed: () {
            if (registerCubit.formKey.currentState!.validate()) {
              registerCubit.userRegister();
            }
          },
          text: 'submit',
        ),
      ),
    );
  }
}
