import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants/colors.dart';
import 'custom_text.dart';

class AccountTextFormField extends StatelessWidget {
  final String text;
  final IconData icon;

  const AccountTextFormField({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 45,
        margin: const EdgeInsets.only(right: 10),
        decoration: const BoxDecoration(
          color: lightMainColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                Icon(icon, color: mainColor),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 10.0),
                  child: CustomText(
                    text: text,
                    fontSize: size.width >= 500 ? 18 : size.width / 22,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
