import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_stopwatch_timetracking/application/theme/app_colors.dart';


class AppTheme {
  static ThemeData defaults() {
    final mainFontFamily = 'Avenir Next';

    return ThemeData(
      scaffoldBackgroundColor: AppColors.primaryColorDark,
      textTheme: TextTheme(
        headline1: TextStyle(
          fontFamily: mainFontFamily,
          color: AppColors.mainFontColor,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 96,
          letterSpacing: -1.5,
          height: 112 / 96,
        ),
        headline2: TextStyle(
          fontFamily: mainFontFamily,
          color: AppColors.mainFontColor,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 60,
          letterSpacing: -0.5,
          height: 72 / 60,
        ),
        headline3: TextStyle(
          fontFamily: mainFontFamily,
          color: AppColors.mainFontColor,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 48,
          letterSpacing: 0,
          height: 56 / 48,
        ),
        headline4: TextStyle(
          fontFamily: mainFontFamily,
          color: AppColors.mainFontColor,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 34,
          letterSpacing: 0,
          height: 36 / 34,
        ),
        headline5: TextStyle(
          fontFamily: mainFontFamily,
          color: AppColors.mainFontColor,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 20,
          letterSpacing: 0.15,
          height: 30 / 20,
        ),
        headline6: TextStyle(
          fontFamily: mainFontFamily,
          color: AppColors.mainFontColor,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 18,
          letterSpacing: 0.4,
          height: 24 / 20,
        ),
        subtitle1: TextStyle(
          fontFamily: mainFontFamily,
          color: AppColors.mainFontColor,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 16,
          letterSpacing: 0.15,
          height: 24 / 16,
        ),
        subtitle2: TextStyle(
          fontFamily: mainFontFamily,
          color: AppColors.mainFontColor,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          letterSpacing: 0.1,
          height: 24 / 14,
        ),
        bodyText1: TextStyle(
          fontFamily: mainFontFamily,
          color: AppColors.mainFontColor,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 16,
          letterSpacing: 0.5,
          height: 24 / 16,
        ),
        bodyText2: TextStyle(
          fontFamily: mainFontFamily,
          color: AppColors.mainFontColor,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          letterSpacing: 0.25,
          height: 20 / 14,
        ),
        button: TextStyle(
          fontFamily: mainFontFamily,
          color: AppColors.mainFontColor,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 16,
          letterSpacing: 1,
          height: 16 / 16,
        ),
        caption: TextStyle(
          fontFamily: mainFontFamily,
          color: AppColors.mainFontColor,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 12,
          letterSpacing: 0.4,
          height: 16 / 12,
        ),
      ),
      primaryColor: AppColors.primaryColor,
      primaryColorDark: AppColors.primaryColorDark,
      primaryColorLight: AppColors.primaryColorLight,
      canvasColor: AppColors.canvasColor,
      shadowColor: AppColors.mainFontColor,
      errorColor: AppColors.errorColor,
      textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: AppColors.primaryColorLight,
          cursorColor:  AppColors.secondaryFontColor,
          selectionColor:  AppColors.primaryColorDark
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white, primary: AppColors.primaryColor),
    );
  }
}
