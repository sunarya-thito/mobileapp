import 'package:flutter/material.dart';
import 'package:mobileapp/theme.dart';

class GlassPaneElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? borderColor;

  const GlassPaneElevatedButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? kSurfaceColor,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 24,
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        foregroundColor: foregroundColor ?? kSecondaryTextColor,
        elevation: 0,
        side: BorderSide(
          color: borderColor ?? kSurfaceBorderColor,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: child,
    );
  }
}
