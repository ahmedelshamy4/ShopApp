import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_shop_store/route/route_constant.dart';
import 'package:flutter_shop_store/shared/components/custom_text.dart';
import 'package:flutter_shop_store/shared/components/navigate.dart';

import '../../../../shared/constants/colors.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomText(
          text: 'Already have an Account ?',
          fontSize: 13.0,
        ),
        TextButton(
          onPressed: () => navigateTo(context, RouteConstant.loginRoute),
          child: const Text(
            ' Sign In',
            style: TextStyle(
              fontSize: 20,
              color: mainColor,
              fontFamily: 'RobotoSerif',
            ),
          ),
        )
      ],
    );
  }
}
