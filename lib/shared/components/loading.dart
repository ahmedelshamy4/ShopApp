import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/colors.dart';

class CustomLoading extends StatelessWidget {
  final double size;
  const CustomLoading({Key? key, this.size = 70.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(
      color: mainColor,
      size: size,
    );
  }
}
