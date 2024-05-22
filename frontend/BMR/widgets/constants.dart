import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const bool MALE = true;
const bool FEMALE = false;
const kTitleTextStyle = TextStyle(
  fontWeight: FontWeight.w600,
  letterSpacing: 2,
);

const kActiveTitleTextStyle = TextStyle(
  fontWeight: FontWeight.w600,
  letterSpacing: 2,
  color: kButtonColor,
);

const kLabelTextStyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 50,
);

const kResultTextStyle = TextStyle(
  color: kButtonColor,
  fontWeight: FontWeight.w900,
  fontSize: 80,
);

const kResultLabelTextStyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 30,
);

const kResultSmallTextStyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 20,
);

const kPrimaryColor = Color(0xFFF4F6FD);

const kBackgroundColor = Color(0xFFEAEDF9);

const kButtonColor = Colors.deepOrange;

const kAddIcon = Icons.add;

const kMinusIcon = FontAwesomeIcons.minus;

const kBoxShadow = [
  BoxShadow(
    color: Color(0xFFD9D8D8),
    blurRadius: 4,
    spreadRadius: 1,
    offset: Offset(2, 2),
  )
];
