import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';
import 'custom_button.dart';
import 'custom_card.dart';
import 'custom_text.dart';

class EmptyScreen extends StatelessWidget {
  final String textBtn;
  final VoidCallback onPress;
  const EmptyScreen({
    Key? key,
    this.textBtn = ' Shop Show ',
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0, bottom: 50.0),
              child: SvgPicture.asset(
                'assets/images/empty.svg',
                fit: BoxFit.fitWidth,
                height: 250,
              ),
            ),
            CustomCard(
              widget: Column(
                children: [
                  const SizedBox(height: 10.0),
                  const CustomText(text: 'Empty!', textColor: red),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: CustomText(
                      text: "Looks like you haven't add any item yet.",
                      fontSize: 18,
                      textColor: grey,
                    ),
                  ),
                  CustomButton(
                    text: textBtn,
                    onPressed: onPress,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
