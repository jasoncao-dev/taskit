import 'package:flutter/material.dart';

import '../theme.dart';
import 'addTask.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: actionBgClr, fixedSize: const Size(120, 45)),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const AddTaskPage()));
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.add,
            size: 18.0,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Add Task',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
