import 'package:flutter/material.dart';
import 'package:task_manager/utils/constants/font_styles.dart';
import 'package:task_manager/view/widgets/custom_button.dart';
import '../../utils/constants/colors.dart';

class ButtonChoiceRow extends StatefulWidget {
  const ButtonChoiceRow({Key? key}) : super(key: key);

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
          },
          width: MediaQuery.of(context).size.width * .4,
          height: 55,
          textStyle: Styles.textStyle14.copyWith(
              color: _selectedIndex == 0 ? black : white),
          containerColor: _selectedIndex == 0 ? kSecondary : Color(0xFF263238),
        ),
        CustomButton(
          text: 'Groups',
          onPressed: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
          width: MediaQuery.of(context).size.width * .4,
          height: 55,
          textStyle: Styles.textStyle14.copyWith(
              color: _selectedIndex == 1 ? black : white),
          containerColor: _selectedIndex == 1 ?kSecondary : Color(0xFF263238),
        ),
      ],
    );
  }
}
