import 'package:gofit/BMR/widgets/constants.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
ThemeData CustomTheme() => ThemeData.light(useMaterial3: true).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: kPrimaryColor,
      ),
      scaffoldBackgroundColor: kBackgroundColor,
      sliderTheme: const SliderThemeData().copyWith(
        activeTrackColor: kButtonColor,
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            kButtonColor,
          ),
        ),
      ),
    );
