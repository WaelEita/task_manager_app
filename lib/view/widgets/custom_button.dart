import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/font_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool? isLoading;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Color? containerColor;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.isLoading,
    this.width,
    this.height,
    this.textStyle,
    this.containerColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: containerColor ?? (isLoading ?? false ? Colors.grey : kSecondary),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ?? Styles.boldTextStyle26.copyWith(color: black),
          ),
        ),
      ),
    );
  }
}
