import 'package:flutter/material.dart';
import '../../utils/constants/font_styles.dart';

class DetailsStatus extends StatelessWidget {
  const DetailsStatus({Key? key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Task Status',
          style: Styles.boldTextStyle18,
        ),
        SizedBox(height: 15),

      ],
    );
  }
}
