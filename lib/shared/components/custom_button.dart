import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final double fontSize;
  final Color buttonColor;
  final double radiusCircular;
  final VoidCallback onPressed;
  final String text;
  final EdgeInsetsGeometry margin;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Color textColor;
  const CustomButton({
    Key? key,
    this.width = double.infinity,
    this.height = 50,
    this.fontSize = 20,
    this.buttonColor = mainColor,
    this.radiusCircular = 10.0,
    required this.onPressed,
    required this.text,
    this.margin = EdgeInsets.zero,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.center,
    this.textColor = white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadiusDirectional.all(
          Radius.circular(radiusCircular),
        ),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        height: height,
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: 'RobotoSerif',
          ),
        ),
      ),
    );
  }
}
