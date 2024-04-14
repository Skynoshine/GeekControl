import 'package:flutter/material.dart';

class CoverResponsive {
  static double calcResponsiveWidth(BuildContext context) {
    double responsiveWidth = 0.0;
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heigthScreen = MediaQuery.of(context).size.height;

    if (widthScreen > 800 || heigthScreen > 1080) {
      responsiveWidth = MediaQuery.of(context).size.width * 0.5 / 1.2;
    } else {
      responsiveWidth = MediaQuery.of(context).size.width / 2.1;
    }
    return responsiveWidth;
  }

  static double calcResponsiveHeigth(BuildContext context) {
    double responsiveHeigth = 0.0;
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heigthScreen = MediaQuery.of(context).size.height;

    // Medium
    if (widthScreen > 400 || heigthScreen > 600) {
      responsiveHeigth = MediaQuery.of(context).size.height * 1.4 / 3.5;
    } else {
      responsiveHeigth = MediaQuery.of(context).size.height * 0.3;
    }

    // Tablet
    if (widthScreen > 800 || heigthScreen > 1080) {
      responsiveHeigth = MediaQuery.of(context).size.height * 1.4 / 3.5;
    } else {
      responsiveHeigth = MediaQuery.of(context).size.height * 0.3;
    }
    return responsiveHeigth;
  }
}
