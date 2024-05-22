import 'package:gofit/BMR/widgets/constants.dart';
import 'package:flutter/material.dart';

class RectangleIconButton extends StatelessWidget {
  const RectangleIconButton(
      {super.key, required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: kButtonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      constraints: const BoxConstraints.tightFor(height: 40, width: 25),
      elevation: 10,
      onPressed: onPressed,
      child: Icon(icon, color: Colors.white),
    );
  }
}
