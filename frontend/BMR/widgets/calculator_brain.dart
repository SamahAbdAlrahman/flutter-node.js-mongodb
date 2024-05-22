import 'package:flutter/material.dart';
import 'constants.dart';

class CalculatorBrain {
  final int age, weight, height;
  final bool gender;

  late double _bmr;

  CalculatorBrain({
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
  });

  double _calculateBMRMale() {
    return  88.362 + (13.397 *weight.toDouble()) + (4.799 *height.toDouble()) - (5.677 *age.toDouble());
  }

  double _calculateBMRFemale() {
    return (10 * weight) +
        (6.25 * height)-
        (5 * age) -
        161;


  }

  String _getMaleBMR() {
    _bmr = _calculateBMRMale();
    return _bmr.toStringAsFixed(2);
  }

  String _getFemaleBMR() {
    _bmr = _calculateBMRFemale();
    return _bmr.toStringAsFixed(2);
  }

  bool _isMale() {
    return gender == MALE;
  }

  bool _isFemale() {
    return gender == FEMALE;
  }

  void _checkGenderToCalculate() {
    if (_isMale()) {
      _calculateBMRMale();
    } else if (_isFemale()) {
      _calculateBMRFemale();
    }
  }

  IconData getGenderIcon() {
    if (_isMale()) {
      return Icons.male;
    } else {
      return Icons.female;
    }
  }

  String result() {
    _checkGenderToCalculate();
    if (_isMale()) {
      return _getMaleBMR();
    } else if (_isFemale()) {
      return _getFemaleBMR();
    } else {
      return '';
    }
  }
}
