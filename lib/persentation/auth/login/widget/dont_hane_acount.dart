import 'package:flutter/material.dart';
import '../../../../route/route_constant.dart';
import '../../../../shared/components/custom_text.dart';
import '../../../../shared/components/navigate.dart';

import '../../../../shared/constants/colors.dart';

class SingUp extends StatelessWidget {
  const SingUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomText(
            text: "Don't have an Account?",
            fontSize: 15,
          ),
          TextButton(
            onPressed: () => navigateTo(context, RouteConstant.registerRoute),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 20,
                color: mainColor,
                fontFamily: 'RobotoSerif',
              ),
            ),
          )
        ],
      ),
    );
  }
}
