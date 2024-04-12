import 'package:flutter/material.dart';
import 'package:task_manager/utils/constants/font_styles.dart';
import 'package:task_manager/view/widgets/custom_button.dart';
import '../../utils/constants/colors.dart';

class ButtonChoiceRow extends StatefulWidget {
  final void Function(int) onIndexChanged;

  const ButtonChoiceRow({Key? key, required this.onIndexChanged})
      : super(key: key);

  @override
  _ButtonChoiceRowState createState() => _ButtonChoiceRowState();
}

class _ButtonChoiceRowState extends State<ButtonChoiceRow> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          text: 'My tasks',
          onPressed: () {
            setState(() {
              _selectedIndex = 0;
            });
            widget.onIndexChanged(_selectedIndex);
          },
          width: MediaQuery.of(context).size.width * .4,
          height: 55,
          textStyle: Styles.textStyle14
              .copyWith(color: _selectedIndex == 0 ? black : white),
          containerColor: _selectedIndex == 0 ? kSecondary : const Color(0xFF263238),
        ),
        CustomButton(
          text: 'Groups',
          onPressed: () {
            setState(() {
              _selectedIndex = 1;
            });
            widget.onIndexChanged(_selectedIndex);
          },
          width: MediaQuery.of(context).size.width * .4,
          height: 55,
          textStyle: Styles.textStyle14
              .copyWith(color: _selectedIndex == 1 ? black : white),
          containerColor: _selectedIndex == 1 ? kSecondary : const Color(0xFF263238),
        ),
      ],
    );
  }
}
