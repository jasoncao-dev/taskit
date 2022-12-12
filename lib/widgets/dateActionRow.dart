import 'package:flutter/material.dart';

import 'addTaskButton.dart';
import 'currentDate.dart';

class DateActionRow extends StatelessWidget {
  const DateActionRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Expanded(
          child: CurrentDate(),
        ),
        AddTaskButton(),
      ],
    );
  }
}
