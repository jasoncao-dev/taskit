import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme.dart';

class CurrentDate extends StatelessWidget {
  const CurrentDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat.yMMMMd().format(DateTime.now()),
          style: Themes.subheading,
        ),
        const SizedBox(
          height: 8.0,
        ),
        const Text(
          'Today',
          style: Themes.heading,
        ),
      ],
    );
  }
}
