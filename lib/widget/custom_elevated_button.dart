import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final bool isGradient;
  final BoxShadow? boxShadow;
  final List<Color>? gradientColors;
  final VoidCallback onPressed;
  final Color? color;
  final BorderRadius? borderRadius;
  const CustomElevatedButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.borderRadius,
    this.gradientColors,
    this.isGradient = true,
    this.color,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        onPressed();
      }),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          gradient: isGradient
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: gradientColors ??
                      [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor
                      ],
                )
              : null,
          color: (!isGradient) ? color ?? Theme.of(context).primaryColor : null,
          boxShadow: [
            boxShadow ??
                const BoxShadow(
                  blurRadius: 2,
                ),
          ],
        ),
        child: Center(
          child: Container(
            child: child,
          ),
        ),
      ),
    );
  }
}
