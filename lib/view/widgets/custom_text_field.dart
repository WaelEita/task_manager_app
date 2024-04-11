import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import 'package:task_manager/utils/constants/font_styles.dart';

class CustomTextField extends StatefulWidget {
  final IconData prefixIcon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final bool obscureText;
  final String title;

  const CustomTextField({
    Key? key,
    required this.prefixIcon,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    this.obscureText = false,
    required this.title,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Styles.textStyle18.copyWith(color: softGrey),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: darkGrey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            obscureText: _obscureText,
            style: Styles.textStyle18,
            cursorColor: white,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              prefixIcon: Icon(
                widget.prefixIcon,
                color: white,
              ),
              suffixIcon: widget.obscureText
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                          widget.controller.selection = TextSelection.collapsed(
                              offset: widget.controller.text.length);
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: white,
                      ),
                    )
                  : null,
              hintStyle: Styles.textStyle18,
              hintText: widget.hintText,
              focusColor: white,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: white),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
