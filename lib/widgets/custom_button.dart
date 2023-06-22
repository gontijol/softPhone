import 'package:flutter/material.dart';
import 'package:smartphone/core/colors.dart';

class CustomGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const CustomGradientButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    required ButtonStyle style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 250,
      height: height ?? 50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5,
            spreadRadius: -4,
            blurStyle: BlurStyle.outer,
            offset: Offset(-2, 4),
          ),
        ],
        gradient: LinearGradient(
          colors: [defaultCyan, Color.fromARGB(255, 5, 165, 136)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.6, 1],
          transform: GradientRotation(3.4),
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
            Colors.black.withOpacity(0.0),
          ),
          elevation: MaterialStateProperty.all<double>(0.0),
          minimumSize: MaterialStateProperty.all<Size>(const Size(250, 50)),
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.black.withOpacity(0.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            shadows: [
              Shadow(
                blurRadius: 1.0,
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0.0, 2.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
