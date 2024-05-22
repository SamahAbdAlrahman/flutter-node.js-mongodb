import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key? key,
    required this.icon,
    required this.color, // Add color parameter
  }) : super(key: key);

  final IconData icon;
  final MaterialColor color; // Declare color parameter

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: color, // Set the background color using the color parameter
        child: Icon(
          icon,
          size: 36,
          color: Colors.white, // Set the icon color to white
        ),
      ),
    );
  }
}
