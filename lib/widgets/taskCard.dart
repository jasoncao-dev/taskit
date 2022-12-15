import 'package:flutter/material.dart';

import '../theme.dart';

class TaskCard extends StatelessWidget {
  final String name;
  final String note;
  final String tag;
  final String startTime;
  final String endTime;
  final String? date;

  const TaskCard(
      {Key? key,
      required this.name,
      required this.note,
      required this.tag,
      required this.startTime,
      required this.endTime,
      this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
      margin: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: Themes.taskName,
              ),
              const SizedBox(
                width: 8.0,
              ),
              Chip(
                  label: Text(
                    tag,
                    style: const TextStyle(color: actionBgClr, fontSize: 10.0),
                  ),
                  labelPadding:
                      const EdgeInsets.symmetric(vertical: -6, horizontal: 4),
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 8.0),
                  backgroundColor: primaryBgClr),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.schedule_outlined,
                size: 14.0,
                color: secondaryTxtClr,
              ),
              const SizedBox(
                width: 4.0,
              ),
              Text(
                startTime,
                style: Themes.mutedTxtSm,
              ),
              const SizedBox(
                width: 3.0,
              ),
              const Text(
                "-",
                style: Themes.mutedTxtSm,
              ),
              const SizedBox(
                width: 3.0,
              ),
              Text(
                endTime,
                style: Themes.mutedTxtSm,
              ),
              const SizedBox(
                width: 3.0,
              ),
              (date != null)
                  ? Text(
                      'on ${date!}',
                      style: Themes.mutedTxtSm,
                    )
                  : const SizedBox(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 16.0),
            child: Text(
              note,
              style: const TextStyle(color: primaryTxtClr, fontSize: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}
