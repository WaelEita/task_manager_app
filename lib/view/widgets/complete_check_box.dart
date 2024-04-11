import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';

class CompleteCheckBox extends StatefulWidget {
  final bool isSelected;
  final Function(bool) onChanged;

  const CompleteCheckBox({
    super.key,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  _CompleteCheckBoxState createState() => _CompleteCheckBoxState();
}

class _CompleteCheckBoxState extends State<CompleteCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.isSelected);
      },
      child: Container(
        color: kSecondary,
        height: 60,
        width: 40,
        child: Center(
          child: widget.isSelected
              ? SvgPicture.asset(
                  AssetsData.checkCircle,
                )
              : const Icon(Icons.circle_outlined, color: black),
        ),
      ),
    );
  }
}
