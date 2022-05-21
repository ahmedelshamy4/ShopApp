import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../shared/components/account_textFormField.dart';
import '../../../shared/components/custom_text.dart';
import '../../../shared/constants/constant.dart';

class UserDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
          child: CustomText(
            overflow: TextOverflow.clip,
            text: userData.data.name,
          ),
        ),
        AccountTextFormField(
          text: userData.data.phone,
          icon: Icons.phone,
        ),
        AccountTextFormField(
          text: userData.data.email,
          icon: Icons.email,
        )
      ],
    );
  }
}
